Return-Path: <linux-kernel+bounces-329588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A5797933F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 21:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122862839E0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8749A84D34;
	Sat, 14 Sep 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLSJkX4i"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7A83CC8
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726343012; cv=none; b=dwSJ3A0Ul56WF1k0q9l5braS6ulpg4aFtTZMp14hxaFiRm8luMy94KtPT3q6QwsSBEWBnI3n6jtLkLDKCD4giaVln/YpV0zzi+p3kMdpxvlKLkQ0piHx9TKjWcdRjFIBbq6R6RbugJPEGyLVli/QDg5FYWf1S8WqK0nDRi6cBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726343012; c=relaxed/simple;
	bh=U2cCl9Ua8jWQK57kBlXB6RNfi7uBBcrdJrIdUDrq9us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k78jvVWqWe9MLHSRXuFlnuckttrPIH6UH1g2GKVKle04AWmgq614EALrmu3L/Mm+1rITZiezDM0OM5Bg+3HbkfBwtr45FonAAQNwXW30JN+R9Fbeo8ytHs3/buwNqwHasgpTgDLsfZAaGHBb2NS++ReXFUtQ63v4NqwDHaAtOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLSJkX4i; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7191ee537cbso2349767b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726343011; x=1726947811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMqUitFjkcZcjYpS18hn6NOxdl1sw7VhZop5Rjz/ORE=;
        b=lLSJkX4iBhKHUtY+0QoKZ31drSS7HjEO3ayHUElMKLR33yGuVKE/re7dpsl2mExJJL
         3EwtwaM6rXvwzx4CGPj3KS7125rgCglpatpuIrIcDnd+Gn/fahg4uInVSq5qfTUMFrvq
         +MKruVM22ER1rvryWHGv9trXffESZ26cqe8iEXVfTyAegQGpqWmguoo7qnvUPbWb1jrW
         rSf9diR2rsZBur/rq3TDQhtN7mYp5dpjnA3+WwQxja3jlTdSf3DnQQ34ZzE6n+GR9bkB
         qi+JOOoS2ylQH8+UGJGBJTbbOL59CU/gUUdsbqLY4U4Y/ot1K4H5FAd4Kyls1peui1ge
         RYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726343011; x=1726947811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMqUitFjkcZcjYpS18hn6NOxdl1sw7VhZop5Rjz/ORE=;
        b=qg8r8iigdrUaswp4bUZ+rwmAYHWCHDK378FAf6jADvkj6OfWrRq7bZts7u38sK6+m+
         JAwAiOUjGWVfByXr8A40ECvtQZtRl2S+kwOeltV2QS/pdbwwS7IEhHtnbHnb04W9yOw5
         XbE03QdadsjSo6+frWjCkhs4jQqN7/XGYEWdg97tWQDupIkYYJibpGP9NjyOggULbFL1
         UVmb/a7CRVvJZo/GJZUehoEV/iZesu3vwYMhQPMT5amKkHXQXycZSojf3SRl5vDnAz1X
         KO5JHWlJOMXj2s1/PiqF6oMQ9wwcUix/nONXFgrCnmz1ZK537dHbKAg6Iy5Gc7TJU3HB
         nMag==
X-Forwarded-Encrypted: i=1; AJvYcCWWhiwV9FWQJetYKB004s7eicioW0LBm8TjQ/J/01K2MkQeO3H228ZY5+1PbHK/nXieGSP++DM+juD/Npw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NfWXDyC5aqqNExwf7Vn4jJDO5nWejZb9DKKp96jyBI8Ak4lz
	kUDpPB1UG1gHyFdwpVfUcHxJDLHtW8MleyQLsEGjcvHbp/PfuLi+ifpkjA==
X-Google-Smtp-Source: AGHT+IGbSz5ZrbkdFVY2/IUM0yAh9WDYo41O7oqGgog7gsBuZxxoqHgZ7U8FgzUcNxgXkrRlAxoFeQ==
X-Received: by 2002:a05:6a21:4a41:b0:1cf:3b0b:d723 with SMTP id adf61e73a8af0-1cf75c7ed30mr14321637637.8.1726343010479;
        Sat, 14 Sep 2024 12:43:30 -0700 (PDT)
Received: from localhost.localdomain (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944a9cab5sm1294742b3a.5.2024.09.14.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 12:43:29 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Muchun Song <muchun.song@linux.dev>,
	syzbot <syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	syzkaller-bugs@googlegroups.com
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/2] mm: Change vmf_anon_prepare() to __vmf_anon_prepare()
Date: Sat, 14 Sep 2024 12:41:18 -0700
Message-ID: <20240914194243.245-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <7B2E5B76-8FC6-49EA-B0B3-2452ED6ABC5D@linux.dev>
References: <7B2E5B76-8FC6-49EA-B0B3-2452ED6ABC5D@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some callers of vmf_anon_prepare() may not want us to release the
per-VMA lock ourselves. Rename vmf_anon_prepare() to
__vmf_anon_prepare() and let the callers drop the lock when desired.

Also, make vmf_anon_prepare() a wrapper that releases the per-VMA lock
itself for any callers that don't care.

This is in preparation to fix this bug reported by syzbot:
https://lore.kernel.org/linux-mm/00000000000067c20b06219fbc26@google.com/

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/internal.h | 11 ++++++++++-
 mm/memory.c   |  8 +++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 44c8dec1f0d7..93083bbeeefa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -320,7 +320,16 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
 		wake_up(wqh);
 }
 
-vm_fault_t vmf_anon_prepare(struct vm_fault *vmf);
+vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf);
+static inline vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+{
+	vm_fault_t ret = __vmf_anon_prepare(vmf);
+
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vmf->vma);
+	return ret;
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
diff --git a/mm/memory.c b/mm/memory.c
index 36f655eb66c4..d564737255f8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3262,7 +3262,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 }
 
 /**
- * vmf_anon_prepare - Prepare to handle an anonymous fault.
+ * __vmf_anon_prepare - Prepare to handle an anonymous fault.
  * @vmf: The vm_fault descriptor passed from the fault handler.
  *
  * When preparing to insert an anonymous page into a VMA from a
@@ -3276,7 +3276,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
  * Return: 0 if fault handling can proceed.  Any other value should be
  * returned to the caller.
  */
-vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
@@ -3284,10 +3284,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 	if (likely(vma->anon_vma))
 		return 0;
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		if (!mmap_read_trylock(vma->vm_mm)) {
-			vma_end_read(vma);
+		if (!mmap_read_trylock(vma->vm_mm))
 			return VM_FAULT_RETRY;
-		}
 	}
 	if (__anon_vma_prepare(vma))
 		ret = VM_FAULT_OOM;
-- 
2.45.0


