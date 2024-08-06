Return-Path: <linux-kernel+bounces-276049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043F948DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545831C23151
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668491C3F00;
	Tue,  6 Aug 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dJbIN2Pt"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA521C37AF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943949; cv=none; b=oa33niHGpbIYUbGY+9PWP3qNj97jOpJf913psYsv7+9cqkpr8EFP/nLj+i8FvB0Z5o2dOV3o3vnsHTH30ofCNiCsU/Yu6M7E6uKISCXNlUlFccQbbVbfIHM6HhTv1AQsaumQpuvzVgo4VSN6jkk1e9lO1ywjYTlp+MIw86a4lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943949; c=relaxed/simple;
	bh=lLK53uiQC3bZkEy2L61h0TC52VfEBeHo0ujP19/cMQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJSMbeFEl2cWuDihS1H0leUOIDBp3e24/z6WvD/tqhixhkd8DFFy4L2T8WhaDKEKscQauYIRmsYTuZ2a9la5HkeIJmzYg99MBoU8+9Pv1odU2ZNesToBdn2+IEIFnoB22kjGu6uAXCYjoYIEK746MnIOSfwnAbg75RDYCKzRM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dJbIN2Pt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-710afa8d1dfso367589b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722943947; x=1723548747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szK4YRuHQJi5DajMaeZdCXTgp1QcycA8fBZf8lAoRyI=;
        b=dJbIN2PtZ+E9NY80Cl3aqhv45lqfO6uRTujRxeKgUr4RX9ky6zejHffwNYwDPkDmxc
         1Ow/H/p+dv1Jtkatf1p7D8LKMyoIS4G2Vdy7mIhm92j4njuPu/gy/sgg2tOssWjC8APT
         1wOvY/A5+X7u/XsRJ3j76daPLaLXvlxrjVEzEbVAyXQ7eoAyl8wz665d62qiLIrSaUEq
         OZFR/qkkO09/bBqujjHPUawS8ZK/ZtB/SIguin6UUGxegWEePd88Jxumc87u87Rzc3Ry
         HOGai6DyeLPMh8nXLYJOXHRWPM2AeN+vSphjeFI6MS5GN1C/WPHHml9mGGeu/8MFAYr4
         GEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943947; x=1723548747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szK4YRuHQJi5DajMaeZdCXTgp1QcycA8fBZf8lAoRyI=;
        b=cuoIOi3V8FmiKBuMN3jEkyNNs/oRmoZoOYqGlhyAtVLE0LatHoezQMRcEb+eEOqrOg
         6BIIvL9htrGNbQtSRdYKUJ0H65W+0SjuJtf6vGuSC9zmcSQMOwmgUNEgszRID3tWRNWl
         WVVmD2u3nAbPQcYveDiQ9cwDSwyCRWZWA8/L//1i/Bon5/6Rf0UyTGEkmVTMwmf2Krqi
         nyLAqMiA4y/z759Nuk7chcsktJtvmKmgn2DpEYlAtdR+7i0tH3VsR40tlBOs27ycaGzh
         gB6xog1Yaq9BDUaKXmITk66Auh/5kygCrYXvly/ZF8XT3Amum0lINSorTM6eSpTBFjQ1
         iKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6gtblh3FYAC0oJRrtsbiSGlhGpiyyWxPD4C0LPgro8Vvr4kueEbCA7T26kK/Sle736GVCWuK3eKDLgltc1s0oaI54XpApy1lHLpPG
X-Gm-Message-State: AOJu0YyQuaoaiByctz1VdKnP39ZhWkU47Fje2cXrVjN1kbaVaQ8VE2/F
	0KIsDcKRBWlEo5ocqmEQXmg9uLNu6LkJrGwDV+SXVVm0k+zkSoepHcv6VCKrlgI=
X-Google-Smtp-Source: AGHT+IEvdkKGe2EwXTxVWrJg30+nM5xJA83kRoJ4CpY+yFaFwFcp9sDq0HGbNJaOeQHwcSb9vc5rSA==
X-Received: by 2002:a05:6a00:91d6:b0:70d:311b:8569 with SMTP id d2e1a72fcca58-7106d042f43mr12648556b3a.26.1722943947312;
        Tue, 06 Aug 2024 04:32:27 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec010a9sm7037636b3a.10.2024.08.06.04.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:32:26 -0700 (PDT)
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
Subject: [PATCH 1/3] perf: build: Fix static compilation error when libdw is not installed
Date: Tue,  6 Aug 2024 19:32:08 +0800
Message-Id: <20240806113210.1649909-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806113210.1649909-1-yangjihong@bytedance.com>
References: <20240806113210.1649909-1-yangjihong@bytedance.com>
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


