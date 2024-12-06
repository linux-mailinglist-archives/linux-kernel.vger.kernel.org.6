Return-Path: <linux-kernel+bounces-435767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E29E7C04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1664A1886A49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271521481D;
	Fri,  6 Dec 2024 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vK6cwR6n"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BB214802
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525541; cv=none; b=pshHFITQjNvDJF0IF31Pqyi2eamoXlsDUHwAiV6lD8KhDLj+gcGU7FveM2nI3VDNkji5zWaNs0ktZ6MK/0jZDPINNTIto4SrklEQx1lsXQN3BxwJ0etcLjKe3wN0HlsR/1pbQ+INDAswmkL0VpclP0KsJUgcX//2oODRJ4xFw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525541; c=relaxed/simple;
	bh=wuVL3KCJxK4NGHQjmcu/THUHhYmfWZVursHHMGiwF8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yf86mMG82gTIZtU2kCINHukWWCe6LLBZSl9d+8Ng7YOuQBSDegK93bonVzl7lPfO8mTK3L955euWDfrQewwJOWpUB0uyPmtWgMc8kIJpdAetDhzciIJnfsehw6gpTRsGthi/pxlZ7rXIQw8st1PJE+ijUXYiJxUqnehzAhaM7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vK6cwR6n; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7251424982fso2243781b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525539; x=1734130339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6wEf3Fj/sCIHriciJDFTmwIAy5yi6AjoE4yT83zSv8=;
        b=vK6cwR6nuiNXdM/7mqHoOieOXQe+wqxcYLqt5JcX2vv8z8DAUoUFbXihtP8qPQmpvC
         zHfILku+r0ihX/rAH2chEhoN6cc++hP0/a2+uZxr+zvtM+/dFKGpxJtWFA0OIIc3mtCn
         sTVjf4jkCXl1Ik3SQzcvMgNoXmFxSx+MZKdnWv1WL3hQHa3Q2it4dowbTyQ9F5qlUv7p
         7ism3CxdIHD5sy0K5xOMHM8MfEzqAJUbn/rQGLui7bsi8+5QzIp8xcaSHRj+HNp/i9DJ
         xmsuD9qf6gS9wU9BZxjp73xQfmyv6TLKgujowLwmTo+Cn/94rpEx6gg8TnnnW5T9LnmA
         Qyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525539; x=1734130339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6wEf3Fj/sCIHriciJDFTmwIAy5yi6AjoE4yT83zSv8=;
        b=EiCZxOLKzqFW5chP1VU6y2cw2Z5NPdzE7lgCITtzPtR2DtA2ZV/UxlWlZuUTd6on5V
         PPwGoQCrOnewJXbi+/h3DO080eLd/UWUT0YuU6P5lvGiaRcVt1w8cakntLIOlYX49wCp
         OsZ22J3wXszfqg94myD4gcJ3r6m+VKrb/6M9H2lQFHiK4M0D0a2+JgkFHvIXJ/9MRZF0
         GrSOx60rDk3GD4wqE2BDBm2TQ3N1OG3K4y0bBPhyj5uHQ2+U0h7aE+XycDO0HXWbQgSi
         8obM9kqDA4splUnrv1lLEsslR4OuOmomESOhucIRn5GnnUqIbt3hm4d3M/mv6qCVbnnx
         YYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJtj6gDqGcbEb8DKh9lnPyiim/Qk5jzgUdqKX4wpe8YAFK98f69K6keAPoefMxn7UfntBZfHB7jOHIHdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsde143dw2cMD+K/77y+QyBQ6RQGSKXe0+2zUOzlPZF1dyrCb+
	nJnzr2/9U+z0oEyE7Nr26eb5Fx465+FX17K3VmATl/8zBvpQ4/P2yLAkUm4S88jOyuVz+1pu9FB
	4Xg==
X-Google-Smtp-Source: AGHT+IF/E1FLpmQ9hujXfDz8ah1g4xzG4PooG2XovTR77om7ynRlxwPBbvaTMprv3cmEsfAU/D0wit+tFCw=
X-Received: from pfbeg17.prod.google.com ([2002:a05:6a00:8011:b0:724:edad:f712])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cc2:b0:71e:55e2:2c58
 with SMTP id d2e1a72fcca58-725b812e375mr6388253b3a.15.1733525538875; Fri, 06
 Dec 2024 14:52:18 -0800 (PST)
Date: Fri,  6 Dec 2024 14:52:03 -0800
In-Reply-To: <20241206225204.4008261-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206225204.4008261-7-surenb@google.com>
Subject: [PATCH v5 6/6] docs/mm: document latest changes to vm_lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Change the documentation to reflect that vm_lock is integrated into vma.
Document newly introduced vma_start_read_locked{_nested} functions.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/mm/process_addrs.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index 81417fa2ed20..92cf497a9e3c 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -716,7 +716,11 @@ calls :c:func:`!rcu_read_lock` to ensure that the VMA is looked up in an RCU
 critical section, then attempts to VMA lock it via :c:func:`!vma_start_read`,
 before releasing the RCU lock via :c:func:`!rcu_read_unlock`.
 
-VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
+In cases when the user already holds mmap read lock, :c:func:`!vma_start_read_locked`
+and :c:func:`!vma_start_read_locked_nested` can be used. These functions always
+succeed in acquiring VMA read lock.
+
+VMA read locks hold the read lock on the :c:member:`!vma.vm_lock` semaphore for
 their duration and the caller of :c:func:`!lock_vma_under_rcu` must release it
 via :c:func:`!vma_end_read`.
 
@@ -780,7 +784,7 @@ keep VMAs locked across entirely separate write operations. It also maintains
 correct lock ordering.
 
 Each time a VMA read lock is acquired, we acquire a read lock on the
-:c:member:`!vma->vm_lock` read/write semaphore and hold it, while checking that
+:c:member:`!vma.vm_lock` read/write semaphore and hold it, while checking that
 the sequence count of the VMA does not match that of the mm.
 
 If it does, the read lock fails. If it does not, we hold the lock, excluding
@@ -790,7 +794,7 @@ Importantly, maple tree operations performed in :c:func:`!lock_vma_under_rcu`
 are also RCU safe, so the whole read lock operation is guaranteed to function
 correctly.
 
-On the write side, we acquire a write lock on the :c:member:`!vma->vm_lock`
+On the write side, we acquire a write lock on the :c:member:`!vma.vm_lock`
 read/write semaphore, before setting the VMA's sequence number under this lock,
 also simultaneously holding the mmap write lock.
 
-- 
2.47.0.338.g60cca15819-goog


