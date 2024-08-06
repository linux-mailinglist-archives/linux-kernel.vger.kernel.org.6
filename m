Return-Path: <linux-kernel+bounces-276072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AA948E13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3497B23C66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38E1C233C;
	Tue,  6 Aug 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ekw7O+Bk"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF11C4602
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944899; cv=none; b=PfxmkmpCmrzisQMcUVbYa7bz1NsWaHNz543w5O1EhNpJFGVaubH4+88a1o6ZxwPG97vkG5t3neSGITN29KHGatTwA+MRDCnL/SuuvQvHakJUY4XYTzw4AomBux9Vsg+JtzE10QD10eXOW7+iA3Bb2UKevqKTaJlWeR60tXjPt5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944899; c=relaxed/simple;
	bh=lLK53uiQC3bZkEy2L61h0TC52VfEBeHo0ujP19/cMQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tf/2NQKTFr3qBlwmqRyubSx7SSiWbDFrTIUD2WHLIA4xsJsDa0h1odmctok0/KeVkohIhSg3jXF7vQ/za0YnusLmiB8ezy7fJY2txHEsx4BzQEki5q+SgyqcJpsLuA5tzC7CNbPsDTotIHcbnK6Dr0Kv7DKbv6Nb9bxBTBMXRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ekw7O+Bk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so348074b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722944897; x=1723549697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szK4YRuHQJi5DajMaeZdCXTgp1QcycA8fBZf8lAoRyI=;
        b=Ekw7O+BktCuwZYCq4vKqDcl6JBeXVbY3JXFhbfuG0sOVzWr1ldnFl6QiATgiOVWKkb
         SQr8I7hroGItrlcwoIHq+0pQcjJaCLcKdy97LL8RubBYZ04krJByhikEkLS2W0Fj6Bco
         mGW73wXnO3B7th/Q/H2aYLudvbelNLlL2P4AfpI2jWPOP9u/mGBCKyHR1+tRfto0l97D
         cn3kY/oiZoRvZWAvs4HiZqC0H+fWa3kT4ZUUG+BWGi0lW49ycBBMiAzQiiMgsVo5BY7n
         yr1T2PaxfkKUNr003+sgfj5cqqUF/F7KhZkHjn3y+rXRjC9fk3/8mhWxLwHznGOCFdeQ
         JUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944897; x=1723549697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szK4YRuHQJi5DajMaeZdCXTgp1QcycA8fBZf8lAoRyI=;
        b=hh0WP3ec98Uv9vuVD8ek1hpl3+ARvtBXf6i/P3AKugJoMCuQBF2IBiDs23RkqTQ4Oz
         vZrNQPM9wOeXUA+A9MMLRhNzLZHhmzJG/V59EMtEQQTcG0SlnXHMR++iWBnW2YAmTuCs
         Orpccdxo5euveM8+lConMQdUkRXdgaiIu8nPSvKXb1iHPv72OwODvL8D6nn+pJKuip5L
         xI8xHPxQ9Th0T5tauYn33crMU6KTIGVSlvexlUtCFM6gPCzyJtP39IT00usBIna4Uw9J
         J8UKS0aODpmShW1uOuqsYuLHqG83mpT0D9Kv1LZ3NY80JgX33bEoAsa2CITYBmvJjaaj
         Qx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkhTZKIW3UyRjghlpxCwI6Mbez+89U3N5BGZ/1vfPPENXf8409v5iaG/uv6UbyaMDJCWHs61z+V9gH2toSvvExPz0DOXZbundLXXpS
X-Gm-Message-State: AOJu0Yza+Mb38rt9Ld+Tj5Hpm+GQ1oVJI37gc6ipVoMGJWC3Y+Hk7fJd
	csyWCUtWZJXhYIMq7/04r7Hy0gPiglxUkqxJb7TNB5RHIvkRofXjb06mfVKhP/4=
X-Google-Smtp-Source: AGHT+IFdZ7eYHp2tmqJYcz5HMBgb90qZGuZ8bq6DyGDAHkGFzGLnob6VV7mkGgw4Wou6vWzfbqVFtQ==
X-Received: by 2002:a05:6a20:7faa:b0:1c3:b47d:d53f with SMTP id adf61e73a8af0-1c6995a1f7emr19507362637.25.1722944896989;
        Tue, 06 Aug 2024 04:48:16 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm6831705b3a.75.2024.08.06.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:48:16 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 1/3] perf: build: Fix static compilation error when libdw is not installed
Date: Tue,  6 Aug 2024 19:47:59 +0800
Message-Id: <20240806114801.1652417-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806114801.1652417-1-yangjihong@bytedance.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If libdw is not installed in build environment, the output of
'pkg-config --modversion libdw' is empty, causing LIBDW_VERSION_2
to be empty and the shell test will have the following error:

  /bin/sh: 1: test: -lt: unexpected operator

Before:

  $ pkg-config --modversion libdw
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  /bin/sh: 1: test: -lt: unexpected operator

After:

  1. libdw is not installed:

  $ pkg-config --modversion libdw
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  Makefile.config:473: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR

  2. libdw version is lower than 0.177

  $ pkg-config --modversion libdw
  0.176
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>

  Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>
    INSTALL libsubcmd_headers
    INSTALL libapi_headers
    INSTALL libperf_headers
    INSTALL libsymbol_headers
    INSTALL libbpf_headers
    LINK    perf

  3. libdw version is higher than 0.177

  $ pkg-config --modversion libdw
  0.186
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>

  Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>
    CC      util/bpf-utils.o
    CC      util/pfm.o
    LD      util/perf-util-in.o
    LD      perf-util-in.o
    AR      libperf-util.a
    LINK    perf

Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 12796808f07a..b18513ec4da6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -178,7 +178,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
-  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+  ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
     DWARFLIBS += -lebl
   endif
 endif
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fa679db61f62..7d1003d2efb2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -160,7 +160,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
-  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+  ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
     DWARFLIBS += -lebl
   endif
 endif
-- 
2.25.1


