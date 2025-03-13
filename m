Return-Path: <linux-kernel+bounces-560352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EABA602EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EB019C5CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714A145A11;
	Thu, 13 Mar 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs7fy+iL"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7A170A2C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898716; cv=none; b=W8yIB9DOqfOioO43VbcivVrLGedB8aL1El8sKTQ9D908osf73prTCu4BKx7y4IkuXjtYFDGjBcXs1pR1O6XxFH0lhgUWhW2dQXtcaZbi1LAGA7GTKmTP1dYeAa5WvDJlaxRFcGe+aham8ZT7R7hKRvi/cNT9wFotqElP5OFIgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898716; c=relaxed/simple;
	bh=h/PZba57YaygA4+DGoD0Z0GT+Z1Wv1AQOQhKSTXDQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQE+FDyFvaKURbtKXdryvczJvTY4JoBtlNggpViOlHz6DGhKxO8t2r2v5QeeYOM6KCSCktgu6/q+ayfkliZmx3KeolozNtT3fAoJOWr/qGCeIec0hfcBLzQNMtAI+psjv35tNigCOCLMt0l34o3VS6iANg2C/8hLLDY8r3b15DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs7fy+iL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08fc20194so232173685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741898713; x=1742503513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kE1csnvS+47tJJsqPMI5ZlympUsvwu7nvBXwgzZyAK0=;
        b=Cs7fy+iL6nldsfJJkGnO5HXSlVnAtHy79Q5f0STsqbhj9MPwcZJDc1wx1HP+LkxnxX
         uP3eSmGWmWdCXBuuil00ZhQTn/u3S2hGdtUzkC77an8ljjrhw8q4RcCJP2EDPUFgAeO/
         jhvNkryBhSbOGw4WEG6XK7u1myPHkcIhKVGxLheWyQbsGt0CbK6NH3GlmF5lV/JA+cNS
         e3XBCe/YcDCjjHtuF+gJz7x9noj6IXH2NLwzRVQ4wUKfQA+L2HcT+EsIMsQ2lv9iKOTC
         I6fPUnveLE3fyIP8hZFHgZG4mB5lQQrXOAe3AAm8Kns/TLMPsGDis6mP8Wgt5Ll7BvFY
         LmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741898713; x=1742503513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kE1csnvS+47tJJsqPMI5ZlympUsvwu7nvBXwgzZyAK0=;
        b=QJZgHU9zYsoZcNRnNJzjALawU0uubBCNjh0c2JhZXPf2TyLAJUPKSbKg0NmS/lb5p/
         gvF1kPZ2cWjid/3pkAlxQ5ro3aMTiAv4X8/Q6eU9Rz+qMMxF8b9VDnFhsuM1nK7Sro7+
         vmvLP0ltm6KH7eZz3jU6PxAa2hEHWSz05C1rBPg+izpFNRQaOtBR6n3+33l+S+rKPIp3
         HaeVCkPhOr/RRpdWxcL2c8URFgvoRoCPqI6z08HEf0JG/nOVYyMN31FEorgWjnWnmzq4
         cFgswJUQjio/xq96q6+2DjBiPxYYl+3pAlZMzf9asvYmDkN0capDVGIixV57aPl1Hyf/
         Sd7w==
X-Gm-Message-State: AOJu0YyRy8C33VB7RJocnHsH+V5JylClo+NHJ6Cc5DIg9sPUuiY4y8tY
	ym75gmp51VpHspia9myM8kESS1evAJwD2KFzz0KYyYSunmGLPzURe8xmxw==
X-Gm-Gg: ASbGncsB8Q2UdaD4EmynW1vXRtEKY+8eyZfNx5AFT7b7P6FoXeKHbtQ0/2kGgjNqYF0
	pUVixvwOc1qlreB+sMEyD3+/a8OAjaVa2HdDoPJbcJiiayLCLoHZZ8MSW8m4HEnMRCCXINoinZw
	Ybs3KBdZcK46rMps7nyQSfRdyHOkqpViP1rDqh6IRgwqKZ5VdIIbWPvP9OoyA1JtluikM1XvKPc
	YNUhYhbC9nZ6ypafBBCFafwZ5EMeDksMbIq4FhZJBXXQ/LPf+XaNvVsrukMwin7eNYtrTWl25nZ
	sycwTGgSmnOEyK+UiVGRt+y9XKVOSDLsgW/HsDzUBOtzKAy/KgZtdeCq8NH+7mHwXQEQ9pXrcpH
	brsQzuJtG66h9e+cBoR+E4upEwjz0QsdsuJO4EY6EQgmm
X-Google-Smtp-Source: AGHT+IG852wdBA9l0iaL2AVJOxRaVmH75HfWEYP574Dx2b0ZKZ9FXdqmOCb84Jo8MlPSVhW34Hk6tw==
X-Received: by 2002:a05:620a:880b:b0:7c5:4a3a:bc12 with SMTP id af79cd13be357-7c579f3741fmr206694085a.32.1741898713195;
        Thu, 13 Mar 2025 13:45:13 -0700 (PDT)
Received: from nickserv.taila7d40.ts.net (pool-173-52-224-122.nycmny.fios.verizon.net. [173.52.224.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c714cbsm141348585a.30.2025.03.13.13.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:45:12 -0700 (PDT)
From: Nick Terrell <nickrterrell@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Terrell <terrelln@fb.com>,
	Nick Terrell <nickrterrell@gmail.com>,
	Kernel Team <Kernel-team@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 0/1] zstd: Import upstream v1.5.7
Date: Thu, 13 Mar 2025 13:59:20 -0700
Message-ID: <20250313205923.4105088-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nick Terrell <terrelln@fb.com>

Since this is a large patch, I have also prepared a pull request as an
alternate means of fetching the commit:

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://github.com/terrelln/linux.git tags/2025-03-13-zstd-v1.5.7-v1

for you to fetch changes up to 65d1f5507ed2c78c64fce40e44e5574a9419eb09:

----------------------------------------------------------------
zstd: Import upstream v1.5.7

----------------------------------------------------------------

Nick Terrell (1):
  zstd: Import upstream v1.5.7

 include/linux/zstd.h                          |   87 +-
 include/linux/zstd_errors.h                   |   30 +-
 include/linux/zstd_lib.h                      | 1123 ++++--
 lib/zstd/Makefile                             |    3 +-
 lib/zstd/common/allocations.h                 |   56 +
 lib/zstd/common/bits.h                        |  150 +
 lib/zstd/common/bitstream.h                   |  155 +-
 lib/zstd/common/compiler.h                    |  151 +-
 lib/zstd/common/cpu.h                         |    3 +-
 lib/zstd/common/debug.c                       |    9 +-
 lib/zstd/common/debug.h                       |   37 +-
 lib/zstd/common/entropy_common.c              |   42 +-
 lib/zstd/common/error_private.c               |   13 +-
 lib/zstd/common/error_private.h               |   88 +-
 lib/zstd/common/fse.h                         |  103 +-
 lib/zstd/common/fse_decompress.c              |  132 +-
 lib/zstd/common/huf.h                         |  240 +-
 lib/zstd/common/mem.h                         |    3 +-
 lib/zstd/common/portability_macros.h          |   45 +-
 lib/zstd/common/zstd_common.c                 |   38 +-
 lib/zstd/common/zstd_deps.h                   |   16 +-
 lib/zstd/common/zstd_internal.h               |  153 +-
 lib/zstd/compress/clevels.h                   |    3 +-
 lib/zstd/compress/fse_compress.c              |   74 +-
 lib/zstd/compress/hist.c                      |   13 +-
 lib/zstd/compress/hist.h                      |   10 +-
 lib/zstd/compress/huf_compress.c              |  441 ++-
 lib/zstd/compress/zstd_compress.c             | 3293 ++++++++++++-----
 lib/zstd/compress/zstd_compress_internal.h    |  621 +++-
 lib/zstd/compress/zstd_compress_literals.c    |  157 +-
 lib/zstd/compress/zstd_compress_literals.h    |   25 +-
 lib/zstd/compress/zstd_compress_sequences.c   |   21 +-
 lib/zstd/compress/zstd_compress_sequences.h   |   16 +-
 lib/zstd/compress/zstd_compress_superblock.c  |  394 +-
 lib/zstd/compress/zstd_compress_superblock.h  |    3 +-
 lib/zstd/compress/zstd_cwksp.h                |  222 +-
 lib/zstd/compress/zstd_double_fast.c          |  245 +-
 lib/zstd/compress/zstd_double_fast.h          |   27 +-
 lib/zstd/compress/zstd_fast.c                 |  703 +++-
 lib/zstd/compress/zstd_fast.h                 |   16 +-
 lib/zstd/compress/zstd_lazy.c                 |  840 +++--
 lib/zstd/compress/zstd_lazy.h                 |  195 +-
 lib/zstd/compress/zstd_ldm.c                  |  102 +-
 lib/zstd/compress/zstd_ldm.h                  |   17 +-
 lib/zstd/compress/zstd_ldm_geartab.h          |    3 +-
 lib/zstd/compress/zstd_opt.c                  |  571 +--
 lib/zstd/compress/zstd_opt.h                  |   55 +-
 lib/zstd/compress/zstd_preSplit.c             |  239 ++
 lib/zstd/compress/zstd_preSplit.h             |   34 +
 lib/zstd/decompress/huf_decompress.c          |  887 +++--
 lib/zstd/decompress/zstd_ddict.c              |    9 +-
 lib/zstd/decompress/zstd_ddict.h              |    3 +-
 lib/zstd/decompress/zstd_decompress.c         |  375 +-
 lib/zstd/decompress/zstd_decompress_block.c   |  724 ++--
 lib/zstd/decompress/zstd_decompress_block.h   |   10 +-
 .../decompress/zstd_decompress_internal.h     |   19 +-
 lib/zstd/decompress_sources.h                 |    2 +-
 lib/zstd/zstd_common_module.c                 |    5 +-
 lib/zstd/zstd_compress_module.c               |   75 +-
 lib/zstd/zstd_decompress_module.c             |    4 +-
 60 files changed, 8749 insertions(+), 4381 deletions(-)
 create mode 100644 lib/zstd/common/allocations.h
 create mode 100644 lib/zstd/common/bits.h
 create mode 100644 lib/zstd/compress/zstd_preSplit.c
 create mode 100644 lib/zstd/compress/zstd_preSplit.h

-- 
2.48.1


