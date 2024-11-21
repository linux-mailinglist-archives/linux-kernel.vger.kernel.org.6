Return-Path: <linux-kernel+bounces-417216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFD9D50B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFC21F23876
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D5A1A0704;
	Thu, 21 Nov 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQGlhauj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389B1A01BE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206515; cv=none; b=TkgwCKBMgoLHAc4gjbF1zG9WTCA7aVOLcai66hZbyCp4afQ/CEuUniL0SomUsDvPv/i5gtoTMbvq+lvaubkr0sUxBmMSI/lTQSwrpRiPBfXG7Ke6ooZDHgxfr3HpQueA9OIUP9kiJZpkn4GQTAybhgMhCq1rm0esyuLaTwXChds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206515; c=relaxed/simple;
	bh=0cGFM5Tz10k/PWBMSvTw4nJ4XsF6jHsPadZ8w0eUSBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S4w0bZUZiRfXtlyGK/39wK1CyU4E3E7JUtfgrhFHoz3YmrNyD4+riitFoKOXHFdwP7B66GoFkncJwFcTlEVjq0Bq2ybVSlR8bdw6njEx1SqwLeSwjDJPsp1eEnP5bq3j5vXntWYDPGWyMEWGlGZjh6X0qarR2ERyTp8eGxNQYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQGlhauj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e38dbc5d05bso1908145276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732206513; x=1732811313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aR8IuZPS55VJxAfGr69rX+AU9gT7VgeBh1eRZ8ctshE=;
        b=XQGlhaujR950UgL713oUetI3yXdgtFC7bw+ZFL8kVoz0wwReKGdcodpGMseW5UlfYA
         eoEW2uiLR48mzv5P7KX/MXQRMXCGNqNgOMF/61UjpgC4WleouGCN3Og4E7gc24ouDmAN
         tUQCgMYjxnnWgPZgBDoiCsqmXnwhJGldnPbOiiCZTmBMg/NomHjb6lwX7FKZeXzeRNf5
         7CNuq3k+G3knxAW5ILCZXSu9OmlbtV9+S/ytqRMDKlyL2v7ao2m4A1FMEYPeuwMMN+zc
         aVqzHVWHxXvgEVgeA214+js3fmgaUyVYD/VCeqd8uOGp3LUCUGmk7rV5dkG+bUYB1dDp
         +Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206513; x=1732811313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aR8IuZPS55VJxAfGr69rX+AU9gT7VgeBh1eRZ8ctshE=;
        b=YKl1t1WR/t68abcV5XfEjgU7LqOO2mHb+BobxOLswtlMKhsWgWedopmXeYGNBO7FnE
         e7foKuQ57FxM32qVGkMo0TNnW8lxsgiAuZDWOhYZC5JdhjK8CahEz34yXh0L30Cnuw38
         OunPl8Te5H/p+spU/b7kYkWIgsZNnQXnReNvtgczFrtsu8weCfUTCouGX7CGquIWXSFo
         0MAbKAXesiH+Hg978kSi9petFuxN9YzgZbxJ7SelHTFPIwP2IuJGjqtHU0DL8fUZUWtw
         3Lj3XVnHEqEySRNV0GN36U4yVLSYnKFW5NAdDeB18Wxi6tQMPZUkcnyYMDHZfWD5yfkm
         AyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE4esqpE/fLrmxFUwg31u+b8u3YFBvm1xRw5WEuBb6hbvQyav/UPq3KmiHrKF4s0IYL8ePQzEqI1dbjkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZ6Q1ZkAiaieezwxIkX8h5mVL4E7IDJrzRmHosIKIAlUOzhMd
	0JgaWDsYYgF8bgYEOWgfCeeE5zTvvh/AImL9LRKqWLsbv+90BrLrw87TJgOWRzysROBMu4NoJvt
	4ow==
X-Google-Smtp-Source: AGHT+IHUqHsAWi+Wxn16ObPiD6xo041RvCrQwuBa4MVJn53Kia7YFyxv9Td6tAJu+eIvJbInkjv+ljJDVwE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:ab6:ec44:b69c:2388])
 (user=surenb job=sendgmr) by 2002:a25:dcc5:0:b0:e30:be64:f7e6 with SMTP id
 3f1490d57ef6-e38cb566988mr3028276.3.1732206512791; Thu, 21 Nov 2024 08:28:32
 -0800 (PST)
Date: Thu, 21 Nov 2024 08:28:26 -0800
In-Reply-To: <20241121162826.987947-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121162826.987947-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241121162826.987947-3-surenb@google.com>
Subject: [PATCH v2 3/3] mm: introduce mmap_lock_speculate_{try_begin|retry}
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, andrii@kernel.org, jannh@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add helper functions to speculatively perform operations without
read-locking mmap_lock, expecting that mmap_lock will not be
write-locked and mm is not modified from under us.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]
- Changed to use new raw_seqcount_try_begin() API, per Peter Zijlstra
- Renamed mmap_lock_speculation_{begin|end} into
mmap_lock_speculate_{try_begin|retry}, per Peter Zijlstra

Note: the return value of mmap_lock_speculate_retry() is opposive to
what it was in mmap_lock_speculation_end(). true now means speculation failed.

[1] https://lore.kernel.org/all/20241024205231.1944747-2-surenb@google.com/

 include/linux/mmap_lock.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 083b7fa2588e..0b39a0f99a3b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
 	seqcount_init(&mm->mm_lock_seq);
@@ -86,11 +87,39 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
 	do_raw_write_seqcount_end(&mm->mm_lock_seq);
 }
 
-#else
+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	/*
+	 * Since mmap_lock is a sleeping lock, and waiting for it to become
+	 * unlocked is more or less equivalent with taking it ourselves, don't
+	 * bother with the speculative path if mmap_lock is already write-locked
+	 * and take the slow path, which takes the lock.
+	 */
+	return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
+}
+
+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
+{
+	return do_read_seqcount_retry(&mm->mm_lock_seq, seq);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
-#endif
+
+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	return false;
+}
+
+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
+{
+	return true;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
-- 
2.47.0.338.g60cca15819-goog


