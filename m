Return-Path: <linux-kernel+bounces-540872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77063A4B607
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555631889931
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF791514F6;
	Mon,  3 Mar 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bg3r9T+w"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34B8635E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968678; cv=none; b=Emnf2z8vDfXRolqiwupHnvrBW00kUXPE1SRDbmltAk2ijp8F+UuWO9f2l+fpJ5aB95+C6Cid71q6Fwa6JLgf6uq7ueFMXZqHYD+zcY2PDfATtnQVJHVlsXiovvZD1jFj+uF8jZzhBI7svhFQUa/24vS8zYKCxlAQmTet9sucDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968678; c=relaxed/simple;
	bh=cHtSpwsJWrAvoVo1+dTLRwSY4Op9xcfDdYE2kDIyX/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMcFaoooD6hV2l5VFq6J0Vk/XaH9SIezdAqyBa68zZKLyyFRbCICQy95lgDGu3THMxrTrxZWAaeuetzRYeHAgY51AZ2gpXJwar1EtOVU8yDRafEYpfAQMtWoQiXhkfHsgvw+G6NcvwocR0ASEoA6jf7Bp3UV1+hgWaJ/PE5tgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bg3r9T+w; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe821570e4so5569908a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968676; x=1741573476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sznfA2l8NibSE6qcuM2Jb9P/DtwF9Yp5f99HQpgSZqY=;
        b=bg3r9T+wOL58tCthFzDf9lBwIn2QRL/QjCEJP+FjhVGYgTW5IOf4PPCW5iF0sgTb9z
         CQiPTh10dwpBn5gWMI5rX7otdM+9H0GYuzo9E0X7NTIP/LH4DDaf6V+aL+d2x6hgwluB
         5bsvdIQnw8VEPCSjgalS8f82v31L2hmI2JT0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968676; x=1741573476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sznfA2l8NibSE6qcuM2Jb9P/DtwF9Yp5f99HQpgSZqY=;
        b=tGKLX4MOdn4Xs3aN5rzueO77DHsgjZtLoB0+rz9vcl/qgb7EGlmSTqdEFX4xDxtGa9
         NpkUuagJvy+omybR3TvbjiTDUBjOtqmknCMENPWQEjnEMVIn0LckENuqUFtpONQJ1P/Z
         XDMxD1sRWlKQaJILhPuEVYTyf8jIRRlmhmpA2R3G0s5Xzqigo5HgslMz2TD5/BSIpnj8
         oAtSv+woo7pP1Z4Lmcri05sA4ZN4jk+UQrAGOXVBV4K1IdPNB75bud1zk3O+hEuPP6MV
         2yVQ/uOzZaMcf5bZ2hUSIyN8a2BIJ5nTOUfXHrhb32Tg6mp6+1xdUyI7tXckZjbfWgo8
         1xrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgyejJMvsejyU0Xo7gWyEtMekbD1UJFAP6ztJOFGsYXyEBG5u68GrrUIauFkwDY9xD/ZnehDFrNvBZyYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9b4nHJtelMG5Mb1nE27pn0rhWkVCIvOGbzEkw9enF9YcVEgF
	8a6Rq1+c6vzVb0s3OvQqvyd9I/OyCdwI92tbNt7jYXm8jb6izDwouWsFjG3CtQ==
X-Gm-Gg: ASbGnctVOn8FU7oqTOeQgJvfA5xZBxxGTF2Qwtj3eO44Is2pb182CroWk4Hdr7eEFsE
	TV6uvqqQawSwqhdv2pmec/gLjlfWw4ApiWcMJ8igPLHMCr9+6YM65VirUez3RTtnTSIOeSmExSr
	4sRfbvQ+tGgcVOc0GfBnJpvvOYlU2XBzz13Vf45VMbwlnt0SumzxFxlEKhheJhEOhmKthBJmV2v
	M26JLI75XggNJKoY/gdQW3JppIUrb4A1BGEHrkf4h8+0dx3mmd0gpBBYWpnU+nlvyzIGIaAZjCB
	8pFkelEFMawMKBlA85ZPtaLPONXiKcMhTPPpOnE5htNcBZ0=
X-Google-Smtp-Source: AGHT+IGv6hQiKqkOLC37uSZSWuOIbz10ORF2+JrYswdrfALyUuBndhlzbODDhgkgtSYwTOU6BN3POA==
X-Received: by 2002:a17:90b:2fc8:b0:2fe:8282:cb9d with SMTP id 98e67ed59e1d1-2febac0466fmr16781267a91.28.1740968676360;
        Sun, 02 Mar 2025 18:24:36 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe8284f116sm10902322a91.49.2025.03.02.18.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:24:35 -0800 (PST)
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
Subject: [PATCH v10 00/19] zsmalloc/zram: there be preemption
Date: Mon,  3 Mar 2025 11:03:09 +0900
Message-ID: <20250303022425.285971-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
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

v9 -> v10
- moved to statically allocated lockdep lock classes in zram and
  zsmalloc (Sebastian)
- dropped lock_contended() because we only can call it under
  lock_acquire() and thta's not the case for zram and zsmalloc trylock

Sergey Senozhatsky (19):
  zram: sleepable entry locking
  zram: permit preemption with active compression stream
  zram: remove unused crypto include
  zram: remove max_comp_streams device attr
  zram: remove second stage of handle allocation
  zram: add GFP_NOWARN to incompressible zsmalloc handle allocation
  zram: remove writestall zram_stats member
  zram: limit max recompress prio to num_active_comps
  zram: filter out recomp targets based on priority
  zram: rework recompression loop
  zram: move post-processing target allocation
  zsmalloc: rename pool lock
  zsmalloc: sleepable zspage reader-lock
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
 drivers/block/zram/zram_drv.c               | 330 +++++++++-----------
 drivers/block/zram/zram_drv.h               |  17 +-
 include/linux/zsmalloc.h                    |   8 +
 mm/zsmalloc.c                               | 329 ++++++++++++++-----
 9 files changed, 478 insertions(+), 317 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


