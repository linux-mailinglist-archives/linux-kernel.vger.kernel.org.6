Return-Path: <linux-kernel+bounces-397073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501529BD66C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807591C224BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5A20E023;
	Tue,  5 Nov 2024 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBap9XDu"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016242077
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836986; cv=none; b=idqqBpCy6C/jsn23cx2T/wmEkrKerCDcs3N4icZbMr20ElnNlPzepkqVv74q/1k4/3VcHpX7mXMgq092sDdW9q/vkCjAwwrMK/X14LybHp2xYHRX+6cwsxqlkUb4oDLmhY3Lh5eIuUgzslUp5wXxWrV31mkbqCIb1FBx4Xu7XeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836986; c=relaxed/simple;
	bh=rFRh+bdpqAbdea5ZYe3Gk0BoZhd383UQF5ZAK7ibNkc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ejZJQY3snaFoDJf/FoVpDf0pdOfQYgiwPDkU9S0FozxZAdrXyLCrPCe8fICT7WSsmSWohHear6MQdwicWliZZay2BHTp6SizIlAfXTEmtVnIaVNiFsgWlZaui/9E6l9FS6K/WJJTpeic2YQcaH/62J73ugKhzCfNXiVBxLEX4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TBap9XDu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-204e310e050so65196005ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730836984; x=1731441784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUt0BSwj0IOZweja0gIwHnyMqE3I+HGvzDTqIGML6JE=;
        b=TBap9XDuH9kx3hqTWnJ5RGm4FaUavcUM7JTaXyisHkp5jYTvbGoaJd4871trGI7Nte
         /ILi5Gk3fNzq4FNYg0Um+ztqpEtLcqQoA8mcywNTi/opueqnj3+3+5KN3rhkJRjiD2uv
         zTTqNMiQZfOS7KBVD3mAt5kqGxypVgri4nr5+WJ+YtylTxrIMECmLOahSXi863xpm+Fh
         Z2QF7tK6d0iZ5/U6YZ8lV8lK87EHtwoEIB89La5kNdSxU+BNQJobqWIJrx5q7aukpfjR
         tNYcnB/igEHbJ54bsqsc9rpR53CdrwCI34jLLDC/P7y3Bn9Y64BHZ2oHO7KlyDrjwD99
         RBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836984; x=1731441784;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUt0BSwj0IOZweja0gIwHnyMqE3I+HGvzDTqIGML6JE=;
        b=j+9vEnRHPz3c0spcVhLPh+HQpfDtmLo1uzrAuMrSiF3k4WC9FZC3U+mgrYT4XTBB1V
         Mfufly4xfcQt9+bDDQRJRcieAiOp2pLkeRdNOL1S1kljvjPUuZ8xbxBcv0Uq2e3lOd1u
         0eLuv3DzVJb2lAQLPhcY3bBbiPAYfqwDv7+dPYvpo0BOLMfczU7p+sO8JmaA314uzlZW
         Af9txuCMxSMxrhWx3iyAH/bE7deqrnct0KxRSWJJJUDifNtd0SvXApSVRbu17dzN/UX8
         QVUYWkmrs3RVjZ94idDyWiGJe7f/SxF01NaJSLqnmhU1nGz7TQ6DXfMhQTX2OFbEnQjc
         qHLw==
X-Gm-Message-State: AOJu0YwHP12W9sWWxzJE6EtlG4t1CPrSa/Qc/4UgWKB4OZAn8Z3zp+MQ
	3wfZpXeAuYp+MLnv5ACNdd6F4MHf1QQ/z3Dp3XA2M/A6vFX7Wp+qBeBQllKm2a+E79UG2D4TnKx
	TABd27cb7vg==
X-Google-Smtp-Source: AGHT+IH8qmDfmFD7b/lhI9CHJ1/99xCXrIySD26xywaug4fISUEbP6hxbojvtNzeGhjF9al9k1yrRWm21s7zqw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:f38a:b0:20c:e8df:250c with SMTP
 id d9443c01a7336-210c6cf0c95mr1639535ad.8.1730836984492; Tue, 05 Nov 2024
 12:03:04 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-1-cmllamas@google.com>
Subject: [PATCH 0/8] binder: faster page installations
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@google.com>, 
	Viktor Martensson <vmartensson@google.com>
Content-Type: text/plain; charset="UTF-8"

The main focus of these patches is to improve the performance of binder
page installations, primarily by reducing contention on the mmap_lock.
The idea is to allow concurrent page insertion by leveraging per-vma
locking and folio_walk_start().

Unfortunately, this required reverting the alloc->lock spinlock back
into a mutex in order to serialize with the shrinker. At least until
finding a better solution e.g. support page zapping with a spinlock.
The trade off is still quite worth it though.

Other patches are also included that remove unsafe and redundant things
such as the alloc->vma pointer or the struct binder_lru_page concept.

Note: I'll work on setting up a page fault handler for binder next.
I believe an idea from Alice Ryhl to deferred the page insertions will
make this finally feasible. I only need to figure out a few performance
bits but if/when done most of the manual page insertion code in binder
could be dropped. :)

Cc: Alice Ryhl <aliceryhl@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Viktor Martensson <vmartensson@google.com>

Carlos Llamas (8):
  Revert "binder: switch alloc->mutex to spinlock_t"
  binder: concurrent page installation
  binder: select correct nid for pages in LRU
  binder: remove struct binder_lru_page
  binder: use alloc->mapped to save the vma state
  binder: remove cached alloc->vma pointer
  binder: rename alloc->buffer to vm_start
  binder: use per-vma lock in page installation

 drivers/android/binder.c                |   2 +-
 drivers/android/binder_alloc.c          | 315 +++++++++++++++---------
 drivers/android/binder_alloc.h          |  35 +--
 drivers/android/binder_alloc_selftest.c |  18 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 215 insertions(+), 157 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


