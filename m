Return-Path: <linux-kernel+bounces-179551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4558C6151
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A389CB215D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465DD43AB2;
	Wed, 15 May 2024 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCH1ES/u"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387942061
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757418; cv=none; b=MSeRvI0xLF6W8x5tyxvI98+SwZnWBEFYksYEm+lFI6BgXCfaVrMyzQlwOmgnd+yLB6DpR0AeTHOnMOSffW2sOrr11ZPXukM+qcn+qk8/gM4G750aq8yMN31n/gX7sloolyMAILV52HpfGhv/00MZZ3ZzQLuqFTh0JlnHtdzktCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757418; c=relaxed/simple;
	bh=nMfzBYy/IKnygvUg6mHmh2PasEXMAt0h0sN3MQ6jjpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2nagdbCGddcS6nKwSWPKT5lyO9MTrnZ+diqo4HnHTasB0A8YeNZ1AyHKuwLhaL47q0xN1dBJeyEOTK3vcwFOHwhT5kFDnPFvq4btsa6lepzPE5e74m560FQeKbV4dMxQLGR9DyvjLvTAkMylsTZ6jlmWDBLeQ4UVKXnIoX4R04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nCH1ES/u; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ee0132a6f3so49757045ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757416; x=1716362216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqYLcxQwayuywWH1rsCyBGByNQv01b0ugqtKkJ7GT30=;
        b=nCH1ES/uKFmiBdaqV2bKVQvTJ343jBhcamlq2LFdfcGXOiTWek/7tM2KxpaHdXkcgY
         M+mI8fo+hDhQ06SrQVhTasWMY7puUm1YcKWVCqZ8FdyCgdhTacisGxqTFVoH9tB65tGg
         DA/N6U3JTH0+o/4dDGCYju9kEz0czi3LTSUss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757416; x=1716362216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqYLcxQwayuywWH1rsCyBGByNQv01b0ugqtKkJ7GT30=;
        b=AHHRnSQEJ4MHQDqlqpLN8e8fC83xRf6X+OPcVBHiAfroAFrFp9ErZSK9NwKYitkjwm
         viuB3SRQQ0r1w3URJ0P8l9yXFLdBIe6aP1i4Za27biPGLiMh1RoH41G/Qqf7z6ldQcf2
         XRzo8DVECv+jM89IkbuWw/TXdnnPrd5jSTl98poDM0weqevl5X18SGr8kqJk5wvHTNT7
         a4pY336txizIbzxB0EFBottmNQKBh1YUnoHEvV7cZmmGV5zI59rMLvms9SbiX++SNfKm
         R1RGhaNE7XpLgzZvcNcPWg4jTwqH3slkrtc39Hvix94B6Ti/Jd/wmaXzpFlGcM5U58N3
         mFww==
X-Gm-Message-State: AOJu0YwfccnB/ea76ChBCPK+a9kqGO9IbzLFvNlr+3E+9jpqSNeI+SpZ
	Wbvrtsw5lFBErRPQ9F1rHfXtvy9D3nwJADYqYt/7r+M4ZzOjead1u1mt/REPabfFQfgIFshaNjw
	=
X-Google-Smtp-Source: AGHT+IFm/nXRy82CuAgQxP6v9tK0QrWnblDLayE/IvdgtiIEFVabYJ0aogguwVbyzlQiqncW5RLhBA==
X-Received: by 2002:a17:902:dad2:b0:1eb:5293:dc37 with SMTP id d9443c01a7336-1ef43c0cf65mr170232545ad.10.1715757416182;
        Wed, 15 May 2024 00:16:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:16:55 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 00/21] zram: custom comp API and comp algorithms tunables
Date: Wed, 15 May 2024 16:12:37 +0900
Message-ID: <20240515071645.1788128-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


---8<---8<---
This series contains important patches which we either can apply
as is (if zram makes a switch to compression backends) or cherry-pick
(if zram sticks to crypto API), as compression drivers/backends still
need to be patches regardless of direction zram takes. Sending it out
so that the patches don't get lost.
---8<---8<---

This patch set moves zram from crypto API to a custom compression
API which allows us to tune and configure compression algorithms,
something that crypto API, unfortunately, doesn't support yet.
Basically, this series brings back the bits of compression "backends"
code that we had many years ago.

		Currently, zram supports a pretty decent number of comp backends:
lzo, lzorle, lz4, lz4hc, 842, deflate, zstd

		At this point we handle 2 parameters: a compression level and
a pre-trained compression dictionary. Which seems like a good enough
start. The list will be extended in the future.

Examples:

- tunes compression level
	echo "algo=zstd level=11" > /sys/block/zram0/comp_algorithm

- uses a pre-trained dictionary and tunes compression level
	echo "algo=zstd level=11 dict=/etc/dictionary" > /sys/block/zram0/comp_algorithm

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


v4:
-- fixed ZRAM=m build error (kernel test robot @intel)
-- added compression level tunable to lz4
-- export lz4hc symbol needed for dictionary support
-- export advanced zstd API needed for dictionary support

Sergey Senozhatsky (21):
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
  lib/zstd: export API needed for dictionary support
  zram: add dictionary support to zstd backend
  zram: add config init/release backend callbacks
  zram: share dictionaries between per-CPU contexts
  zram: add dictionary support to lz4
  lib/lz4hc: export LZ4_resetStreamHC symbol
  zram: add dictionary support to lz4hc
  Documentation/zram: add documentation for algorithm parameters

 Documentation/admin-guide/blockdev/zram.rst |  38 +++-
 drivers/block/zram/Kconfig                  |  76 +++++--
 drivers/block/zram/Makefile                 |   8 +
 drivers/block/zram/backend_842.c            |  79 +++++++
 drivers/block/zram/backend_842.h            |  10 +
 drivers/block/zram/backend_deflate.c        | 143 +++++++++++++
 drivers/block/zram/backend_deflate.h        |  10 +
 drivers/block/zram/backend_lz4.c            | 128 +++++++++++
 drivers/block/zram/backend_lz4.h            |  10 +
 drivers/block/zram/backend_lz4hc.c          | 128 +++++++++++
 drivers/block/zram/backend_lz4hc.h          |  10 +
 drivers/block/zram/backend_lzo.c            |  55 +++++
 drivers/block/zram/backend_lzo.h            |  10 +
 drivers/block/zram/backend_lzorle.c         |  55 +++++
 drivers/block/zram/backend_lzorle.h         |  10 +
 drivers/block/zram/backend_zstd.c           | 223 ++++++++++++++++++++
 drivers/block/zram/backend_zstd.h           |  10 +
 drivers/block/zram/zcomp.c                  | 155 +++++++-------
 drivers/block/zram/zcomp.h                  |  42 +++-
 drivers/block/zram/zram_drv.c               | 120 ++++++++++-
 drivers/block/zram/zram_drv.h               |   1 +
 include/linux/zstd.h                        | 165 +++++++++++++++
 lib/lz4/lz4hc_compress.c                    |   1 +
 lib/zstd/zstd_compress_module.c             |  52 +++++
 lib/zstd/zstd_decompress_module.c           |  38 ++++
 25 files changed, 1466 insertions(+), 111 deletions(-)
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


