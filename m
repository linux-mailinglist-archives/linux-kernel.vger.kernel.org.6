Return-Path: <linux-kernel+bounces-526742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208EA402A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EB8422670
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635A9204685;
	Fri, 21 Feb 2025 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k1va6OXQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5242A95
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177011; cv=none; b=Px1yP0DATn6PNm1jDDF2XgzJPl5hFRGNZevOCXKEF6ji647mblED6iWNmYDrKWuoWNY8oVD96OiKpOHMMVPzMphSuK2Lvf8gsadw5OY/WCQm4tRYuS8HcFfDX7+QLlPZGkxQh1e3FHt89Bt0anR/OFuUkjTxNuG/7HHPPRp1xgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177011; c=relaxed/simple;
	bh=d3Qhvru0LqyIjDcDGFikyFvNezr6E+JgTudyMAnOxRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VB4nO0u7ctsU43KErAb7vdOSxKo8RtfzlhhOpfJvRmn42GliMUZ2FZAc1xwfkaZ0NX7kzFFsT+8I55WiabbGUje+7lUSvlkgQ5lhOcm2jrnbs83OA/YC4wDCnKdC/loqNmJaupXPpmjIs//4Qf4OFjdomtBi0nKhULds5gabbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k1va6OXQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ec47991aso36923325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177008; x=1740781808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIJ8ddDA0cCVokuzmJJWIVHAKQ7UhqMQC/3iTM05nQo=;
        b=k1va6OXQbkkmuXHtiQdnnpqjRjGAgT8mDlnMgraMqapljxD2OWKSsAzZO0Mq81EWz7
         IfsLDBATVp+nBxXdGHneHgzmU3ILRpHlaPgzv8wFGT7Hou0PxxzBnYA2zjTzss12WVJ0
         4TgbwUCFtfytgEowtPcHQqJ/rhRVQncaFxnIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177008; x=1740781808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIJ8ddDA0cCVokuzmJJWIVHAKQ7UhqMQC/3iTM05nQo=;
        b=syo25girX5TnyAJGJEoH6R1rcRGU4OtvTuOCcLapMZcgLAi2yIVEM164yiPNT4btmR
         rcCMI6+4XItcRHsthhLLx0aa6wAl1L7JACKxVNv+wg2oD0hs44uAv7pdMuowvKNPYudP
         oMcB3bjmkSlKZC8an8SeWMiLHC7XzotVcdT2HDjyhiqAquO7uZZX47XD7Z/OX2sQLOuc
         r/YsdZ3pPEz7O/+ignkEmm7oR7/ebaBwdXWzeYVmrhg4MXd46A7MFhwhUTbnm3fbaQkl
         xSaE2TwrXRsfgOU0ztS9xnJSz0b+OerX4XX1pGQ33hCtoj47GuSpi4KZgn58vKGkAKUq
         B2HA==
X-Forwarded-Encrypted: i=1; AJvYcCX2zzQ3q6/FwsM6h+usW9901WyotldqrHRY5krx4gT5Qi4yfWj2YmUzMcSYTu49jjDtfKVc+4BaniVckmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JaAiSBFkhbL/MsFF0VPLu1IMgVfXa6aqPhMnWk5xg7tXs6ms
	QMlAyzC8UMUolPtxV7kbZmI2HPvmL1TuI4UceiNqmreo18/dyESotupcaNy9PQ==
X-Gm-Gg: ASbGncsOojwGzWBTXNHX7ZxWAuhgS7xCEyn5b5OUFsnZ7VSCvwzfd4prhj39zcscXzN
	cHoiz9SN3rP2gYMT/2BkGjn/mhztCfshSDT4glUu4XgCR8t7pP2XJsiuPogwM3LOTuYh7gvWtzV
	J2UDMG/xOepDE/QkMLu1kDqc0ofohsKoRM6cKjN6rvdu8Ch+W6FfQ3xh4FHiApMjJt1pW22SOL7
	d6FRO+cuJE7ZQF6x7e/S9F5mNN+J8uj5fiftrxOWNsUzIAaFmbR6GiW6KPq63C6lwegBoRJ6Arm
	8Hp7l6pwyfQMWdnSblVGgjwWu/w=
X-Google-Smtp-Source: AGHT+IFMB9Iixlk1xyjRwX7FZEzjCfDWa9s2c2YYB21O1DMz6m7MAeKzldOB2KaTkADDRvC7O7Jw1w==
X-Received: by 2002:a05:6a00:21cc:b0:730:794e:7ad6 with SMTP id d2e1a72fcca58-73426ce84d6mr7166039b3a.14.1740177008411;
        Fri, 21 Feb 2025 14:30:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324277f388sm16800540b3a.174.2025.02.21.14.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:08 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v8 00/17] zsmalloc/zram: there be preemption
Date: Sat, 22 Feb 2025 07:25:31 +0900
Message-ID: <20250221222958.2225035-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently zram runs compression and decompression in non-preemptible
sections, e.g.

    zcomp_stream_get()     // grabs CPU local lock
    zcomp_compress()

or

    zram_slot_lock()       // grabs entry spin-lock
    zcomp_stream_get()     // grabs CPU local lock
    zs_map_object()        // grabs rwlock and CPU local lock
    zcomp_decompress()

Potentially a little troublesome for a number of reasons.

For instance, this makes it impossible to use async compression
algorithms or/and H/W compression algorithms, which can wait for OP
completion or resource availability.  This also restricts what
compression algorithms can do internally, for example, zstd can
allocate internal state memory for C/D dictionaries:

do_fsync()
 do_writepages()
  zram_bio_write()
   zram_write_page()                          // become non-preemptible
    zcomp_compress()
     zstd_compress()
      ZSTD_compress_usingCDict()
       ZSTD_compressBegin_usingCDict_internal()
        ZSTD_resetCCtx_usingCDict()
         ZSTD_resetCCtx_internal()
          zstd_custom_alloc()                 // memory allocation

Not to mention that the system can be configured to maximize
compression ratio at a cost of CPU/HW time (e.g. lz4hc or deflate
with very high compression level) so zram can stay in non-preemptible
section (even under spin-lock or/and rwlock) for an extended period
of time.  Aside from compression algorithms, this also restricts what
zram can do.  One particular example is zram_write_page() zsmalloc
handle allocation, which has an optimistic allocation (disallowing
direct reclaim) and a pessimistic fallback path, which then forces
zram to compress the page one more time.

This series changes zram to not directly impose atomicity restrictions
on compression algorithms (and on itself), which makes zram write()
fully preemptible; zram read(), sadly, is not always preemptible yet.
There are still indirect atomicity restrictions imposed by zsmalloc().
One notable example is object mapping API, which returns with:
a) local CPU lock held
b) zspage rwlock held

First, zsmalloc's zspage lock is converted from rwlock to a special
type of RW-lookalike look with some extra guarantees/features.  Second,
a new handle mapping is introduced which doesn't use per-CPU buffers
(and hence no local CPU lock), does fewer memcpy() calls, but requires
users to provide a pointer to temp buffer for object copy-in (when
needed).  Third, zram is converted to the new zsmalloc mapping API
and thus zram read() becomes preemptible.

v7 -> v8
- also provide helpers for lockdep class_lock to remove even
   more ifdef-s (Yosry)
- moved zsmalloc lockdep class_lock registration so that on
  error we don't un-register a not-yet-registered class
- tweaked some commit messages

Sergey Senozhatsky (17):
  zram: sleepable entry locking
  zram: permit preemption with active compression stream
  zram: remove unused crypto include
  zram: remove max_comp_streams device attr
  zram: remove second stage of handle allocation
  zram: remove writestall zram_stats member
  zram: limit max recompress prio to num_active_comps
  zram: filter out recomp targets based on priority
  zram: rework recompression loop
  zsmalloc: rename pool lock
  zsmalloc: make zspage lock preemptible
  zsmalloc: introduce new object mapping API
  zram: switch to new zsmalloc object mapping API
  zram: permit reclaim in zstd custom allocator
  zram: do not leak page on recompress_store error path
  zram: do not leak page on writeback_store error path
  zram: add might_sleep to zcomp API

 Documentation/ABI/testing/sysfs-block-zram  |   8 -
 Documentation/admin-guide/blockdev/zram.rst |  36 +-
 drivers/block/zram/backend_zstd.c           |  11 +-
 drivers/block/zram/zcomp.c                  |  48 ++-
 drivers/block/zram/zcomp.h                  |   8 +-
 drivers/block/zram/zram_drv.c               | 283 ++++++++--------
 drivers/block/zram/zram_drv.h               |  22 +-
 include/linux/zsmalloc.h                    |   8 +
 mm/zsmalloc.c                               | 351 ++++++++++++++++----
 9 files changed, 488 insertions(+), 287 deletions(-)

--
2.48.1.601.g30ceb7b040-goog


