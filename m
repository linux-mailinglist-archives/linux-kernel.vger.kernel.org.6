Return-Path: <linux-kernel+bounces-510565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E1A31EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906B73A139F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F91FBCB9;
	Wed, 12 Feb 2025 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iAfannZD"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003A1FBC8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341922; cv=none; b=BUZ8UP0W5HgR75xnOljVQ6qXNTX9YuWjUSnN3QKeTVYQzlI+Sxfa6Y72mtgnjxbCqitDPbttIpiYJRgZspOHOheeYQfSwZBLWV3VNcAltqu97F+q99S++yO0vri9aMnJc0CwDQkspgbwOEB5IQCbNdT54wf1KHZ3cjMG39QkTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341922; c=relaxed/simple;
	bh=TamXbQFD1NAhS3+xk1Nnfi/W2m0PNcgTBD8ofcb6uk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XI4swbxU+wL3GO7OB6xhGba/6r85nIwIWvq8FDJgoTwJnyPfOPkGYNkYAnG0eoqGzyhjjN5asqQ+E7yTm7v+/YvsCs7h6ewzYDV0jMCsCFqlTng6D/8+HPn1pun600MkNZP+naigPHoDaBYmSMT2JSfipl+1l5dqpi/Iu700jP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iAfannZD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so785337a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341920; x=1739946720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=501yi1cpVrmEp+ncJhrBCmHl7nTzT7vsrJ8f3PE998M=;
        b=iAfannZDDIvnk7FoC4mWh7OpxhqknrqKnBO19rOscj9m8A5jMNPEMQjzn5YcQ21ZaU
         TPHH7wWZHYuIhabbmxC/lsXC4EC35LT6zHUvAk7Q60Q0D7pzyE7dwbXeXucgRvcd2Y/m
         DjZ0PIeCbdzCN+t1f3lvEdnFMEhGNlQsvZvyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341920; x=1739946720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=501yi1cpVrmEp+ncJhrBCmHl7nTzT7vsrJ8f3PE998M=;
        b=iQkZxYt9kDcOCBuVHps+Zf6jQTZCedQd2RVDA2H1RyCc2ailogu0KGy0aK7siL628q
         ISjg8RI41PZY+DXVkmpqsEK6OMMqLW7KwPSEWx57FhP/wimYS4Rtuv+LOzAXCX7LiZME
         Dm9nJWoCSYIsQDZ7JXRME+jBVuTlzm89h2ZZbtcnZexooOxOEGAFt8wh99VIU4qrB/EZ
         7oI70HZfquTI2/TFYDMoh2nYL7WOUAIIBUkXLgDw9M6HrJJxAgJqiS5SeV+O2DUx0rAG
         i2XwBlaCq9omib0u9NetbVKXSWm4xg2fk7NV07vt3kvYiwPA/bkUkqcDkAnYxu+917zu
         p0wA==
X-Forwarded-Encrypted: i=1; AJvYcCWM8lbGw1Pq2CvmApZdzwhRLoeAByppu4LXgYWTOOx7sR4cOD+OWS8hbUtLfjViORRMs/G5qwkjFWJ82u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsF9BFhQ4ihjWFxtMWZBIu1u8ZmvQa400S3XPXgG1UngBPdRWp
	befdRXkuYE/QWvBXEDzwNwnOQ/zPv4vRa5DseJd4h6GqSuC//myZlOVIhFK65w==
X-Gm-Gg: ASbGnctdIuUHgB/ftfwACnnD+0AWCX0dMWQf+Da1lX9zm/8lOaWqqGE69goDjGzqCUr
	vI/Qkm2SfHeXlrsiRzkE0XigbFXDMQd3FCRUIKKIMuef0XoqpQkwAQvA9pvq1cZeKeFdX1Zqxv3
	IHe3gFIz0oi8jkqVbtD2Elv8K1fX/YEE123ea51Of+TlFFe7Xc7wtDnGTrTCiJVko2OGOpEYX2M
	ubPXhkJhD9YKnRNcbtzfq/CUQEgPXsZV+eDt4I+SdDhVMYUJ7rwI1OYWgpZ7hIbIUX/VkwSFXmG
	SO9TauWfBamBFrx0Dg==
X-Google-Smtp-Source: AGHT+IHiV9B6eIfyg2Gsmc1ORW5sQ5pz7wffjd71n/VATHAnz5v2omml/47WVzTGc9TaWCYUQEpqog==
X-Received: by 2002:a17:90a:fc4c:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2fbf5c1bfc6mr3357534a91.15.1739341920049;
        Tue, 11 Feb 2025 22:32:00 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98d3886sm663293a91.25.2025.02.11.22.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:31:59 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 00/18] zsmalloc/zram: there be preemption
Date: Wed, 12 Feb 2025 15:26:58 +0900
Message-ID: <20250212063153.179231-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
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

First, zsmalloc is converted to use sleepable RW-"lock" (it's atomic_t
in fact) for zspage migration protection.  Second, a new handle mapping
is introduced which doesn't use per-CPU buffers (and hence no local CPU
lock), does fewer memcpy() calls, but requires users to provide a
pointer to temp buffer for object copy-in (when needed).  Third, zram is
converted to the new zsmalloc mapping API and thus zram read() becomes
preemptible.

v4 -> v5:
- switched to preemptible per-CPU comp streams (Yosry)
- switched to preemptible bit-locks for zram entry locking (Andrew)
- added lockdep annotations to new zsmalloc/zram locks (Hillf, Yosry)
- perf measurements
- reworked re-compression loop (a bunch of minor fixes)
- fixed potential physical page leaks on writeback/recompression error
  paths
- documented new locking rules

Sergey Senozhatsky (18):
  zram: sleepable entry locking
  zram: permit preemption with active compression stream
  zram: remove crypto include
  zram: remove max_comp_streams device attr
  zram: remove two-staged handle allocation
  zram: remove writestall zram_stats member
  zram: limit max recompress prio to num_active_comps
  zram: filter out recomp targets based on priority
  zram: rework recompression loop
  zsmalloc: factor out pool locking helpers
  zsmalloc: factor out size-class locking helpers
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
 drivers/block/zram/zcomp.c                  |  43 +-
 drivers/block/zram/zcomp.h                  |   8 +-
 drivers/block/zram/zram_drv.c               | 286 +++++++------
 drivers/block/zram/zram_drv.h               |  22 +-
 include/linux/zsmalloc.h                    |   8 +
 mm/zsmalloc.c                               | 420 +++++++++++++++-----
 9 files changed, 536 insertions(+), 306 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


