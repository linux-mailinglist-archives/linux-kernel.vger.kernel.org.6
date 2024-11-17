Return-Path: <linux-kernel+bounces-412019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D19D0270
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49196B2535D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452517B427;
	Sun, 17 Nov 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLdtbwIV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE7170A11
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731830997; cv=none; b=MpIXkmjvDsuf4ODaJQuqdJi18ki+1zKbA3bupXD47zWAW8UZy+QIWaZmK0nvjJa78V8IAXC7bKh3IHhjQz3YPTS9HjB2BxDZnXaFLBJa57Dzf9VQwZX2N861GTUbuUrRRCf3ktgRrBv/xcUU5Nv69+nyzyCTm5evUyxmVKqlvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731830997; c=relaxed/simple;
	bh=vW4Z0ZGOmtEV/XeePxhUsVUAClcMrrgx+7r+mI7C7D0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PdgQ/oy2gJQcx2ZOnlLc/3KIS64IV2QKQTj0kUNWkmfqXz8gIHcHDjP0LcIWSdJP6AIZsCBtmdltHigvU5nIz4as2YjAa25s6SqXvcBiJnj/+x6bHTHzuGPc/PadPgExSW7C+e7pH/OwE2N4806mdI10ussBvHFgE17ytROVfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLdtbwIV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so4294901276.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731830995; x=1732435795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVe9xIxnbmkl7SmN6iZyRrlBkQz17Arq0DLY4ssSJic=;
        b=RLdtbwIVV47RHFFJ0tSqs/iwT4hqyIH8joNbIL/CTmntbBzG/OadRByae5MC4zYovN
         3tqPl+nAAI0cyvOAQIlMWnPyCh0M9uJavEHPPI8BzRm2auQwlttQSYTxhCp2Rkaev/M2
         7YPl6YKvvWYW1NzJ2rX+fax2X0EwE62wrywvjagXPNajWPMkQ0Kd2tIbTN/vRURJrB+P
         EJ/dMxSypLvirshPxKr54mBCXcxKqcwTQrMsX+3g/nwi5zUoDwM6sFa3g3uBOFLZ0tM8
         4bc7BZG0GgF/8C8FpmpyVOkAuQbAiQYmcHnFvi1aXHN2T69pYWDFbR15T0jALvdhuMvf
         fRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731830995; x=1732435795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVe9xIxnbmkl7SmN6iZyRrlBkQz17Arq0DLY4ssSJic=;
        b=CMREIgRrAaXF6X4XtlbdmKWkTosajD8H2PWuoYQN8DDQo3mks1vJeuqkUWnMWP4DfM
         bbRCtBaQj6a4TJWTm58s2MwWfpWAx+j4b5WI5L1zghSA4dS9V0Tp1X/o8stZ6S14RyDy
         tOZCSH81iQHhsOi3CyFx9Fh1GRj0jeYqhjoE6f08HVCYSsPjpbas3rRwYoL4cXbtUwnS
         VvgDMn8phIGgdooWdmqOWZm4ZtXO9Zi728wfrqx/q5u7z3FHLe4X9uT3MviGscSuVBNA
         4EuwB79j6F08phep15jfh3B5u3ZVOWx6KdqkmDaRT/C6oMPKZtJNsSyvLNSYi9h3qNze
         wRXA==
X-Forwarded-Encrypted: i=1; AJvYcCX+uk11ZzPqA0co/uy5mawtMQUkOUGsqzgg4Qss4K/rCADnt785lG0XnSMYFwMjeNrMFaX3Tyo7hzSh+Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGRpjLvjS+ep/TCOR/Hvxg+Ceqolsyu1Y3Tpd6hlF3RzjEIak
	nw6ZHFLX2BbPTJCMRvKThi5l7bpzVa51zuQU5R9lXHxL6KDqVCI/YJl4u5cYnE/bBi7cExBU7IF
	cbw==
X-Google-Smtp-Source: AGHT+IHOo0SNvb429sH9y3xLmKrGp2y4SlbBBZl72lF8+egqZzHX2n9q6YU+duTw+pCfixwfbSLpKdu+Ko4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:bafc:6633:f766:6415])
 (user=surenb job=sendgmr) by 2002:a25:aa8b:0:b0:e38:816c:df18 with SMTP id
 3f1490d57ef6-e38816cec5dmr3614276.4.1731830994994; Sun, 17 Nov 2024 00:09:54
 -0800 (PST)
Date: Sun, 17 Nov 2024 00:09:31 -0800
In-Reply-To: <20241117080931.600731-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241117080931.600731-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241117080931.600731-6-surenb@google.com>
Subject: [PATCH v3 5/5] docs/mm: document latest changes to vm_lock
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
index 1bf7ad010fc0..a18450b6496d 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -686,7 +686,11 @@ calls :c:func:`!rcu_read_lock` to ensure that the VMA is looked up in an RCU
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
 
@@ -750,7 +754,7 @@ keep VMAs locked across entirely separate write operations. It also maintains
 correct lock ordering.
 
 Each time a VMA read lock is acquired, we acquire a read lock on the
-:c:member:`!vma->vm_lock` read/write semaphore and hold it, while checking that
+:c:member:`!vma.vm_lock` read/write semaphore and hold it, while checking that
 the sequence count of the VMA does not match that of the mm.
 
 If it does, the read lock fails. If it does not, we hold the lock, excluding
@@ -760,7 +764,7 @@ Importantly, maple tree operations performed in :c:func:`!lock_vma_under_rcu`
 are also RCU safe, so the whole read lock operation is guaranteed to function
 correctly.
 
-On the write side, we acquire a write lock on the :c:member:`!vma->vm_lock`
+On the write side, we acquire a write lock on the :c:member:`!vma.vm_lock`
 read/write semaphore, before setting the VMA's sequence number under this lock,
 also simultaneously holding the mmap write lock.
 
-- 
2.47.0.338.g60cca15819-goog


