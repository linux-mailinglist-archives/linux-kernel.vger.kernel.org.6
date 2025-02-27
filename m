Return-Path: <linux-kernel+bounces-535561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E0A4748A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14463A4841
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70A1D90AE;
	Thu, 27 Feb 2025 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1jaiF/L"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC328F3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630994; cv=none; b=BUg6R3Hi+WRbk3I4W6rwpIxanv3s1tbqqOYfLS8MuUhdyDhi8Ml+G3w76UITc1DwG9PS9vKcxG+LRZGvuRC8xXMgUdw8PNwe/JAvqyWqghbMWCayYVJX+JsU/4DlWKPKO5bljhJ33zVZJkAhhXGNDBxgaOVE2KrVaAHTr4AEqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630994; c=relaxed/simple;
	bh=CRN3xG+LKYWwkTZPAe3FES8Wz3vHpMlOp2NDaU9QD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCRWiact66LGgqwogG+kvZp599mqzSUy8TmeSRaF1ptrMc2G+1hzXdl2mlihLSWrqQkuFTQw0+apf/Z5i61emxqFaKA2pCY2lSww+xuA/zefkeD6V16MEbnWmgivKCcAIaoh2ks6QmNZ9Gb3RS6489IjNSzef0P1k793q8p/yrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N1jaiF/L; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so924388a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740630991; x=1741235791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z3DSKokSwZ5uHRtAT60BGaSiPztkv7dCrtMyW+YP6I=;
        b=N1jaiF/LJLQ544hOeBTY5182qv8xxFgf9PxT+uQbn+xtRrFmPDywIBIhSEtKP1bSFT
         q8yvE5HXzffnOayF1bDHASQCJwZlAr015wZjxOLy6skk8X0iTx0Ip8X7IFw9hUOzWuNg
         chy5fpamOXrJQv8Jgtuorv2pFIn19x8TMQ/F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740630991; x=1741235791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Z3DSKokSwZ5uHRtAT60BGaSiPztkv7dCrtMyW+YP6I=;
        b=Ih7SDFeV700GcWID66XOv2k5gh8AOxH16ctV1x/I7CGmgsMLa+9HEvmadBEwn2d9vD
         bVD7BX12XxdO/XfVD2FlD9V2AMOkQtLJyJ5nNnsOfFTbkksvzoOs8g0pXgFXHwS37ztq
         /TdTW7ndJXA0fb3fPDAvo2aKW4nVubyEQ7dhMR4QAXwtFtOeduDetFZ8zmR+f6swcvGM
         b43TwOEdconSzlDm54y4h+yiTrmwoDVh06pKzNIx55eCl9CbXrwTxQQeX3mi/tUY6o6P
         I1ow8Bu9zLycge6arbRVJSxOWn8mtD7jDpiNV1iJ61Y26GFlwTAgc1T2OSKZz8svEG+m
         TXJg==
X-Forwarded-Encrypted: i=1; AJvYcCWOmb97PV1JYLFBeQcqkOJTYwztyGQ8TKun3vMrIi6HX8e6EjJ6z52UHqRHjSQfI6eomT151JxlgHZH8to=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsf1048/lBOSsZHfRP3a68+e2WHG1BDwT6kWFwpjebUBRCWfYE
	azIqscmzElEvnJCwCc9ckVTeEPOVBOeSkEqClkK8iI89MSHjiwg3jztT/M3SSQ==
X-Gm-Gg: ASbGncsrnVPJlLeGuoAdJlELlCVOl0oL0H3mN3tbmpAO1OUHclmXVmb33ORLzwfl//8
	ZaJkjN5JzWiWYNPlCIQ6q9IpcDnPRHguD3bBQ6rJUtJXG1SpLw6WOfj2PPdyQwxvVt2UvVdpqXL
	09jKvvmmNUPYxdazREbE+Tcml4JRM4woSivigeHA0TgDPQ/+mnHc1QyCmLcsrZtWuYLT7te6yGY
	SXi5CTi/1Z2C1egeNVhqrAbdmJDbqD5Tzx/LxNJOr02IDI3elcjoy9PRW+ygwlCC4/oSAeEd4/z
	KWe5P0cCsWQYnlnAqPxEsPUD79eS
X-Google-Smtp-Source: AGHT+IG0BwI3VqlxpA9E0JnUzA5p7//9Vscs8Kzwmy/4s/mzmHLVasE2jLbYowS4VPG0rXYGyeNnuw==
X-Received: by 2002:a05:6a20:3956:b0:1ee:d7b1:38ad with SMTP id adf61e73a8af0-1eef5178c60mr43093813637.0.1740630991182;
        Wed, 26 Feb 2025 20:36:31 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7dedf5a8sm396321a12.70.2025.02.26.20.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:36:30 -0800 (PST)
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
Subject: [PATCH v9 00/19] zsmalloc/zram: there be preemption
Date: Thu, 27 Feb 2025 13:35:18 +0900
Message-ID: <20250227043618.88380-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
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

v8 -> v9
- dropped ifdef-s for lockdep dep_map and lock class (Sebastian)
- dropped some !preempt/in_irq WARNS (Sebastian)
- unified zsmalloc handle allocation flags
- simplified post-processing slots scan loops

Sergey Senozhatsky (19):
  zram: sleepable entry locking
  zram: permit preemption with active compression stream
  zram: remove unused crypto include
  zram: remove max_comp_streams device attr
  zram: remove second stage of handle allocation
  zram: no-warn about zsmalloc handle allocation
  zram: remove writestall zram_stats member
  zram: limit max recompress prio to num_active_comps
  zram: filter out recomp targets based on priority
  zram: rework recompression loop
  zram: move post-processing target allocation
  zsmalloc: rename pool lock
  zsmalloc: make zspage lock preemptible
  zsmalloc: introduce new object mapping API
  zram: switch to new zsmalloc object mapping API
  zram: permit reclaim in zstd custom allocator
  zram: do not leak page on recompress_store error path
  zram: do not leak page on writeback_store error path
  zram: add might_sleep to zcomp API

 Documentation/ABI/testing/sysfs-block-zram  |   8 -
 Documentation/admin-guide/blockdev/zram.rst |  36 +--
 drivers/block/zram/backend_zstd.c           |  11 +-
 drivers/block/zram/zcomp.c                  |  48 ++-
 drivers/block/zram/zcomp.h                  |   8 +-
 drivers/block/zram/zram_drv.c               | 332 +++++++++----------
 drivers/block/zram/zram_drv.h               |  18 +-
 include/linux/zsmalloc.h                    |   8 +
 mm/zsmalloc.c                               | 334 +++++++++++++++-----
 9 files changed, 485 insertions(+), 318 deletions(-)

--
2.48.1.658.g4767266eb4-goog


