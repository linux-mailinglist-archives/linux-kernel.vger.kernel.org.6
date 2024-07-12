Return-Path: <linux-kernel+bounces-250161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6389F92F4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F51D1C220D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1FD17C7C;
	Fri, 12 Jul 2024 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxP6uBdI"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AED14F70
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761541; cv=none; b=gszjUko3IIYoplz/bBwu8GLKeVs9B2GtL2M3WahPjCtWrf6Tw9E5m5kt6CYcZZ+59Lzdv+2TW/EnPrg9kNFtvuYwxE53A5ZdMb45+vsseYYLVcpEYsOwWghLkm8GYJqE6DmNicajLocbJcue71bt3vjGLPEJsOC80xkf2DU7BQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761541; c=relaxed/simple;
	bh=WUxIGU0rtRMWn+LWARjnczpSHXVVxsgYXM6gxpBMNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoULNGFvgD8cH8u8ybAktaHaOTnHe3h9RGIlnjuO7XnztA+VUSGGL8yq24d+LRcsWuobzATbLnf6JUcJHh7XMrOAtu0Ng5vjZSqoM+8VoOw35BZ9Z/xkvjhbVIfb9p5JvQkRVDkxYE6+z98QEmnuifwEu1mSv0384n7cCzKWZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxP6uBdI; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f8d0a00a35so1331011a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761538; x=1721366338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6OXg817dhfYOLW3flKAXNdYBiz43qkGMpm3eFZy+Os=;
        b=jxP6uBdIOjDN7Ibhfhelk1cg4eU2aFthQObjhUid1txvY2FhQqy7V0G5wZ+/XTIeCW
         IERHeYowHdb0j3GSnQXd1xAsYhSKMY4pGYC54vLvK7Ara3K/jWr2EdbccElv+5ViTyF7
         3dwoNph7G7pZ7RPowJXaZjCm+IfuP/ZAgOZNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761538; x=1721366338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6OXg817dhfYOLW3flKAXNdYBiz43qkGMpm3eFZy+Os=;
        b=tTKaN67G0+7ttKsuqE/lH9ViU0ZtV1hJLb5iLFTMEjooyr6JAxPrmfKgnFf/yK3M1H
         bdDUEeAJ6vqxBxXnUJWDLACc06fXdJKvE6f+LAZ5ACMCTf9pUXALnQUAzRFdxNNpLWME
         z0XvSfRH4AH2TXZivxAzxudjYRnmdBArl98EJEwkNHyQTXcwOLupSExrXNlc9IhikLVN
         Eyu6hKYkuAJBNYpQ98H/XPX0kaHuMaOySIeZtuhHBXWSh64dzyuotrIARBJkUg1go1PZ
         ax/O/+J/kIXcolsy+P3b5HaY2KjJJz6hEAqAGEsRxtR8IBM7q5XerXNXowyOXgHgtmdQ
         pv/g==
X-Gm-Message-State: AOJu0YyT2lB1m/7QmaESbx9udgYDzhDGPbLV/ipdFkJACfqpMGrd/q7C
	AEduiHSApewnJtK1MHGaA+X7ePpcdkfaW4gluLu7+tX41sgX8azAuctZOL+nEw==
X-Google-Smtp-Source: AGHT+IGj4V+yjVYsghE7DvUFAIsdirwBzPO2EERHzfydZRWY3jBrE95wKK7HHMunvGGLpFjgnRfwmg==
X-Received: by 2002:a05:6830:1e99:b0:703:6847:3ab8 with SMTP id 46e09a7af769-70375a45ca7mr11587947a34.25.1720761538573;
        Thu, 11 Jul 2024 22:18:58 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:18:58 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 00/23] zram: introduce custom comp backends API
Date: Fri, 12 Jul 2024 14:18:11 +0900
Message-ID: <20240712051850.484318-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
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

*** zstd
/sys/block/zram0/mm_stat
1750650880 504575194 514392064        0 514392064        1        0    34204    34204

*** zstd level=-1
/sys/block/zram0/mm_stat
1750638592 591816152 603758592        0 603758592        1        0    34288    34288

*** zstd level=8
/sys/block/zram0/mm_stat
1750659072 486924248 496377856        0 496377856        1        0    34204    34204

*** zstd dict=/home/ss/zstd-dict-amd64
/sys/block/zram0/mm_stat
1750634496 465853994 475230208        0 475230208        1        0    34185    34185

*** zstd level=8 dict=/home/ss/zstd-dict-amd64
/sys/block/zram0/mm_stat
1750650880 430760956 439967744        0 439967744        1        0    34185    34185

*** lz4
/sys/block/zram0/mm_stat
1750663168 664194239 676970496        0 676970496        1        0    34288    34288

*** lz4 dict=/home/ss/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750650880 619901052 632061952        0 632061952        1        0    34278    34278

*** lz4 level=5 dict=/home/ss/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750650880 727180082 740884480        0 740884480        1        0    34438    34438

v5..v6:
- const-ify zcomp ops (Thomas Weissschuh)

Sergey Senozhatsky (23):
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
  zram: extend comp_algorithm attr write handling
  zram: add support for dict comp config
  zram: introduce zcomp_req structure
  zram: introduce zcomp_ctx structure
  zram: move immutable comp params away from per-CPU context
  zram: add dictionary support to lz4
  zram: add dictionary support to lz4hc
  zram: add dictionary support to zstd backend
  Documentation/zram: add documentation for algorithm parameters

 Documentation/admin-guide/blockdev/zram.rst |  45 +++-
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
 drivers/block/zram/zcomp.c                  | 195 ++++++++---------
 drivers/block/zram/zcomp.h                  |  71 ++++--
 drivers/block/zram/zram_drv.c               | 117 +++++++++-
 drivers/block/zram/zram_drv.h               |   1 +
 include/linux/zstd.h                        | 167 +++++++++++++++
 lib/lz4/lz4hc_compress.c                    |   1 +
 lib/zstd/compress/zstd_compress.c           |   2 +
 lib/zstd/zstd_compress_module.c             |  49 +++++
 lib/zstd/zstd_decompress_module.c           |  36 ++++
 26 files changed, 1505 insertions(+), 139 deletions(-)
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
2.45.2.993.g49e7a77208-goog


