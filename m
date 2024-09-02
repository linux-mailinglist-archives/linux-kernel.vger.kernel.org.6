Return-Path: <linux-kernel+bounces-311956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E0969008
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC1228374D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED42187860;
	Mon,  2 Sep 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7MqEEuk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD5187340
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317422; cv=none; b=CCpaXB30NQy/ThVaJ3krbzO7hZoWfI1LWrh7um8hVsaPg5V+9nHE4NATbnBJoShgHBFQPesA/6tnhc+XnYT3ttzq9kNmjPKxIE4yVWJTgKnLZP9ZilDfGFxNF2FPjl0lg4Ejwb0OnJXyr0+VH4rG12tCYjso61IqMBnBscRc+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317422; c=relaxed/simple;
	bh=gtquO6G2dDCRlMUENwyAYmUbTBkGxi0+cVSoWPhVG3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aoFKRRaXvG4w5TzcSQmX2HZZ0Rt/WSb1gWvCpRq/hOVUnG5nWXLE6ZFMsPcgHh5qvvZbvrgbVtXyBkAM6wFKmsUEVbyU8IPykKx0uHpgKDLDWPto9YpAjv5MUHrrmZ9hwcDFbj/z3CimMjS6eDLf0ViGbgACueuZk7tSFyMb21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7MqEEuk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso2722487b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317420; x=1725922220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0w7lkXpo1g+CHmrmflvgRnAVSJTT4Wmu8BjVnTGsv2g=;
        b=Z7MqEEuk7Lld2zhInzqKiZZpe2aX6zgG73/Ek59PBoyid0mZ8J16RlStA1hhRnWZT6
         S8Y8kQZYtrsaVcNDebYMhqXzXNdmoiguQPQ6WejLL+0j1cmDQkWIx1s8HCUacYPuUreB
         F7U7bLroV5AAfZpi/LChRjOuBurppFLalPrIsPAjpjakmwQ/y/LMt4NhfSwZsd3LfpDy
         w9r+X9JBqu7QHPf/WFY3sBdd0YGZXiZH8m6tWJS0RgyGLZwgwa0SLpBaosykNeXAe5u7
         86jYhG07Ibz6/G/unKISO84074XSVO3HlO5AkFXITofJqUthihahwqm7y7y1eDX/2kVy
         Mmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317420; x=1725922220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0w7lkXpo1g+CHmrmflvgRnAVSJTT4Wmu8BjVnTGsv2g=;
        b=JBj3B5rql8OW5Rh4ZfIWkwAS/BBx/w7SRxgEbfPmfFi1+gp3Oy8iBGoCWYHQrc4qP9
         ks3bdPZ84gVTPsgzUxyDU8P4Cwbv2dJlQupFHYisMxZf77woSRYiDUbQVGt6FqPWdCdQ
         Ex3iuL2LuCprtRhIvRzLqu/1OMXgeDSywaQfUA34t6KwP5MWZwghRgJZ/+DJDn32C6zE
         3c/ruAId1tEfN5k7gu87vsEpNll2p0A9hcCGBz3soop+XJ3pLfmLbt6a4at89ZVKgvHN
         b4w5ARVUGcijKPci6U0CGBiEWYxibu7s2RzqOZH0hb35qGFihbIaqz4xWKD0nDduu20z
         FpYA==
X-Gm-Message-State: AOJu0Yw5js8QbAn+YW3oaxt/evF07xlcDkch3/T4AxEu4xxMpAsXYtYd
	MDXwITZi483jztpnJckXxxFQWtrnbcT5GLGC8LYK3LcAxd4E2No1
X-Google-Smtp-Source: AGHT+IGOOEgseY3taJzvPKMOGi4cJwnXK3ju8YNTsH2qFP+1eIRtKzWkc/8EV0t5wRt0gIkoTyO4Lg==
X-Received: by 2002:a05:6a00:1a93:b0:705:b0c0:d7d7 with SMTP id d2e1a72fcca58-7173fa3dcb9mr7623930b3a.7.1725317420331;
        Mon, 02 Sep 2024 15:50:20 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:c91e:9f1a:31db:cd2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5577263sm7338284b3a.21.2024.09.02.15.50.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Sep 2024 15:50:19 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to reduce the lock duration
Date: Tue,  3 Sep 2024 10:50:09 +1200
Message-Id: <20240902225009.34576-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The mmap_write_lock() can block all access to the VMAs, for example page
faults. Performing memory allocation while holding this lock may trigger
direct reclamation, leading to others being queued in the rwsem for an
extended period.
We've observed that the allocation can sometimes take more than 300ms,
significantly blocking other threads. The user interface sometimes
becomes less responsive as a result. To prevent this, let's move the
allocation outside of the write lock.
A potential side effect could be an extra alloc_page() for the second
thread executing binder_install_single_page() while the first thread
has done it earlier. However, according to Tangquan's 48-hour profiling
using monkey, the likelihood of this occurring is minimal, with a ratio
of only 1 in 2400. Compared to the significantly costly rwsem, this is
negligible.
On the other hand, holding a write lock without making any VMA
modifications appears questionable and likely incorrect. While this
patch focuses on reducing the lock duration, future updates may aim
to eliminate the write lock entirely.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve Hjønnevåg" <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Tested-by: Tangquan Zheng <zhengtangquan@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/android/binder_alloc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b3acbc4174fb..f20074e23a7c 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -227,13 +227,23 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	if (!mmget_not_zero(alloc->mm))
 		return -ESRCH;
 
+	/*
+	 * Don't allocate page in mmap_write_lock, this can block
+	 * mmap_rwsem for a long time; Meanwhile, allocation failure
+	 * doesn't necessarily need to return -ENOMEM, if lru_page
+	 * has been installed, we can still return 0(success).
+	 */
+	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+
 	/*
 	 * Protected with mmap_sem in write mode as multiple tasks
 	 * might race to install the same page.
 	 */
 	mmap_write_lock(alloc->mm);
-	if (binder_get_installed_page(lru_page))
+	if (binder_get_installed_page(lru_page)) {
+		ret = 1;
 		goto out;
+	}
 
 	if (!alloc->vma) {
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
@@ -241,7 +251,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
 	if (!page) {
 		pr_err("%d: failed to allocate page\n", alloc->pid);
 		ret = -ENOMEM;
@@ -252,7 +261,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	if (ret) {
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->buffer, ret);
-		__free_page(page);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -262,7 +270,9 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 out:
 	mmap_write_unlock(alloc->mm);
 	mmput_async(alloc->mm);
-	return ret;
+	if (ret && page)
+		__free_page(page);
+	return ret < 0 ? ret : 0;
 }
 
 static int binder_install_buffer_pages(struct binder_alloc *alloc,
-- 
2.39.3 (Apple Git-146)


