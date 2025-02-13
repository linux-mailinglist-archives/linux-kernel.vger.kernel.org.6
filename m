Return-Path: <linux-kernel+bounces-514029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF9A3517E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AC11880902
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3AC274270;
	Thu, 13 Feb 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNddyp9Y"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7437271824
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486838; cv=none; b=Y2oDole1A7BbGkhhI/FR0EDpGSaDPa2pyBCIbY80orfFjdlXBo9gXJqqbhK0CgZSDifhzsJFPpt+YFBCxQIGInM5Ru6AU5qlKpzKbDMafCmoyMP6RiqDHv2ahaQ2BOMttTM8kjrcvnuwtJbVLaJIUZ+V9bIfzypi/+VzFqtgpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486838; c=relaxed/simple;
	bh=jd3zK0O73VvJ9q8T3yi04/lCfi5p05ochW8W4AzVfqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQUPUX/ZL1E/MKm5KlslV8XgQVN0Q7dWDJHVOgqT8H0icxbyUGQE+/8WvjJ2Nw4+ClZlkN4XJOYjoFnioCvkkolu/N4PREgwQt80n/BOA9WMc0UURwIT6+XjS2hOHujM6jbGoUYm5z4qTTDkwlo1TrnBqESgJM2ML+a8nrU75gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNddyp9Y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso2828768a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486836; x=1740091636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeBZHGW/4v8XWLim1qpAbGeBbAKuN/isMOjrQKZ6x9o=;
        b=lNddyp9YUtSkjoGkvm+zgCFC8vAIcGIm5M4oJWQj1sBdmhLrzEkbS+Qx7af4su84MH
         ft/poeZYLBq43pNX92CDKA839VnY68hfVWVaBGkfO4TM708x8WcfQWEXL4Lv9fCw79Wy
         d7GMkDbJpAzyGa+ZwQ2yn+Jy6C9KX+0R2fXAzyWaxySeRn0sugRxJokKkEOycXVRoTY6
         D18CEZuMCHfM8qy/IlRmoCRXJZwIRXLS59qty9/K0cD7Pc/T5jAoBJ3GgLGLQiGl5mQd
         K3sxJwMrVm5NpJ9DHUz9UCrN3Hv4Z0uK4vRQo7wwd7A68qMP2Ipx6j51KaVVQXscaMce
         DMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486836; x=1740091636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeBZHGW/4v8XWLim1qpAbGeBbAKuN/isMOjrQKZ6x9o=;
        b=HK8SzdON0tG4q7iWuOkHWVpcy9HQGTZ89m2uYA8jIIJT2nE+TKUNlZFmVxoCCZXcGR
         /9uMRn7jR1yFxoKQ9NTy/GazezClJSnCpngrA23jZctLGdQiF8CEx6BORupCTwsJ7+l6
         xwayLeb+WaRFCpmf4p0Ap68wxQPqtdPGDxMa+XHXu9PocpdCYfQC+aZGwhwaO4X6mnMr
         Z1UXl0qsa8eHBdg1332zo6VDoDT4Ji5ApkuUoN3ssOTqdFmSACQLQHQWBclObrimANNj
         IuNzAvI1j7n7Bg2BBu/2k52+u5PX5EaouHPkTBth5RhxIRRcAgToo0afQmlA1s3oCwZq
         /PdA==
X-Forwarded-Encrypted: i=1; AJvYcCUuXlnuyUcC3aMN7EWsZta+FAmde57fLTscYq5kp70pozMV0GCD3DYECYcrfoK0OIrbYdPPZ7tWuQSlvrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVKGTBeH6sB7QhGfBaa9qEtTv6qfO5bubhabbPPiBJJQs88wB
	HynSU5AdtO7edZI96gZ9RyL56tKQ12PbF3dSW5dyVXC/E0agHlatzum5q4pNFLdsEGXuaf/eDNa
	LwQ==
X-Google-Smtp-Source: AGHT+IHfEnz0nPhbgU0f7q7Auc5HNsVT5eJa8wXZ0ZtBNf3PSVTzFb4/Oj/O6W2xc+itT5Ikm9K7oZ7OyHo=
X-Received: from pgvm22.prod.google.com ([2002:a65:62d6:0:b0:ada:4ec0:a7cd])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:512:b0:1e0:ca33:8ccf
 with SMTP id adf61e73a8af0-1ee6b416346mr10537954637.34.1739486836048; Thu, 13
 Feb 2025 14:47:16 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:45 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-9-surenb@google.com>
Subject: [PATCH v10 08/18] mm: move mmap_init_lock() out of the header file
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

mmap_init_lock() is used only from mm_init() in fork.c, therefore it does
not have to reside in the header file. This move lets us avoid including
additional headers in mmap_lock.h later, when mmap_init_lock() needs to
initialize rcuwait object.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes since v9 [1]:
- Drop inline for mmap_init_lock(), per Lorenzo Stoakes
- Add Reviewed-by, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-9-surenb@google.com/

 include/linux/mmap_lock.h | 6 ------
 kernel/fork.c             | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 45a21faa3ff6..4706c6769902 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -122,12 +122,6 @@ static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
-static inline void mmap_init_lock(struct mm_struct *mm)
-{
-	init_rwsem(&mm->mmap_lock);
-	mm_lock_seqcount_init(mm);
-}
-
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
diff --git a/kernel/fork.c b/kernel/fork.c
index 5bf3e407c795..f1af413e5aa4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1230,6 +1230,12 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 #endif
 }
 
+static void mmap_init_lock(struct mm_struct *mm)
+{
+	init_rwsem(&mm->mmap_lock);
+	mm_lock_seqcount_init(mm);
+}
+
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
-- 
2.48.1.601.g30ceb7b040-goog


