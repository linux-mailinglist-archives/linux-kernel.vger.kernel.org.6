Return-Path: <linux-kernel+bounces-333035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A297C277
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04251B21DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2018E11;
	Thu, 19 Sep 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S2lA03LY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB920B35
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709744; cv=none; b=ccRoYs+iXfatreVEEdLiVa8FLfRtU2D3OMI4S1ar850GRbUXNoBYA4JpUsjyF6kIJ3I0EY3AScGwKaGjuqHYHHd9eq2IrJrfSBShbID78y+un58Q40PV0uSOBMeOMlCMM0+73lHXYIywG4TkgaXfh16gh0vWDOs8Pw9y1LH25IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709744; c=relaxed/simple;
	bh=F8b1g0Z92Ug19zyp6jdn3B4tPcHN849288VrkCnUjIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQUPME3tTxr3Ld0b9NAM8YDmQ7qlMHN87mCWpJlazfLTcmyJye+0f49rDzkIgzr3F0bIlrTJ1YsMtzGbr4e57jkJuJZiQl0CYeBwRBAHCY2BWqYS+LSaxiluRAPPcKsljF9rxouWtb397zOHpU1pBqM4PCClvVs/gM3JsMWnS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S2lA03LY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7179069d029so221313b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726709740; x=1727314540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PRoelqNRnL/2mNFBQIluG5bm8U+edM43UW4Amub3LA=;
        b=S2lA03LYEWc4BDSAzAnAmd7kYqJ3LPl81V4f9eQLl3bSVJgD5PGPy+zF5UQX4MOK8I
         RJx3z44fN0LC338zpq6MA4YzEZIT4QW/tWa/cG0iIZvHuBj4zW/OwtMjwvkMYZpH7poh
         SI5huoJgL0+UYBBW1HKSnbXnuo9BqugoApR9FGcs4TfcqDv6pX8+7+Bldr4l44eIHyEx
         63bYjEcdN77AuEvIbNu7AO4q4GVU8fd72YJ/09mWOTuZj6BPpMW6DNLWmukmDeoCi65s
         +c2upaj6spkCTad522CIqbESygcELibXEZC6vp4S0qGfglo9RcVSqPxrVv98Pm+jz0Pr
         JNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709740; x=1727314540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PRoelqNRnL/2mNFBQIluG5bm8U+edM43UW4Amub3LA=;
        b=JI4P+sKKXOLewG5lT5428U0KPlXhIYPS4ZxYl2wLe2ba3hNy8jqCLz7Lqgg3Z0SREK
         Sl4A6pg5s+CJpy/EcVmpMyQGXCqzu46BRtt4bfUntoYYwV/YFe0QCxhbl2uLgElnJ36L
         v14bGRBgZYwJsgPYVYREbBh+vo4xeS6BiKTfUVNQhBvRK4t6PcTW5nOS6XXCgn9NeufE
         nnr/IJSM/U9Ham5EqU5yAS/1bky4wFurIhgynrr9fwVFShuaZsUNjMMji4mX/xwEADgK
         K9z1PHSM/Urn/Ja/1ggs78uzizxjpcva/lN7LmFwvAO+gsineM5SUS1dftdwDJHgMse+
         krGA==
X-Forwarded-Encrypted: i=1; AJvYcCWexv/Rxmrw/IxGXDSJt/VmKBt1wpGtEGgCTEGtM/gxEOQ3ez03BwYlhcSNJLUduJi7guwnyTgSg0uUin8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtHFxWG1ZbRNyRm3wRt9niI8XgQFU95utRd/6J9+yiWI+GVch
	3gG0BmYwa89p8iBc6iBUl7lwS75usa0GnpUypgZl5+vgMLEczypJitICLvA5tms=
X-Google-Smtp-Source: AGHT+IHbp4ok7dwua8+rGMyIXaJ4OmQHsgI/Zg3VmaOM5LiSUWeDv79Fh3Tgx0+xDLeSw5mSA3VQvQ==
X-Received: by 2002:a05:6a00:1799:b0:714:1bd8:35f7 with SMTP id d2e1a72fcca58-71936a60297mr27646676b3a.15.1726709740529;
        Wed, 18 Sep 2024 18:35:40 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc9ed9sm7282482b3a.209.2024.09.18.18.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 18:35:39 -0700 (PDT)
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
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Cc: yangjihong@bytedance.com
Subject: [PATCH RESEND v3 1/3] perf: build: Fix static compilation error when libdw is not installed
Date: Thu, 19 Sep 2024 09:35:11 +0800
Message-Id: <20240919013513.118527-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919013513.118527-1-yangjihong@bytedance.com>
References: <20240919013513.118527-1-yangjihong@bytedance.com>
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
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 5938cf799dc6..6f1c961f0ede 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -172,7 +172,7 @@ DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
   DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
-  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
   LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4dcf7a0fd235..0049fd41cf57 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -149,7 +149,7 @@ DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
   DWARFLIBS += -lelf -ldl -lz -llzma -lbz2 -lzstd
 
-  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
   LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
 
-- 
2.25.1


