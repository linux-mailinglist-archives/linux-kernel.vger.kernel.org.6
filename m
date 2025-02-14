Return-Path: <linux-kernel+bounces-514347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C82A355E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1DF1891C66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CF515748F;
	Fri, 14 Feb 2025 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fciD6mi7"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9022092
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508742; cv=none; b=EQ3tpFU+3eyVer2oepmP1JDdmzWHSKoO26XA72yDzEOVuSKOnUBs8inw1V29OuBhwlwbqBTNvMfdhn29pf1sshnzBoCcoAV/Ht1zvIWLlAVIHJs4gWmTJE3U2EZi0yq0rasruR0cphORS6R9UDvuscwV36qQREOoDKkn1PATCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508742; c=relaxed/simple;
	bh=VwvxoxTI6wmcF9isXOzn4ZGDGDn8TsLvkhr0jiI/TJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpR2WEsp+2aDFfe2zJs14iQE7qJg18jKFMTDPPYh4lTQfTANRaNdb51FpkzECtLdAUBLHx1u2miqioMbOH2roJekIwZn2DxSvDcH9xl/fpWOq5E+cFHBDEgy1bVXGLpFmnx+8KdnhcrADyvm8Q11OeQtMRrYu8A/2yT/7Aa6pSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fciD6mi7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f2339dcfdso25100445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508740; x=1740113540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmOJP3Z7wquDbzKxXwoXG/JeDZB5cqsEGjVZKnE331U=;
        b=fciD6mi7G6vWgFNokzDKVRRrLMaipK1iZjML7CjXhAAwA+hHANUnc82xEh8qam5JeR
         f3NcYmVpNAgr+Qcxb36Izh6b/JPkBjkJmDFyD2R66gGNS+SY7USrWwAHFYeZZscLmlhH
         ohcbfKZmgZ/NztD7hw7xIuMzBIfL29jJxYTlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508740; x=1740113540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmOJP3Z7wquDbzKxXwoXG/JeDZB5cqsEGjVZKnE331U=;
        b=pDV8i5jZeEUnVNiASY3N37+te7iUTnRanb46EHjR+zit+mw1I1Dlnk4dnWfsY/TgXc
         YUbCenUacicLvvjHV4J91FmKW9cDz+WPeofdqXLPcEvvpw8YiVfpT/S1K84locWtG1cL
         uXymnPNRBAWyS0BwSkflx8npDoX82AuNqJTwStKb4XU6UsLc+0CoWB4urETaFvGGyVd0
         j4s7UOYJlYFdEShpkK76yeOGsrdYV8fdUI36svW8GvUxLnunsFlJ6Std5mub6lrz9IJk
         6x4h8Y9dJU1aOfb9aH1Ovlxijelb1qZFiCfFPVuWlynZqTjcZPeuAGy/ImglEgem0V+g
         /R1g==
X-Forwarded-Encrypted: i=1; AJvYcCXAO06ARvo0xQRtH8FWlDOWDW/fJmM/BIgeDl2oa8/572+2XYsXmZBSdmaAkwlJj8hwnsoNQygRTsmZvz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYAo/oUr0rKah9B6XPN9QH/pLkOclSZzr2qfwqXmkjF+mPeqjQ
	UjuEd2Ug94zasHd7h80YcfUe21psVFfNgfrjKlLz1/Ul+wXW6ufgxOeiyvGP4A==
X-Gm-Gg: ASbGnctTHSxL0/w167KtqvWwqqyS73EVvOVHIn8h/qNmAIP0mDiyONyoW/buLdLEEA7
	1Q9IfRxuUZHES4s6PnLp3/+6+XAiUEONvZ56h3TS/Dy+8Z+AkW0zUahVZblHqOJagOhw5boZeNy
	MhrTyX5vdkeGOemBkSrYcta/ikjCSPzWJug/yfakzU9jvRyRoqEd3he7olA+sY6LmzWc0oVEcUZ
	zKmRkKGpkp5gNDC22jIyQWK1TKVoJ3JFxalHxLkxvXWpMFBROnB0P33ZMWvL6jvRCmcr2Oz7T3n
	98K32zTRgXkRdccZuw==
X-Google-Smtp-Source: AGHT+IFTeCBcOuIPmVP7cIqQibR68G7t2XsSlQ82GITWrysZsnQxcJE2dRGlmLlPNz7jtHCdZI2SEQ==
X-Received: by 2002:a17:903:98f:b0:21a:7e04:7021 with SMTP id d9443c01a7336-220d3763091mr84781225ad.24.1739508740037;
        Thu, 13 Feb 2025 20:52:20 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5364669sm20890135ad.86.2025.02.13.20.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:19 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 00/17] zsmalloc/zram: there be preemption
Date: Fri, 14 Feb 2025 13:50:12 +0900
Message-ID: <20250214045208.1388854-1-senozhatsky@chromium.org>
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

v5 - > v6
- new zspage lock implementation, based on a spin-lock (Hillf)
- added CONFIG_LOCK_STAT support to zram entry lock and zspage lock
- tweaked lockdep names of zram entry lock and zspage lock
- factored out lockdep-enabled zram entry lock and zspage lock functions
  into separate helpers to avoid numerous #ifdef-s in the code (Andrew)
- updated zspage lock rules (Yosry)
- moved comp stream mutex initialisation out of cpu-up handler to
  close cpu-dead/stream-get/cpu-up race window (Yosry)
- dropped patches that factored out zspool and size-class locking
  (Yosry)
- rewrote commit messages for some patches (Yosry)

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
 drivers/block/zram/zram_drv.c               | 326 ++++++++-------
 drivers/block/zram/zram_drv.h               |  22 +-
 include/linux/zsmalloc.h                    |   8 +
 mm/zsmalloc.c                               | 413 ++++++++++++++++----
 9 files changed, 592 insertions(+), 288 deletions(-)

--
2.48.1.601.g30ceb7b040-goog


