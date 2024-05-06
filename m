Return-Path: <linux-kernel+bounces-169480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655D8BC94E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8464B217F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D01411D1;
	Mon,  6 May 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HkJv/CG0"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6F140E22
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983422; cv=none; b=nyHfY+OhWfyWTeKquhxSNDyLxXN6oA4Y4HiXF4CtrNN42NaX0REg5VKgtXKsEjALFwtGJ7UpKQH5pzlSP99PhmIIX2gMU4axVI3SY5jntRgE1PaoRfLIjpOuc+uge/7orAwmnSj7l7pLJhofKVPmH2SPK6P0PYjnhQ+MpVfWOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983422; c=relaxed/simple;
	bh=nNY02W8+mwn4OfGfOk44xFpXhIwKsr2nKA7lZGKZsG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AMzLi+uL5FviwwfkCYhIKk6yGLrfgu3pUM0Jj6RnL1SmRaMcmrdzuyXfXhGlZ9C94LPybwSeiGnM9RGN1IW+2r8kxy0uIKoo6DH5xsB40TiPlaR9zpKp7bJXyB6qR38wfHeKl0bWNtm/Igr1QzgXoIy5kiFyByU+MvG+rU4FM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HkJv/CG0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f4178aec15so1427494b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714983419; x=1715588219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvU9L4BSNfi8J9xPmuApsxXdGaL41m0A1yNVgMIPbng=;
        b=HkJv/CG02oxZEtZD/W8KMTbzZsDk6Y9WtURrLDOJm6X8rSQXRXyy/H/u4JaSfpkBnp
         RYSvx0VRFoxbkhGRKZ6Gca1vT2Sfi9x8Ge9daj9hTzQ2UWQpJWFHMPXl916PHJW3Ev72
         AW+cvp7Ic/teuvzs2geLZiMuJmBoOp5lEy5d3oOXoBdY4GVW6Mh/9Yb17WiLE3uPMHTA
         sj8mnClAGIpYYsCmdp59Da0wf4k3sxnwjv4dex48K7VXp1u69umZ6/Y/9wOTg+dMOUWM
         3NvkPaig7hNmNFyXRIyqyLIPchyxRzGD13A4O2ZBz1W2/TEx/6eZAutTQ1YcVM4a44vO
         vSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714983419; x=1715588219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvU9L4BSNfi8J9xPmuApsxXdGaL41m0A1yNVgMIPbng=;
        b=aqVmfkS1+sceMbieatsGMq2Pihs03Jz1O9e7zHhR1ABYh3F3U1S7vHOLIpsPmuvffm
         /zS7AvBQ7RPFYaS7vqiR0hHyYvF5L1Hq0IcS63TcCSO0NrK9uoTViEfp5IX/wEuLTE6E
         eB+K0mP0yHfBlIIHdBCouxH2EbmpFQkz1ybm99sRLvdVKNb2f5bX6VMVJeDN3oUKUdMu
         GyQUmMtHU+E/GNDMNg3NWNVl+cZeSzjObGnoyyROl3mIicKIBy7+QW9iR9yoUDpXFXYu
         0AOhFT8Rh9AVZh8UE4GwnVnjkFDyyNRWlrUZe7d/J5NLpQnwxztrxHmpJVsIkhRGQScx
         30vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX4YLlkHXhCBRPEKxy5slTCWJhJDTWspytgZP2u5MKWbINXfUb2qncWvoTsesdgO+ghvpNsIJYJq1YfurwXdTgsFSkL+dK8QyQU0/z
X-Gm-Message-State: AOJu0Yyvyr2o833pYMtkD+k9a8zb+w60veX85f7M4bZhsKcEbfnWm6oD
	/dzUUlEMQyTARKIwydOOtguZpzgsAf7NYhiq8B5G6TA0vegwN04FUK4IirCYjrg=
X-Google-Smtp-Source: AGHT+IGW8eT6SRaXkCrgeRnW1vIvfkEVxl3wfc/uQwrh3V9qr5G6UHREAarofkys5NkUg/e3G4pjrQ==
X-Received: by 2002:a05:6a20:daa0:b0:1af:3cb0:f2db with SMTP id iy32-20020a056a20daa000b001af3cb0f2dbmr10034326pzb.33.1714983419414;
        Mon, 06 May 2024 01:16:59 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001db5fc51d71sm7735030plg.160.2024.05.06.01.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 01:16:58 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] perf build: Specify libtraceevent dir to rpath for asan/msan build
Date: Mon,  6 May 2024 16:16:48 +0800
Message-Id: <20240506081648.3890067-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf built by asan/msan will not search for shared libraries in the
-L directory. For cross-compilation, we assume that sanitizers is
generally not enabled and add libtraceevent dir to rpath in a simple way.

1. msan build

Before:
  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins" CC=clang CXX=clang++ HOSTCC=clang NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1 LIBTRACEEVENT_DIR=/opt/libtraceevent
  ...
  $ /tmp/perf/perf
  /tmp/perf/perf: error while loading shared libraries: libtraceevent.so.1: cannot open shared object file: No such file or directory

After:
  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins" CC=clang CXX=clang++ HOSTCC=clang NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1 LIBTRACEEVENT_DIR=/opt/libtraceevent
  ...
  $ /tmp/perf/perf --build-options
  perf version 6.9.0-rc5
  <SNIP>
           libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
  <SNIP>

 2. asan build

Before:
  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address' LIBTRACEEVENT_DIR=/opt/libtraceevent
  ...
  $ ./perf
  ./perf: error while loading shared libraries: libtraceevent.so.1: cannot open shared object file: No such file or directory

After:
   $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address' LIBTRACEEVENT_DIR=/opt/libtraceevent
   ...
   $ ./perf --build-options
   perf version 6.9.0-rc5
   <SNIP>
            libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
   <SNIP>

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Makefile.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..a9a923358604 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -188,6 +188,10 @@ TRACEEVENTLIBS := -ltraceevent
 ifdef LIBTRACEEVENT_DIR
   LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
   LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
+  # Specify rpath for asan/msan build. Generally, cross-compilation will not enable sanitizers.
+  ifeq ($(findstring -fsanitize=,${EXTRA_CFLAGS}),-fsanitize=)
+    LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
+  endif
 endif
 FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libtraceevent := $(LIBTRACEEVENT_LDFLAGS) $(TRACEEVENTLIBS)
-- 
2.25.1


