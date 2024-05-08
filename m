Return-Path: <linux-kernel+bounces-172830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D28BF743
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B742828527F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0885E3613C;
	Wed,  8 May 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gi7UOxxv"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A12C6B9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154157; cv=none; b=gzoSgNBkjFCDznnZ0EOrQ5FtAmrgodbDcUZt4xRSsfyVLE/dCjf3KA+KM76ogd1hQ5TljZMn9QJz1HsVDkrRkS9X0Q7hR4AGOPgiYdqH2JKLNpZDcfZ+iNJHdTfGAJ6vkGhdedbbHQGClaE89s30ORyyCFcLULxRNKFHbjpS7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154157; c=relaxed/simple;
	bh=eB82leL4MRWAJ3wXFubLY3J8xZ4NRhewKRY93691gcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTKxXOulYxWzCm+tKbTpqlzSelDRXnA3/Qr0MfRykQjaKsnzHj/rCE8y7IR9KMdDP2z7SYlg+lXUKoPXUvGcyGDHPwSxlqVDBUYSH1L2N+Tr0QQYL5IaQQnSioSgCvucpNMzbwtGLHwaYnVUKoHd+dYRSXJ09iJftM9eeUtzIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gi7UOxxv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so3131552b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154154; x=1715758954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=306fFAUpRl7xfsQbZN30LaodlrzrhLsXw6qfeFlE0HY=;
        b=gi7UOxxvuWzaJPfxQ3EgScNgq8kDiC2JE4YgD2t6pB0vPtUIkKyqL+q0tE5cVqX1k0
         hSBAl4heKeWUGeb1gUCFoqMf3JK/1xlTPfu8VZFmaEny1hvDELmc6P6fzXPAJuVkEIfl
         twkkUloPUUyvUJwxertHUua87AP59uRTtdVWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154154; x=1715758954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=306fFAUpRl7xfsQbZN30LaodlrzrhLsXw6qfeFlE0HY=;
        b=F/Ep49dURd0ukWCMfBVc7Snpd99ueY9mQHfkWkHweX7qPBh2ld7Q9KH5Lgau1rTW5M
         LOs95qMEYD3GdyQjAyGMgV+K4SkaG0/Y0Vg/A3H7rxluYvxrDn9bsBurP8TOXhi4hI5q
         YqPqXG/HE3ryKhINsbao+cCaZA07vfPjlshgh7vI/ifF1gaMyRrNu+SgeBfecZ07AeyM
         hXNSmXWnJd0VKUrUZBi05Q7F1xkL5yngThqVQ4RgTwUCx3GRl92vgvRl1apQMeVXH96H
         KS48JfoGWcumNyvnmHcxMKxlZCwR5eo3AUm6o9FhtUhtwtiSTjrwGKkoHnpdj50iKyog
         PBrg==
X-Gm-Message-State: AOJu0YyusSuSwzV+NBx2gid5a2m0iszQYTw/JnKe9geFUSRI15rM0s1A
	4uyHsfUiRxdMcee024qF9Yf3VKIt/w+DbyH9TOgYgC6pHxfEw/hO/OwwdOgcVE00PYZmHa92m3U
	=
X-Google-Smtp-Source: AGHT+IGIrGJqID06I2Gutp+RCotts2S1cA2S8dZ/ch2gbOVUVp8GVe6nSf6F/HFcfqb+prqAnkv54Q==
X-Received: by 2002:a05:6a20:72a6:b0:1af:a617:86ac with SMTP id adf61e73a8af0-1afc8e04b3fmr2309870637.53.1715154154562;
        Wed, 08 May 2024 00:42:34 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:34 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 00/19] zram: convert to custom compression API and allow algorithms tuning
Date: Wed,  8 May 2024 16:41:53 +0900
Message-ID: <20240508074223.652784-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	This patch set moves zram from crypto API to a custom compression
API which allows us to tune and configure compression algorithms,
something that crypto API, unfortunately, doesn't support. Basically,
this seroes brings back the bits of comp "backend" code that we had
many years ago. This means that if we want zram to support new
compression algorithms we need to implement corresponding backends.

        Currently, zram supports a pretty decent number of comp backends:
lzo, lzorle, lz4, lz4hc, 842, deflate, zstd

        At this point we handle 2 parameters: a compression level and
a pre-trained compression dictionary. Which seems like a good enough
start. The list will be extended in the future.

Examples:

- changes default compression level
        echo "algo=zstd level=11" > /sys/block/zram0/comp_algorithm

- passes path to a pre-trained dictionary
        echo "algo=zstd dict=/etc/dictionary" > /sys/block/zram0/comp_algorithm

Benchmarks
==========

*** zstd
/sys/block/zram0/mm_stat
1750302720 504600204 514416640        0 514416640        1        0    34204    34204

*** zstd level=5
/sys/block/zram0/mm_stat
1750331392 488449001 497905664        0 497905664        1        0    34204    34204

*** zstd dict=/etc/dictionary
/sys/block/zram0/mm_stat
1750335488 464838883 474210304        0 474210304        1        0    34204    34204

*** zstd level=5 dict=/etc/dictionary
/sys/block/zram0/mm_stat
1750319104 451907185 461299712        0 461299712        1        0    34204    34204

*** lz4
/sys/block/zram0/mm_stat
1750319104 664253635 676859904        0 676859904        1        0    34288    34288

*** lz4 dict=/etc/dictionary
/sys/block/zram0/mm_stat
1750319104 620602911 632705024        0 632705024        1        0    34288    34288

*** lz4hc
/sys/block/zram0/mm_stat
1750315008 609004936 621092864        0 621092864        1        0    34288    34288

*** lz4hc level=5 dict=/etc/dictionary
/sys/block/zram0/mm_stat
1750323200 501315128 511303680        0 511303680        1        0    34288    34288


v3:
-- support pre-trained dictionary in lz4
-- support pre-trained dictionary in lz4hc

v2:
-- forcibly select LZO when none backeneds were selected (Masahiro Yamada)
-- add 842 compression backend
-- added comp config preprocessing and caching
-- reworked zstd dict handling

Sergey Senozhatsky (19):
  zram: move from crypto API to custom comp backends API
  zram: add lzo and lzorle compression backends support
  zram: add lz4 compression backend support
  zram: add lz4hc compression backend support
  zram: add zstd compression backend support
  zram: pass estimated src size hint to zstd
  zram: add zlib compression backend support
  zram: add 842 compression backend support
  zram: check that backends array has at least one backend
  zram: introduce zcomp_config structure
  zram: extend comp_algorithm attr write handling
  zram: support compression level comp config
  zram: add support for dict comp config
  zram: add dictionary support to zstd backend
  zram: add config init/release backend callbacks
  zram: share dictionaries between per-CPU contexts
  zram: add dictionary support to lz4
  zram: add dictionary support to lz4hc
  Documentation/zram: add documentation for algorithm parameters

 Documentation/admin-guide/blockdev/zram.rst |  38 +++-
 drivers/block/zram/Kconfig                  |  76 +++++--
 drivers/block/zram/Makefile                 |   8 +
 drivers/block/zram/backend_842.c            |  79 +++++++
 drivers/block/zram/backend_842.h            |  10 +
 drivers/block/zram/backend_deflate.c        | 143 +++++++++++++
 drivers/block/zram/backend_deflate.h        |  10 +
 drivers/block/zram/backend_lz4.c            | 123 +++++++++++
 drivers/block/zram/backend_lz4.h            |  10 +
 drivers/block/zram/backend_lz4hc.c          | 128 ++++++++++++
 drivers/block/zram/backend_lz4hc.h          |  10 +
 drivers/block/zram/backend_lzo.c            |  55 +++++
 drivers/block/zram/backend_lzo.h            |  10 +
 drivers/block/zram/backend_lzorle.c         |  55 +++++
 drivers/block/zram/backend_lzorle.h         |  10 +
 drivers/block/zram/backend_zstd.c           | 221 ++++++++++++++++++++
 drivers/block/zram/backend_zstd.h           |  10 +
 drivers/block/zram/zcomp.c                  | 155 +++++++-------
 drivers/block/zram/zcomp.h                  |  42 +++-
 drivers/block/zram/zram_drv.c               | 120 ++++++++++-
 drivers/block/zram/zram_drv.h               |   1 +
 21 files changed, 1203 insertions(+), 111 deletions(-)
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
2.45.0.rc1.225.g2a3ae87e7f-goog


