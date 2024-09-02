Return-Path: <linux-kernel+bounces-311144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C6968577
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7C1F231B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646614A4E0;
	Mon,  2 Sep 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZXJ+2fm"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC8140E3C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274624; cv=none; b=Etgl75RhMfMLoEKmA9WmkasQ8VGO3NoZxwpXMaKnBrAU/EJ4jCFCjFoI1yZmNtV+jcCFg74JJ8n0qzNyFZALl0s02epog1A5LGsQHTjP0M9Z9Sn7rSDv1lBDBvvtGkmz+TXkzKswE2RwKIuqS2k3qKfOsmtd9Crt/2qS1pKHRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274624; c=relaxed/simple;
	bh=OkG1GrVU/9zWGGlkwDSWK5heEs/+xEoaL7sOs+zH0JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlA5OhC0ryEupa1leJr5kmmk/+E8ADrVihXWCu0YLTeIsWV7bH8Ad/oZt7rOiCJijGVbjE0+03i8mGUJI+b26zclpqxLwZpn+jqOq17a3IigF263Q8COD3Y1CN1KuwAQbLBjia2xEee/E7m4QhU1l/MF15TRgkLqG7Zb+5V0amQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OZXJ+2fm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso2836794a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274622; x=1725879422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARypu7pFdg0xC8CjC5X8mUTo8efn3pj3gTfbJbhBYHI=;
        b=OZXJ+2fmX6xCP/pa2uBCdKm7+/RKCAo/aHjsCaWGXb4KUvn9zSDvxSn/Efk+CotQxl
         TGAPRPV6d7THV07Mk/G88dmT9g5tPQLv+wMh9tPE5/NqVj1Q0P4X/cXH8FzrRuoP0wUV
         z3WfKb11XkV3JvW4cRl/xCt7ThEMy2BPn0JBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274622; x=1725879422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARypu7pFdg0xC8CjC5X8mUTo8efn3pj3gTfbJbhBYHI=;
        b=px+Ji2I8Wq2ZQWCgFXCcjKRm9tDKLekBB/Jfvb0K8Np6mO9zdwvpiHIneHpJWGCd3Z
         JWRE4Aq7pOgRYVMF9DdAJTFZJMeS1cQwqNtqbXbBI1bUrNOuUPlm0zZwvVPns3mOCQJD
         imLbT9KwNqVxIfmp7T/FA7TMeiR4ddKXN8PRZf/MoJPZr/+DgV+TD4FvjFcqUYYePP4z
         lFH2/Czmi+CkE8f51yeXe+hSdv/L0qdY+StWpmpno2snRmguWHwTVhFceuPX/FH+EYwi
         eprUA9M2zCYXqTpo7sQsFPKbh/RodUCr4mjqPnrX7n7bpA/ikLN4ReZZ8V5DOerzTcin
         YKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTz1CPgvLUzTqPr9fwZ66s2vObP0YwWXVHc7Skld8s9QZ9OVGc3PL9dtN2ssmn/V9Xo9LNTvWM0DwLhmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzalROaXC0XGt92l8r5IgED/71voZ705KBz/9940sDwCr9giNrq
	I4szDTMUF3HbzQiG9loh2Z9V1NokCR3P/u1Q9Knro6OYCqnoFu9Pt2+cZQRTxg==
X-Google-Smtp-Source: AGHT+IGDMSBpRENmLYW6szb0lWBNrjuUfhuvIG94VPxrOJjcyuoNfnI1hTcuOor8LM0wqgjwXB3BZQ==
X-Received: by 2002:a05:6a21:10f:b0:1ca:dbcd:da24 with SMTP id adf61e73a8af0-1cecf49b04bmr8519143637.4.1725274622268;
        Mon, 02 Sep 2024 03:57:02 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:01 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 00/24] zram: introduce custom comp backends API
Date: Mon,  2 Sep 2024 19:55:48 +0900
Message-ID: <20240902105656.1383858-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces support for run-time compression algorithms
tuning, so users, for instance, can adjust compression/acceleration
levels and provide pre-trained compression/decompression dictionaries
which certain algorithms support.

At this point we stop supporting (old/deprecated) comp API.  We may
add new acomp API support in the future, but before that zram needs
to undergo some major rework (we are not ready for async compression).

Some benchmarks for reference (look at column #2)

*** init zstd
/sys/block/zram0/mm_stat
1750659072 504622188 514355200        0 514355200        1        0    34204    34204

*** init zstd dict=/home/ss/zstd-dict-amd64
/sys/block/zram0/mm_stat
1750650880 465908890 475398144        0 475398144        1        0    34185    34185

*** init zstd level=8 dict=/home/ss/zstd-dict-amd64
/sys/block/zram0/mm_stat
1750654976 430803319 439873536        0 439873536        1        0    34185    34185

*** init lz4
/sys/block/zram0/mm_stat
1750646784 664266564 677060608        0 677060608        1        0    34288    34288

*** init lz4 dict=/home/ss/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750650880 619990300 632102912        0 632102912        1        0    34278    34278

*** init lz4hc
/sys/block/zram0/mm_stat
1750630400 609023822 621232128        0 621232128        1        0    34288    34288

*** init lz4hc dict=/home/ss/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750659072 505133172 515231744        0 515231744        1        0    34278    34278


Recompress
init zram zstd (prio=0), zstd level=5 (prio 1), zstd with dict (prio 2)

*** zstd
/sys/block/zram0/mm_stat
1750982656 504630584 514269184        0 514269184        1        0    34204    34204

*** idle recompress priority=1 (zstd level=5)
/sys/block/zram0/mm_stat
1750982656 488645601 525438976        0 514269184        1        0    34204    34204

*** idle recompress priority=2 (zstd dict)
/sys/block/zram0/mm_stat
1750982656 460869640 517914624        0 514269184        1        0    34185    34204


v6..v7
-- new device attribute algorithm_params to tune and tweak algorithms
   (instead of extending comp_algorithm/recomp_algorithm attributes)
-- added missing sysfs file documentation
-- reshufleed docuemntation a tad
-- recompress device attr now accepts priority argument

Sergey Senozhatsky (24):
  lib: zstd: export API needed for dictionary support
  lib: lz4hc: export LZ4_resetStreamHC symbol
  lib: zstd: fix null-deref in ZSTD_createCDict_advanced2()
  zram: introduce custom comp backends API
  zram: add lzo and lzorle compression backends support
  zram: add lz4 compression backend support
  zram: add lz4hc compression backend support
  zram: add zstd compression backend support
  zram: pass estimated src size hint to zstd
  zram: add zlib compression backend support
  zram: add 842 compression backend support
  zram: check that backends array has at least one backend
  zram: introduce zcomp_params structure
  zram: recalculate zstd compression params once
  zram: introduce algorithm_params device attribute
  zram: add support for dict comp config
  zram: introduce zcomp_req structure
  zram: introduce zcomp_ctx structure
  zram: move immutable comp params away from per-CPU context
  zram: add dictionary support to lz4
  zram: add dictionary support to lz4hc
  zram: add dictionary support to zstd backend
  Documentation/zram: add documentation for algorithm parameters
  zram: support priority parameter in recompression

 Documentation/ABI/testing/sysfs-block-zram  |   7 +
 Documentation/admin-guide/blockdev/zram.rst |  64 ++++--
 drivers/block/zram/Kconfig                  |  76 +++++--
 drivers/block/zram/Makefile                 |   8 +
 drivers/block/zram/backend_842.c            |  61 ++++++
 drivers/block/zram/backend_842.h            |  10 +
 drivers/block/zram/backend_deflate.c        | 146 +++++++++++++
 drivers/block/zram/backend_deflate.h        |  10 +
 drivers/block/zram/backend_lz4.c            | 127 +++++++++++
 drivers/block/zram/backend_lz4.h            |  10 +
 drivers/block/zram/backend_lz4hc.c          | 128 +++++++++++
 drivers/block/zram/backend_lz4hc.h          |  10 +
 drivers/block/zram/backend_lzo.c            |  59 +++++
 drivers/block/zram/backend_lzo.h            |  10 +
 drivers/block/zram/backend_lzorle.c         |  59 +++++
 drivers/block/zram/backend_lzorle.h         |  10 +
 drivers/block/zram/backend_zstd.c           | 226 ++++++++++++++++++++
 drivers/block/zram/backend_zstd.h           |  10 +
 drivers/block/zram/zcomp.c                  | 194 +++++++++--------
 drivers/block/zram/zcomp.h                  |  71 ++++--
 drivers/block/zram/zram_drv.c               | 136 +++++++++++-
 drivers/block/zram/zram_drv.h               |   1 +
 include/linux/zstd.h                        | 167 +++++++++++++++
 lib/lz4/lz4hc_compress.c                    |   1 +
 lib/zstd/compress/zstd_compress.c           |   2 +
 lib/zstd/zstd_compress_module.c             |  49 +++++
 lib/zstd/zstd_decompress_module.c           |  36 ++++
 27 files changed, 1544 insertions(+), 144 deletions(-)
 create mode 100644 drivers/block/zram/backend_842.c
 create mode 100644 drivers/block/zram/backend_842.h
 create mode 100644 drivers/block/zram/backend_deflate.c
 create mode 100644 drivers/block/zram/backend_deflate.h
 create mode 100644 drivers/block/zram/backend_lz4.c
 create mode 100644 drivers/block/zram/backend_lz4.h
 create mode 100644 drivers/block/zram/backend_lz4hc.c
 create mode 100644 drivers/block/zram/backend_lz4hc.h
 create mode 100644 drivers/block/zram/backend_lzo.c
 create mode 100644 drivers/block/zram/backend_lzo.h
 create mode 100644 drivers/block/zram/backend_lzorle.c
 create mode 100644 drivers/block/zram/backend_lzorle.h
 create mode 100644 drivers/block/zram/backend_zstd.c
 create mode 100644 drivers/block/zram/backend_zstd.h

--
2.46.0.469.g59c65b2a67-goog

