Return-Path: <linux-kernel+bounces-169443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF778BC8C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FB8282398
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F9874416;
	Mon,  6 May 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBRceoP3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B25140389
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982326; cv=none; b=AdBLi6HpLCRTde/Lsy/JGLcyldh4se8i6k86KD3DsueELf4Xxv8nwHTgPVxE7pn8nifo75xeUXhJvrlf0/PzLCKRIlvmHaGPwD2G8dZHFBlI5gJHyUOJTHaV45tpp1O81ZGojG7i6NOPpKdS7pQtTCKhbHDKSgLZKhK8KiXoN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982326; c=relaxed/simple;
	bh=+iN5Fimw/oMvE8vrIcZdStGp312WiODbiBRJwyvrt78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dC0dAQqg2Bdt90Nd3QQfqwe7BvEapPsMNVlCxujv7ZU4V+QbWRjBHzZSciNM/L9We6gzYQY01aLivHrmuN/U8+pB4IOz6wCYzXwwt/mSJq6E5tW6zMDPMgEYDudLhb6lCbH2xeFZVB98CiwaIntIsrg+UbHR9f+tXuoZeHU4r+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fBRceoP3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3c3aa8938so9162255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982324; x=1715587124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iph2BBUDrLd0ccfcukGpHsquu5IaKabhmqFooTCog18=;
        b=fBRceoP3b/bEPVuLrPBS3qL4TjTZ0Swp4LzHadWuccqyQRCUAbTjgTLyoR8bnAWXXA
         8g4UYvOujnzQTrwTrX2TFP6rp8nu96zCJA86t44/zVUp4SdRnWcfwBABhSt/NlSyzwwb
         RO93Vtrz+OBHNVsGdwIkjjrTJRf6JOF6/VYU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982324; x=1715587124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iph2BBUDrLd0ccfcukGpHsquu5IaKabhmqFooTCog18=;
        b=EmzIszaEEARcs7W0rTGEojpKmLxROpaujEKi/4wnLluTfE71NzY3saXxS1sc0jZ+G3
         M11v0xFmpiQWqnjxTbiwPqmleVcKbczD1EOg822CsqDyNtjOPPiyeU0ywW+LLthlz5o/
         QGXIBOPcUGxmxVt625zETPmYlNFPe4tGroAlSxED6ftFeuvQAWhmKd+jOnvjGMtA8BY+
         ouYtYV8A3Pa5WrHV0cNBy2dvtiQT7X6I2zLLCJ6L+59qcZ0iMHEQGIHB6fHl77wjWr1r
         XZ42joGQKhlocuXwsO4pTgcbXdqBCFg7MANHToVS3PCUrywJKJpV4NwmKQZrlJEydHML
         Go5g==
X-Gm-Message-State: AOJu0YxKdpol5SJ1Xbif+oyf/8W3RBtpno4dqavE3NAb9NkbwgI86APY
	BcLSQ1plnQV5XCAtvvLKaKMtAGdFwyUDrJwnR+D7DYPH6ojl39uZosO3gXTRkw==
X-Google-Smtp-Source: AGHT+IHZlStE6NFuTvrmuw2MDkGyODvBNkyba0GavYlXo3JC/69EVQE95aar5jC4CyOFFI3sVQU1tA==
X-Received: by 2002:a17:903:2693:b0:1e9:6609:37d5 with SMTP id jf19-20020a170903269300b001e9660937d5mr7981323plb.27.1714982324445;
        Mon, 06 May 2024 00:58:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:58:43 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 00/17] zram: convert to custom comp API and allow algorithms configuration
Date: Mon,  6 May 2024 16:58:13 +0900
Message-ID: <20240506075834.302472-1-senozhatsky@chromium.org>
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

TEST
====

using default zstd
/sys/block/zram0/mm_stat
1750315008 504602831 514256896        0 514256896        1        0    34204    34204

using zstd level=7 dict=/etc/dictionary
/sys/block/zram0/mm_stat
1750310912 432540606 441712640        0 441712640        1        0    34187    34187

v2:
-- forcibly select LZO when nono backeneds were selected (Masahiro Yamada)
-- add 842 compression backend
-- added comp config preprocessing and caching
-- reworked zstd dict handling

Sergey Senozhatsky (17):
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
  Documentation/zram: add documentation for algorithm parameters

 Documentation/admin-guide/blockdev/zram.rst |  38 +++-
 drivers/block/zram/Kconfig                  |  76 +++++--
 drivers/block/zram/Makefile                 |   8 +
 drivers/block/zram/backend_842.c            |  79 +++++++
 drivers/block/zram/backend_842.h            |  10 +
 drivers/block/zram/backend_deflate.c        | 143 +++++++++++++
 drivers/block/zram/backend_deflate.h        |  10 +
 drivers/block/zram/backend_lz4.c            |  58 +++++
 drivers/block/zram/backend_lz4.h            |  10 +
 drivers/block/zram/backend_lz4hc.c          |  84 ++++++++
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
 21 files changed, 1094 insertions(+), 111 deletions(-)
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


