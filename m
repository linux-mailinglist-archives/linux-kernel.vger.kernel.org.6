Return-Path: <linux-kernel+bounces-380648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF09AF41B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3349B2202C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC6217318;
	Thu, 24 Oct 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wsNeIRO+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F6215025
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803160; cv=none; b=PXHHUJrowkfk+H+GyDY3DA0Q1l3Twl1dJTube1Ykl2pGTAm+6u6WQ4L6T88ZhGnEddipMvRF2hTLyhvfO4hONfkFH1JXWfB0U/PsVWfnK1vrl4uXBXwSw7O4UScclqfvOfy64SAtHEenBZq8Y4jJhrXtEWqDstZC9r8Ra0QKZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803160; c=relaxed/simple;
	bh=Tiqrh9klsT3iw/ENSuzeYLIMarGnkREYZuWTaAF1OY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dvglx6/o50jn9aKaJ4RNlmqSH0RkgZyjg8+Ti6G0eaHUKYhfYr2a6nQzxDSd4H53cFEKmSSRIxqathDouAYKmmCc7UtbDLmmSV6rDj5tg2XlV/REsoYq+EIKx06Uhgduj6Ut5JxSHSGkAypCLiyVk5GDn24aEyOBVJkCs4svFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wsNeIRO+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso24635097b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729803157; x=1730407957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0cyo47lZvYDA3B5yj4Am2lDN/6HgoSPrlBQwJwKaSA=;
        b=wsNeIRO+WBWtc/LJWSJmuyQNkNycNF62pYF22JQeBKd7LOr8WgnUbnOVutL24Vr+o5
         FBMzZeN7L6XGYi7hvpulvywVpzxNbCVV53S4kY5JrLRqJ9t/RdqRyKl/5XHk6Ih9EqjY
         2kMmbvNTgz5MGU2NCA4oHOdn/g+jws46Q3FZEtMJ+3InYuyj98Z5y0d+M8p1vVKatEY+
         2PlOjgLV0hxiS3xhVWNwo/QckxJR1uh8Sfp8BAYZzBce4J0EXPoiYEMJh2WR5NdGJqnY
         1YZ+nD7O34lj9lOIbIxBG1IOEDJHxao4R5geSInNZPCbvjqpzwB17COV1Fg0F0j7woTx
         lgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803157; x=1730407957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0cyo47lZvYDA3B5yj4Am2lDN/6HgoSPrlBQwJwKaSA=;
        b=dKg+m0U8PskAQb8UMAva0gXWDXavcCHIkwUkDPv1KTa0jIV2BjwvC8DjeTOO6iwZdL
         gs59txEwTLuLJhPL5cChqmCWvI4P6L7A2QG7HkKr9XuQhVDdPYO0Dynm+aWvXTI6eBQ2
         HesxkplsbmWVivpKsApzWyTIeGDp9usMa/AOfVGRkOR5V6AnRaLZgaXeRwrUVQ+qLHs9
         n5KgF2U0Kb292jmTy73DhfKjDhKDld/v8ijQgO0ggFjKQ370HbADThneeb3/flaTVvJz
         Dhw/i6h5nmdBbsfpTCMA0Tbl054zqAFjG3aZ09wED5ndHCYc87Z0oqgUHxGoaY3Suwrc
         R0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Qwk2uT0gStuVWfDX5VUb2RNEG8hNphM3+pKxEFZ8mr8XprXU0mHvXRXtW3auYAWdG2991mpZQvdvahY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq66cnEuu5zt/ybtAnUcbbmg5n6RVcG1JEuYZ+dwEKeNniW6eG
	wAGo+E043qHTnyHbTHxdBVSFA46aWwSgSuO41FhpfTe20JodUxsf6jpcpDK3Fwi2KGuGlESR89u
	YaA==
X-Google-Smtp-Source: AGHT+IFJIBEobTf0M/avBl1t+bIbsxZRvjcy3r9B86GReN1XHKNIk7A8yUrOFNSe7IKPSSD3SbHOyv9e5X4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:47e4:54e:bc8e:cb18])
 (user=surenb job=sendgmr) by 2002:a05:690c:7201:b0:648:fc8a:cd23 with SMTP id
 00721157ae682-6e85815bef1mr1181987b3.2.1729803156923; Thu, 24 Oct 2024
 13:52:36 -0700 (PDT)
Date: Thu, 24 Oct 2024 13:52:31 -0700
In-Reply-To: <20241024205231.1944747-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024205231.1944747-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241024205231.1944747-2-surenb@google.com>
Subject: [PATCH 2/2] mm: introduce mmap_lock_speculation_{begin|end}
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
 include/linux/mmap_lock.h | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 6b3272686860..58dde2e35f7e 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
 	seqcount_init(&mm->mm_lock_seq);
@@ -86,11 +87,35 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
 	do_raw_write_seqcount_end(&mm->mm_lock_seq);
 }
 
-#else
+static inline bool mmap_lock_speculation_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	*seq = raw_read_seqcount(&mm->mm_lock_seq);
+	/* Allow speculation if mmap_lock is not write-locked */
+	return (*seq & 1) == 0;
+}
+
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, unsigned int seq)
+{
+	return !do_read_seqcount_retry(&mm->mm_lock_seq, seq);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
-#endif
+
+static inline bool mmap_lock_speculation_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	return false;
+}
+
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, unsigned int seq)
+{
+	return false;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
-- 
2.47.0.163.g1226f6d8fa-goog


