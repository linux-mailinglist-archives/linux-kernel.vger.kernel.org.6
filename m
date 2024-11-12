Return-Path: <linux-kernel+bounces-406646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E67FD9C61BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7961F2495D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D521A4CC;
	Tue, 12 Nov 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkP5MJ6O"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA921A4C6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440823; cv=none; b=ATsmyOnqLDApHh4gi20UbrcsJ+FgHFTmYme0z6bCMILqWlav1St6wBwhEU9BJxHC1ie/SEbvrg3VkdjxMa+FXsTTxBu2ASd4/uRbe8HM5rHWs3HRah7BnoTPZ7swXMFSRd6Ee9mvTKv3D25xZC6BQvbwNuA9qmxgWJ08twl+kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440823; c=relaxed/simple;
	bh=Bk3JmIqFlFNA/Td+GSGIS1FDDRd/v1DLJqTNycxwKlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3g/gyRvOwjdh6H8TW/pS/+5RVDGNn/hsIUVw8fMm6C5hRxav/eYOzZ5GC8BKzJW4i2PUCzBxJjcMa2phGHK+/el76MfE6+R72KZ3Cg3FA7QVUlXPJxSD8ZuVyEDSe7fo2J/QU+W5sMFkRsToYOPRgy1eDSlVTnRs662P4uezFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VkP5MJ6O; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33140094so106910167b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440821; x=1732045621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUwaf5ZgB/1FQH1yPsvN8djw+8+0TDY9z5rOH6D3QU0=;
        b=VkP5MJ6O8tENZoZZ3Mq5UThceI2+6/UHghUdNod+Fexzz2E066TK3tvlFyXbyuThXI
         Bf4nB9SwvwDJBWTM8i0acddxRnlwILAX0bL3YJdk+3zzY0fpHaZcmy1MZ1ckVXzIi1x4
         XI+zWUSkVcw9YEOII8zr7/u0ls+x5YkqsID+VkcxsM16jd8gZmWYJJMjsiTdXjEdsMqV
         8WUDtDCvvebAKeXvgkO8j7uEvXwr/kRiIqXiGJZG7/WGflqv2SbVWC3hEDAAkbV0s1DC
         z3I3VxhsWeamvQVxE4hOKJOQ/CaZeQnwnXUZTHC1PLY3bxG+d4F61MhDnaJfZfRvQFkJ
         djOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440821; x=1732045621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUwaf5ZgB/1FQH1yPsvN8djw+8+0TDY9z5rOH6D3QU0=;
        b=HMMELVfAqpRN1zKEpnnq5+OUzLNy3mjfISDOS00oPniIMHG+Txc07+AzvWznNm8Y0B
         D5Tq7krAiLkcKtNfEcZtfefBU79u/fO67qt1QwUWFi4ACiOtQamhTRQ/5Aeoqa/K2/9J
         NoOtDRPPizSyTmW8MKGMVh1Fl2MYnANsSI+VX85P8+4cXXY6pPySnYx7WznJ+6De8SbB
         tSU1yQ5tIGr+OEUHvTtTZlA0X4KtR+RSMyzppzY6yGQRMVSewWL2b6JMoU4aQBlD/26s
         8XxDPziOyPQY0v6gHpu2dlzMvEPxPHIZL+smh+UD4kMs499beSlWjHknI+gdNMvq5kni
         v6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXygba4s0kzYQaeemFyuW0nkAXxPUSQBvPIyxytia7hhQcJHQqldcCwXDKUVYo/S8koLXSErh09f7Izr08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+pPIZeTdaALxCkhQhONY3MtbrsvwuSI56xinpstGnZscRgSQ9
	EUMUwNekhw2esbXgNO3uEuCby92zHTw8Hn7uJHditU7VFz8J9J283ZqZ1BXqwKPnjBT3mQy+jLA
	Qtg==
X-Google-Smtp-Source: AGHT+IGaC6PuAhu3pWt6DipZ12u32jxx/tWme6oiVJjTtPaAPq0Tli46qIKCkEtg3rNyPGo2HA9JrDSEFng=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cad5:5dc6:1298:ec42])
 (user=surenb job=sendgmr) by 2002:a05:690c:6608:b0:6de:19f:34d7 with SMTP id
 00721157ae682-6ecb31b51f7mr2737b3.2.1731440820935; Tue, 12 Nov 2024 11:47:00
 -0800 (PST)
Date: Tue, 12 Nov 2024 11:46:35 -0800
In-Reply-To: <20241112194635.444146-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112194635.444146-6-surenb@google.com>
Subject: [PATCH v2 5/5] docs/mm: document latest changes to vm_lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Change the documentation to reflect that vm_lock is integrated into vma.
Document newly introduced vma_start_read_locked{_nested} functions.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/process_addrs.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index ed74685ffbf2..c8935509173e 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -675,7 +675,11 @@ RCU critical section, then attempts to VMA lock it via
 :c:func:`!vma_start_read`, before releasing the RCU lock via
 :c:func:`!rcu_read_unlock`.
 
-VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
+In cases when the user already holds mmap read lock, :c:func:`!vma_start_read_locked`
+and :c:func:`!vma_start_read_locked_nested` can be used. These functions always
+succeed in acquiring VMA read lock.
+
+VMA read locks hold the read lock on the :c:member:`!vma.vm_lock` semaphore for
 their duration and the caller of :c:func:`!lock_vma_under_rcu` must release it
 via :c:func:`!vma_end_read`.
 
@@ -739,7 +743,7 @@ keep VMAs locked across entirely separate write operations. It also maintains
 correct lock ordering.
 
 Each time a VMA read lock is acquired, we acquire a read lock on the
-:c:member:`!vma->vm_lock` read/write semaphore and hold it, while checking that
+:c:member:`!vma.vm_lock` read/write semaphore and hold it, while checking that
 the sequence count of the VMA does not match that of the mm.
 
 If it does, the read lock fails. If it does not, we hold the lock, excluding
@@ -749,7 +753,7 @@ Importantly, maple tree operations performed in :c:func:`!lock_vma_under_rcu`
 are also RCU safe, so the whole read lock operation is guaranteed to function
 correctly.
 
-On the write side, we acquire a write lock on the :c:member:`!vma->vm_lock`
+On the write side, we acquire a write lock on the :c:member:`!vma.vm_lock`
 read/write semaphore, before setting the VMA's sequence number under this lock,
 also simultaneously holding the mmap write lock.
 
-- 
2.47.0.277.g8800431eea-goog


