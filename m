Return-Path: <linux-kernel+bounces-448003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FA9F39BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCAC16CD89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70520B7E9;
	Mon, 16 Dec 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7iDGO8O"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517620B1F5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377080; cv=none; b=R7VqfT0IR5ATN8/gGfbRB3PuFLuMrgpR2AHIrYOINuhvKOxgIvLBZvEe5aT+fPbn72fzN+/o43hYGU8bDP0Wxtq7A/MYd2FZpZo9JO78cgZcwhsKIxQJolW0LHQ8hP0E0hGu+l66fE0vWURz3Mrwh2v9ouu85JCiu6hNA0LMAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377080; c=relaxed/simple;
	bh=UPkBiQCnTHMVc7aRHLgwfaCDlFkcN0QzJjPCmja7pxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ti0woS5ChlbQyLoqspS2FZ+v7Jzf+tR0zx0BwDkAEbDWMbtZAhujJPy9H89uwF1HOirgogmKMk3HRJV+t/eY9DHQ1wDupIiL68fDL8B5yyStcOjHh/xGs8sJxnENdRYs0/PQ4T1XO/PbgHcR4Gehy7EHOH80WKcJWOFmwDlo9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7iDGO8O; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216717543b7so70323105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377078; x=1734981878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V23hsekxf1oBAjhtCt33Ew0gdChPa6B6f0O6pWk1TGI=;
        b=r7iDGO8OxOk1nCb7sQbu4njndA3P3nKUXetv+8DO0ODk/H8RX/ImnPJ4RqUwRNui9R
         48H7YoX3bZuR6eSUFFVEA3XRhqz/qKDpG0MSsC2FDvlgX8YAz0pbVH8NbSlvNb9JtBHs
         yUj5AGWCukUevS3OoiRvZ1trk5DGUi5wpzY++0Ke02rvHGm9KQevRimIfkPO2ytYKsbG
         bh0orfMvK8nyj8Owf7C0Ol/u0kw+LlBcm1zcasz2Xyf7Ls9FkQTH5QVPvbIuHnF1VlWO
         H8sL/9LrLyXEWCcfJdS5Q61e6CMkayKhA0leE14A5diNA2YHTEC5l+FVVHgo20/gDGNu
         a17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377078; x=1734981878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V23hsekxf1oBAjhtCt33Ew0gdChPa6B6f0O6pWk1TGI=;
        b=QKyY0bnrAtWubxkF5UtVLDkkVOcNTlq6RCPUj1VEuoHpA5uyO1mOUmjJ31un6EmKqo
         3mg7/RL+vac5grceD465h93Nu1Vbl1fFCA9lmQI+GvdHc8GQt73DbBxumW3aJCcv96Pk
         0chdTxjiS06i1YvMwlk33/W89ivTHj0Bl+olTxK7bEAyH5yMWp+pFRUJUsAzp3oTXlw5
         4hJaNK/05BoVjBae1fVh/gHzjAD81SsfEEsgUZN8F5s5Kx100fv0yKz5GFdZ9nIe5ZU+
         5ySfdFCyXzQth4U8dD6OjOm6kEiotKmiw0F8GKyDhjdHAiQdyu0ZebPI5SDaOP9vbA6H
         /LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAvJlogkFwXOT080Lwe6tyb02cThu0HAtBUWOI/RePEY04DEqLYB5SNLMl0XpzNwjeqtTZIiQUk9dyRtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BRzEy5eNUs2WCiROYsUoLclF6VVRQo+yt3UwjlWrrSUVEEEm
	AZl24ejD35C0qwGwz2qVJxgXaTd85GEF0xxnvE0uJszKhpCuCaIrn2XK2wYiIrK6fCD+joeWseu
	Mvg==
X-Google-Smtp-Source: AGHT+IGOYBhQK/OMn61IKHhYYRKFLZqMwRmmFqwVG/Z+7upwVvTEn0G50CkD9wYvokG+WIRwbcBuoK+avFE=
X-Received: from pjboi5.prod.google.com ([2002:a17:90b:3a05:b0:2ee:53fe:d0fc])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec9:b0:215:4450:54fb
 with SMTP id d9443c01a7336-21892a5c02fmr173665245ad.55.1734377077933; Mon, 16
 Dec 2024 11:24:37 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:10 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-8-surenb@google.com>
Subject: [PATCH v6 07/16] mm: move mmap_init_lock() out of the header file
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

mmap_init_lock() is used only from mm_init() in fork.c, therefore it does
not have to reside in the header file. This move lets us avoid including
additional headers in mmap_lock.h later, when mmap_init_lock() needs to
initialize rcuwait object.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
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
index 57dc5b935f79..8cb19c23e892 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1224,6 +1224,12 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 #endif
 }
 
+static inline void mmap_init_lock(struct mm_struct *mm)
+{
+	init_rwsem(&mm->mmap_lock);
+	mm_lock_seqcount_init(mm);
+}
+
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
-- 
2.47.1.613.gc27f4b7a9f-goog


