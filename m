Return-Path: <linux-kernel+bounces-430257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A738C9E2F83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3079B3E025
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D420D4E9;
	Tue,  3 Dec 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKLgLIlo"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356620C483
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262937; cv=none; b=hrThPLhtn/M1QzrkwiaAytmfR9XhJ/eofmxxktqNHQQ1asA0NvlTjVXp3UppkQ1TJHIBMLSsAa2/Fgx8qstn8mMgZguQ5uZ1JcloYlmr27POSZxPkmTQjlpM1YYvsAaxCEyeAl3pjMI0mguS/RqmRSvviCJAOyGnHXsFyxkCEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262937; c=relaxed/simple;
	bh=jIMFjQIvhAgRch+NfQnhZsI2ErhgVUwZ3o5/ejm7D+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iFopj49U0jM94ApNF1uooQ0VpcSmzV67yjnuqjfuHybz5Sw7qh5Y5Gz1F7DE1JZ/+6TnZOH3GOH9XT5XUYO0Uzu57Z7yX2j51AXc7iDPhD63dcaJlabUwweThYFPxtbH1VLH3Kgqj5rY9SAU2+lLLWfG2xY3YlWzK/59g9TBzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKLgLIlo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eaa7b24162so5784783a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262935; x=1733867735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/YUxHrv+12gMgYKuvcmKD0rUQxPjfYrLN7M2OuFebg=;
        b=yKLgLIlokq5V+ufUQICxYupEssXKyMWfzq3lX/4JWLr8DGNWVr+7TijBstvSZzcmlU
         Odk+eLIoPl1MHpbJBw6ZrXxshs8+OuBeEPSSUtGbt2h6blhLQ/tPrPH+uA0qE8cwGVEF
         BMoFAb+NDNPrMHGWShYy2t2VCDBAvE0GOfrY3dGh9QIiweB90virZSasmXW38LX1W7eS
         QlJE/iFtJzJdMJp0ALqZjozt1GN64nJ7SpRJ3b67KiHlVoZu9PRLUM9lT0r6cMVO49yS
         A1fEBZWWyH4LvEb1bVn0g06QKASwzAoxM553hCszdKdqYtXi/qKMf1y+YgOiBirFlexe
         1d5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262935; x=1733867735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/YUxHrv+12gMgYKuvcmKD0rUQxPjfYrLN7M2OuFebg=;
        b=B6/YUa0xWPtuILOVboxifk1DU81W6+jdmSfyqo0AJGncNSgja0SQsWL6s1QVL8iJxN
         NY4cHNhZipmyZHnEL8z5o7gBPhIvEpdOvhRbkqdoE8O1I2GuBRc7R4zc5NjwmT6leo7O
         vsMJItS4PxCBq/kgi7mAG3I6Skp4vuE8ShAd5xSVzFQzPukKwfMbqqUWi/vD1+j+xJ5K
         wli1WvvizdrRjtgSRIQ7AV+kQs3iWjGLbWoFF9RgVRXCARScdlj3n7dsuo2rQMKzm0a5
         nFKjvh3P9vne3vbCKQagi5P47hJjCA/UlMJ4OSLR466bFZdS9LR5AL0jnO4zROGL2QYC
         U0lw==
X-Gm-Message-State: AOJu0Yx0v5+vWHsa2CXjq77P12hyBW03VsIBd2agclTqsYyYXN75rmpZ
	bsC/tcz4GoKY3pO8jjjSChJGCjpYOJEogsqCHmBU0swHRsVSvECg8BMGM3FklLF0t023cksSSx/
	7UOsQBrSQNA==
X-Google-Smtp-Source: AGHT+IFgwsMtaHHxjbSQxacD0z3q6fPbkuXcnUeDrn4WSoJt5ZuqpkWhaWpRj8qcKcYD7ihEUfE6hGoZoQEPXw==
X-Received: from pfbbx24.prod.google.com ([2002:a05:6a00:4298:b0:724:f73b:3c65])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:8403:b0:1e0:be48:177d with SMTP id adf61e73a8af0-1e1653a798dmr6811031637.3.1733262935391;
 Tue, 03 Dec 2024 13:55:35 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:43 +0000
In-Reply-To: <20241203215452.2820071-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-10-cmllamas@google.com>
Subject: [PATCH v6 9/9] binder: use per-vma lock in page reclaiming
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
index 5a221296b30c..b58b54f253e6 100644
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


