Return-Path: <linux-kernel+bounces-525487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E016EA3F092
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43481188680C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C96202C30;
	Fri, 21 Feb 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g07SR63l"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8C2036E3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130725; cv=none; b=acAIBHtcoQMMxgCetFvrn7O2/eQinqVqsBSKa1Etb/EnkjTYsMFeeFjVX9ivDIPRwJoKamoMg0sYg6LTjryszrK1IJbkiLccEOFYFOWJo4hGnCXpT8QWR/ghKREQcKZyyiPsHMQ912noMpMs/rjJSCznddup14x+Aad+rjCnlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130725; c=relaxed/simple;
	bh=N4CAuajKMdibl/tCuG6QQaddJtwAQ3znUwly2F1rnfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hi4l71SlV8s6dyOovgac6U0DCI69kMVvabtM6Pm0PmlGJJ9HAelIi5DodRZYECYCY5BRPI634jOSzXLExb7o+GNE323MoejfsWJ2xM5GQ/N63mo8bPEAIMu6aB7qmz+pW7CqLXCW31qMuf0lpsIlfnoaYXyF3LnoYEgTUh7hPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g07SR63l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d601886fso28306095ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130723; x=1740735523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb/ZzpS94bhyr7zvV4dT2coaEuz51CRI4NUHze17YNE=;
        b=g07SR63lPnp09opKqdKkrjTSkj5Z5TCtwhvVjYzZp2SDZERKZUBHhSXYKfXIlXvNOt
         YEZAWSPI701K0umBOMOD1/EMFMe8Ys+FWkJO1smjgFt+0f6ZIqfwZa9Xoa+P8OoWxxjX
         TTFJlGBgJo8DNRw0GDiOFVS17G/gYy6xq7SMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130723; x=1740735523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb/ZzpS94bhyr7zvV4dT2coaEuz51CRI4NUHze17YNE=;
        b=xGa20WQBdKqEy99Ldc+Q1i7ibiq4ZG/qhW5Atm8YPlcm0KpeQVeeyC6BQj3jzmCkB4
         qocMYzQ3iPu5dIPN6FWdwDkB3oIeEvJvz3nYcDYZePuLpXhPpw5BQOVGhMxIowzqOii7
         UrauxYQmVbJ+1X61HDWhww8FFyQ1ZBcPAwgpR726eM39ZubiYxAeHPnwe93ttN1YMrp5
         1X0R5kJGjH4DkNih46nzV2lFO1tC886F78KX26t9R9SexgMM82Xu88VV5Wgn8lJ8bJa6
         UWsSdNcjQQMv7joU+WDZMgQ/CclGZuyJju9wJ8cDWKnnOqM+KIuR74jLDIoqwnOSM5Kl
         xQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1BVJy2m/deFqIEBU5Wf771k9Fu272nqHExEwqP90p8O4bW6udjc9YA1wh7gxwPytcyK0d4uG0ZpZ+wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLYhKzL8+WF6pJL2qi43uo3r2x6KlNW0v29a3Mua6JQTJkffn
	3TQqxsI23E17g4SLFOfWSccwx1o1RCO60bZ5Big98/w8EukWnrNKutXsxW8+rOQqUTkDeoQ1+lo
	=
X-Gm-Gg: ASbGncvuLfam3fR9s3MSftGipzE3FtX/PmOfT0yeoK9OYl0qzyAKHJ5j8ARODpTB7KF
	q5FSJ2yHVnOSJDB2369SgI42J/NcVoCj7R9Xlhjn/0JAuP3rXvpCHcb4SoUoQSvvhmcolnHKYjE
	yqjKRSEHwNaqR7em46tsMQh8UPzMzNnyrw1PA867pr4sJompUYTJ2ndfoIxVPXrcD9TM6cs5dGs
	Fs2YfJUpBCOsRLoc59cSZ5fs4aRkWQH/dH+7RJH3KiGjwNITeWbPRE4CnjdaghEaN7WZNJHucDr
	dGOPBwkQvBrYSYf+7Pv09wXf/mU=
X-Google-Smtp-Source: AGHT+IG50W3X4SnN9btz4er882u86/9UWbROeOzs8+xCx3/4zysAPn6c1qlS5KMy+CFTP1GMeFp3Ew==
X-Received: by 2002:a17:902:f684:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-2219ffa36a7mr39383345ad.39.1740130722768;
        Fri, 21 Feb 2025 01:38:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d55960ecsm132769155ad.253.2025.02.21.01.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:38:42 -0800 (PST)
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
Subject: [PATCH v7 00/17] zsmalloc/zram: there be preemption
Date: Fri, 21 Feb 2025 18:37:53 +0900
Message-ID: <20250221093832.1949691-1-senozhatsky@chromium.org>
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

v6 -> v7:
-- provide dep_map access wrappers to avoid code duplication
   between !lockdep and lockdep builds (Yosry)

Sergey Senozhatsky (17):
  zram: sleepable entry locking
  zram: permit preemption with active compression stream
  zram: remove unused crypto include
  zram: remove max_comp_streams device attr
  zram: remove two-staged handle allocation
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
 drivers/block/zram/zram_drv.c               | 289 ++++++++--------
 drivers/block/zram/zram_drv.h               |  22 +-
 include/linux/zsmalloc.h                    |   8 +
 mm/zsmalloc.c                               | 356 ++++++++++++++++----
 9 files changed, 498 insertions(+), 288 deletions(-)

--
2.48.1.601.g30ceb7b040-goog


