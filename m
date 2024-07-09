Return-Path: <linux-kernel+bounces-245216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60C92AFCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A393282A85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508912E1F1;
	Tue,  9 Jul 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="313ohAfM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758542052
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505318; cv=none; b=HEvg89/4Sz3YTyvrDxIXlBa9cAafaLOj1hFLXJtl4n2VHSfNFZH7W9CBliWdq7y7ohygChkPw3DnRxS7pzuRmMyH+wKkTGkzyUrWWGoz24D4yUB7/I6F6IRgBNkp+ii84q901zjUQyKGzqwa5ePkJ2BIpOJ/HcJlPv96MrXQMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505318; c=relaxed/simple;
	bh=Oq+4LJwEYsddg6PH6FTh7a5tZh/6u1Pps4JmOvvThhQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ow7JIVqmRm/2R/pBdut12BzFH3TisLp1EIeHC5wF4NnvfYholZPKaGicw01TLQFMTFjFS8MAAK1TIwwu56tbK/gU9aslztwWLrdVI2b71b3bgdso0R6vDeNQ03dmtTFhVc9noVFC6VCcaHQo2rN+UBFZqz249Qk70PvfTBzAykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=313ohAfM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af09a7393so3856867b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720505317; x=1721110117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XonkYLkOZkKlKSnNxk97nraZwPsq5QUVQ+TLI0P4dVY=;
        b=313ohAfMlZUT9fsxc3HGQZqcz+lx9alSD8DYBvIFOZI8qyGpggm/RjmnUjWl7PXVWg
         QnB99CeVlniUlMmii1QTY4+3F9mUQRezH++FFNEbQjq7ztirty05TKkGcaYagSc/sq6G
         ZtsTIqq9MfJ7tYIm+ihTpIFIgtmdiK7beXws6oKqZU2nhODj/4JD5IBXNCQkRl7qk550
         86urclVZ2y2iLWCieD2yDlirNidllDw5pDw0Xq9oxR7/tT454FHbjMblcG1EUTBbWOUd
         sXdO/+Qo/7mtrdFKULKOZxw0oR6KpBSrlNR4d8/fz5mrruBxbnj7+geNvlABmxBb4N4s
         xT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720505317; x=1721110117;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XonkYLkOZkKlKSnNxk97nraZwPsq5QUVQ+TLI0P4dVY=;
        b=iWN+PBtMuFT7+mgd7YRBkicwp5/EMsmDC7G3jH2ogu5bhg4V/Us3iuN8tDuWA19z6e
         NteHYxwYNup/9+HsxN7Lw5mJxQiYKTEeQIB4XFmpBEx+CD8fGZdsK8FyIaEFHvLP1r/8
         7j3/AmVdeQXvc2ri514yBYjVTOioJRc0pw1YZxgJkdOQkDB+A+yuKM7COaRKfLPacEfB
         hVQtMjoeQZhTGk7143TSrADyQXTJh5WycCZmuBBOCp4xNJXtUrJooDpXrG+4CuXOANYN
         ZfqB5QwcB7O3+UxRjFr+hlqA8tqhTH2k8HCJSmeHlnOpTiSpvD5NktEBCfT4niQBbheH
         2lZw==
X-Gm-Message-State: AOJu0YyRBIvE7ZmJ/IqsYMFFLj4+nHzNq2BE9pwo2VNHF0IqB43th+SQ
	BJNns1r2A3mbVuce74QEmw7ehiHFTSGIxwRpqmIWTFDjvjO3KtduJb6QapmdMnN9ddKONcC7Pfy
	Da6X0/Co1CBiTrmXnBq1puleq7NcMGJtF4aebkjR1/Ob3ceMxUpIG72E1WYIzwzZ7fDbp3vhw1Z
	/zpTI/1V9Mt/hkffKmEmO1vgcr7SJHMGoX3rvnTULSsuFM
X-Google-Smtp-Source: AGHT+IHwqAUiqp5BhikPh3F5G2BeiPnmXtzH5T5Lxm3piNI2JHpBHOhutpJ00Fyzc5gY5B/xyqErqsFZzaAC
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:1812:b0:705:d750:83f4 with SMTP
 id d2e1a72fcca58-70b4364fb52mr144837b3a.3.1720505316521; Mon, 08 Jul 2024
 23:08:36 -0700 (PDT)
Date: Mon,  8 Jul 2024 23:08:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709060831.495366-1-jstultz@google.com>
Subject: [RESEND][PATCH v2] locking/rwsem: Add __always_inline annotation to
 __down_write_common() and inlined callers
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Tim Murray <timmurray@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Apparently despite it being marked inline, the compiler
may not inline __down_write_common() which makes it difficult
to identify the cause of lock contention, as the wchan of the
blocked function will always be listed as __down_write_common().

So add __always_inline annotation to the common function (as
well as the inlined helper callers) to force it to be inlined
so a more useful blocking function will be listed (via wchan).

This mirrors commit 92cc5d00a431 ("locking/rwsem: Add
__always_inline annotation to __down_read_common() and inlined
callers") which did the same for __down_read_common.

I sort of worry that I'm playing wack-a-mole here, and talking
with compiler people, they tell me inline means nothing, which
makes me want to cry a little. So I'm wondering if we need to
replace all the inlines with __always_inline, or remove them
because either we mean something by it, or not.

Cc: Tim Murray <timmurray@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel-team@android.com
Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reported-by: Tim Murray <timmurray@google.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Add ack tags & minor tweaks to commit message
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c6d17aee4209..33cac79e3994 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1297,7 +1297,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline int __down_write_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 
@@ -1310,12 +1310,12 @@ static inline int __down_write_common(struct rw_semaphore *sem, int state)
 	return ret;
 }
 
-static inline void __down_write(struct rw_semaphore *sem)
+static __always_inline void __down_write(struct rw_semaphore *sem)
 {
 	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static __always_inline int __down_write_killable(struct rw_semaphore *sem)
 {
 	return __down_write_common(sem, TASK_KILLABLE);
 }
-- 
2.45.2.803.g4e1b14247a-goog


