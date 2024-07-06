Return-Path: <linux-kernel+bounces-243036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681379290EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3951C21832
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC01799D;
	Sat,  6 Jul 2024 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ycs3Wc2q"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2142134A9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241812; cv=none; b=Ayemtz9e8nTxc/hyfIO6CpNoxzCHhM0uefX4gTmV2oqonxUUU+5CJbaDy5Ct4youI13z2pAyRxYVozAUsnmfP6KRm1o2Cgwxs/oFxvIHyDl5kLHq7MsYx6SvzgWhwZaGHEHzdi2WdvYKt2pl2eXxnv1iD2E19XNvXflkLeJDvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241812; c=relaxed/simple;
	bh=qkMi/ynGyA2/aPn21jmMzasvxMQNZ5RzP5Hk2NkFx9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8NibpzxriojzCOles8Ej7QHqp9glsqSeLzaKbodA4C9BxoirDz3jMpYXRda6rSRHruv3UVGura57yDpI0vM1jYShabtxZH/+jVBUAVyIwqZRBs9aC4+iq1RqWGeSyi1FcrtL8Lh5vu1HjXWMSukfklkfT0m/EHOanj0kHD46P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ycs3Wc2q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b417e1511so21410107b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241809; x=1720846609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMvquzmJ/pLVy0PQgsVqNH/SWYtVf1EAzcNwWiB8K/I=;
        b=Ycs3Wc2qHcLLyqGI1Id7PVR56YwZu44T9tjwSKy7OBil2mSG610adA98pE6Y1WlKbw
         ynIlhyLIOTJbTCdXaxJJIr7BwcowwqshOSOcNZt1grCHM8FDhQbTugLNcN60RKrh9uKP
         uvHaBb/dkDavWBj3DC6mn/64uFT/aVuiCjw18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241809; x=1720846609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMvquzmJ/pLVy0PQgsVqNH/SWYtVf1EAzcNwWiB8K/I=;
        b=Zbpn5OLe6YyeKwdI8tRxUNz3R0TN13RUDFoQD1E4p46knF5GJH50qg9/ml20PEsuyi
         C+CwOgTZWVARM4yr6UkIaK8KXIGMmcy/ZDHfAjW+B6Xdc8sEzxmWLP/hw23rY57SLi6A
         kfbLLA8viR/yBJiWQuqVAvLJKBYBGL7ZIbuzcRrdsqN916VwfKG3PpQM31HWnMwWT/9M
         B/K0NrRMlT0R0BSdKg4ufEwf9+jsvBLNxmcKZgYPKo2MZtWEX+mqHJiUYW7DCIzn/tQt
         kTxExMNN0WQPZY7JnRd8MLP5R/Td3PowE6Liao1HVSC9osHgXNtdXLDn/DXz771e5frq
         KFog==
X-Gm-Message-State: AOJu0Yxt3pK5N30yHB92JAnuHQ46AEqw4AiSaqdVxYNsK5OSzaWVDpVo
	aDQdeHVXL7eq3lGBGCZemok5cUV2CXOOYatP8+CTRF0NqxUN2zYOiokIsGfoEA==
X-Google-Smtp-Source: AGHT+IFDzNUpg6KmsGjmpJK5sKrurgZ8Oz39gX3KJ2EOnuAtjUeFidXjw1P2qRNxdjDik+W/ipI68w==
X-Received: by 2002:a0d:eb93:0:b0:650:93e3:fe79 with SMTP id 00721157ae682-652d853531bmr60982157b3.51.1720241809611;
        Fri, 05 Jul 2024 21:56:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:56:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 00/23] zram: compression algorithms tunables
Date: Sat,  6 Jul 2024 13:56:02 +0900
Message-ID: <20240706045641.631961-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
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

v4..v5:
- minor improvements to zstd API (stopped exposing ZSTD_dlm_byRef
  and ZSTD_dct_auto)
- fixed null-deref in ZSTD_createCDict_advanced2()
- major rework on the zcomp side
  - new zcomp_params structure, new zcomp_req structure, and so on
  - moved immutable params data out of per-CPU ctx to zcomp
  - etc.

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
2.45.2.803.g4e1b14247a-goog


