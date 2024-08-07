Return-Path: <linux-kernel+bounces-277234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF16949E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F911C219F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5EF17AE0C;
	Wed,  7 Aug 2024 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IKGeicuy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884C3F9EC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000838; cv=none; b=oO8/6b32BmTubxiGCGfvsUrliA3RM+q3mfEiUcocRP78NqWbt2a3oRXvoMbxNCR+4XKpko8rZQWhvPRZsBjqhdOPx6g+n4PWgtVT4TR0BsbSNg9KL93wEOFlLowgKr+wpwIMfIucTA+76BohXAOlsDkOUjajE41U6qanHPw52hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000838; c=relaxed/simple;
	bh=booZHkb3J+P+9GGvIu7tV+nPBnPKParzLCabNBXvnRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fe3nrV88RJsAXMyH/c1h2yQM8kjALTmBne65Ll/h9SUhzzjIU2L0Rur3pUSmm6hBLuV8Grht53km9vyQktPaObFarcExlulrkMrELlr4j5J8K261FZaCFr4JBZ3k82KyQgbomdVUxrH3jpiMA63bnRGtSSHAmVUIL2YDgU71Tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IKGeicuy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fdd6d81812so11788405ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000836; x=1723605636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aAlB9PgJPPOtppfWCUQ5EXdOMFZzMBqg7ZuOwVCeYY=;
        b=IKGeicuys95nsnuwNpxp5JmLMvmZKHVEzgqQU8LkLqQjR/x3egfQ6Bl13jj4mhvD6j
         iCG958ETffsGwDoUUKG5u/2IxlwLKMpmkthLDHw2f6vEzQt74vJ/4FXP67vxJvRuk1vI
         5L2XjwwfdoS2SatdHXDaqB4xMM7KudgefBHk1fgb+TW6lRfse4HtNE0g+32eQ7DTw1/k
         i8uEPVPO+ieWzbgO53tPHgVmcBoXwZ6r1k+Fm13KZBSRwbMJ1ofQgyqUcAWEp4s9MhlP
         NY1Gqs/UH7fcfQFchJFEWMQKqOQfobNoBbQX+Z84re7Ro0nK58DTeMnFPm67qEUVY4Bx
         oVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000836; x=1723605636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aAlB9PgJPPOtppfWCUQ5EXdOMFZzMBqg7ZuOwVCeYY=;
        b=UxRXJvL85f8oemkQhq6gBr+JJw217ouFEmsSFzanJHMkbtc0cTZJqGKtIYn9H71fFC
         +16UQ9Z7mRQ5049aQYHDlgDskTxv63edaUjMCT0V5ZQZ6oGj8eYMvlVUw6+NfPF2Ng0G
         OORBEQpyoSZKMzhTIowtxDIzgpeCemvcZuiFv7Np0oGuMdXS8lZwGHUziqFMYby2xP7Z
         6BWUKWEolTt0StypXtegDN4NylO6Ii4uVFBmoAK7x5LFbjBfcHxyRUA3PfEsD8OWbylO
         cYluEJDyTNaj16dkXNksXwBbIECbiffqvLFOqAWmzu1i5/Dvmb+e3Xc9Cu1yahV5pn/C
         7+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcCvlD/JpuAjFl5j/WA0MGJjK6IsYVvlnFQHJYpetUw0hjhS2xhGRoDzswMvzHX54Hq9Kc8RS629c1OBTQpxoSw5vDJ2Ne2v/Lljus
X-Gm-Message-State: AOJu0YxCIL7D864AfltEcWNRqkQVN2KCRJF8SXCVnlwIOUMlaG47r2N6
	scKZHT9Xhm851ft2RQNK5nEb5c51bcw0rPlVxG7XCzoNc9Gyp4XcOFgts5AF2KQ=
X-Google-Smtp-Source: AGHT+IGpXHYFN93zMcnLM0eYp3c42rH+KGNp0iFujr93jZKuPa9TwsE0DOJDAP4cdOLFtHf/EiwMMg==
X-Received: by 2002:a17:903:2441:b0:1fb:8890:16b4 with SMTP id d9443c01a7336-1ff573c4f57mr209914015ad.48.1723000836079;
        Tue, 06 Aug 2024 20:20:36 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ebasm95116175ad.23.2024.08.06.20.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:20:35 -0700 (PDT)
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
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v3 1/3] perf: build: Fix static compilation error when libdw is not installed
Date: Wed,  7 Aug 2024 11:20:17 +0800
Message-Id: <20240807032019.1828674-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807032019.1828674-1-yangjihong@bytedance.com>
References: <20240807032019.1828674-1-yangjihong@bytedance.com>
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
index 12796808f07a..a0167244b2f7 100644
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
index fa679db61f62..b452794c763a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -154,7 +154,7 @@ DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
   DWARFLIBS += -lelf -ldl -lz -llzma -lbz2 -lzstd
 
-  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
   LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
 
-- 
2.25.1


