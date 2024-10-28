Return-Path: <linux-kernel+bounces-385704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941A9B3A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDD0280FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15DA18FC74;
	Mon, 28 Oct 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gk9RscLT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF818B03
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144185; cv=none; b=qF8WDYekoBszLNWqHTW+NpMLjuHWPaQN8MR3UaUn/phHbV/12lydRVua5cA623QnSB4ODJaTE4pmnCCKYcQ5vvGk4pI0CVl7/RFXQ2SwsNALohKb1WP1/EdciKz78KmqVpN4AHK/4LUGddC0QcSIXgUuLhcEOQs3sDZWLNG7glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144185; c=relaxed/simple;
	bh=viqJIcjf2TXOv5DBWOT5NyB73K2UIrJGjSw23TdvG3g=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ezaDh5DERByTDPGtH0z4bSLBLmB69hKqvoYI8FD1MEnkkU+dMZV4OUNxFW+XCctNWzjChfzYn21Usd/2eXQIdjpDVIQeJO/dkFsIC1Q4h71GbJiBgFiEaeCbl/1PBPT/wqTpR2xEMcQI6rt9ctFEFxOYACXvjjLRhPP4YLQQpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gk9RscLT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3705b2883so94405367b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730144182; x=1730748982; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yF5sdmQv/v38/bFXfks7Mw1baK2Tg6j2c6FqlkJRLPU=;
        b=Gk9RscLTx+k/RdNnyW0itxHlRtwo1zWw6WckpzUN4efH9vq2DbZbRG/aBUTibZEIHv
         +X6g1a+tkyjMgtSDBlNzPo/xtzHb1hxaWxoHN3bss6XnPuHBQvIfpHDZfzE7++rQA41U
         2xBCkiGIW3lOudtd8tUE9EOd48g0yseryvRIFMenw5TckXgLegvNkqzXHOjvMA+QpwdK
         0mHABLuZXaNiL4zozKeuXTHC34gaDKzBPbsU9+8IdZFs6JMotOKXh+JsKWHzwds3n1wh
         xeuUkY/ytifUgzd/9230Wn39Q1UvIQ8pd7+pIGUU68A8/+ywfH1zGyak9X5T07OeXVmS
         pI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730144182; x=1730748982;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yF5sdmQv/v38/bFXfks7Mw1baK2Tg6j2c6FqlkJRLPU=;
        b=pxLOYzC07sNxCYK8/c4qWa8PovkSZ1iG3vD7TQgeUj9mBT/xAk88z0CwaHgHCMs4LX
         eoRclS0KMEBqYd1c7BtvcjA507+eKt8HQKznJu8EdN0jZAiZRDBlOLZIyJPdzb5IfRwU
         BGzP/ONoBr0FCfYeXhyYY12dQZnlIDvhhhSpJ57pevVN61aag6tj+sOLoVVL/CmgDRXe
         z44wh86vUVV+gNu6oY6G0nm4sQWsFtrxU5obBXGFGMSTAlca0viv2TZ3G0PrAzIyL+yj
         z4ifAd+ZpPxwzutpsK/eOw5TSbdaK5e3bnRt87x1GHU/GnGqa0DL6tO5ta5/tOBbSWaW
         PiJw==
X-Forwarded-Encrypted: i=1; AJvYcCUDLxsJAfHdJ3ru1pqycczh89eV+f0OvMn170z3e9JPDII1FEzqcux5stiQsVdgr3lbJo8JXyvNYMMyI58=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKbZX9Vx4/8NB/V5jAr5JSwnL9I+DlpqimDuSbGZR5LA2Mf0k
	F8HAa4TsMpgTyrbx6ebXym8QVBi1tMN9PystJsVa6FVJVlBZu/Ddx7JkhKIrRXTCNXr2bTBg+Nt
	LMEREyg==
X-Google-Smtp-Source: AGHT+IHb9ku3VWFkQuxz8YshxF9EpG++pYbx6Ld7Dpt2cU20aAZO00WQlfm55K+qpKPmZmKL2x/h856TNzt6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7532:f6ae:e607:9ac3])
 (user=irogers job=sendgmr) by 2002:a05:690c:490a:b0:6e2:1ab6:699a with SMTP
 id 00721157ae682-6e9d8acaf1bmr4842907b3.7.1730144182230; Mon, 28 Oct 2024
 12:36:22 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:36:19 -0700
Message-Id: <20241028193619.247727-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v2] perf build: Make libunwind opt-in rather than opt-out
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Having multiple unwinding libraries makes the perf code harder to
understand and we have unused/untested code paths.

Perf made BPF support an opt-out rather than opt-in feature. As libbpf
has a libelf dependency, elfutils that provides libelf will also
provide libdw. When libdw is present perf will use libdw unwinding
rather than libunwind unwinding even if libunwind support is compiled
in.

Rather than have libunwind built into perf and never used, explicitly
disable the support and make it opt-in.

Signed-off-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/linux-perf-users/CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com/
---
v2: update build tests.
---
 tools/perf/Makefile.config | 4 ++++
 tools/perf/Makefile.perf   | 2 +-
 tools/perf/tests/make      | 6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b93ed2b7623f..707d7355ff18 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -91,6 +91,10 @@ ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv loon
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
+ifneq ($(LIBUNWIND),1)
+  NO_LIBUNWIND := 1
+endif
+
 ifeq ($(LIBUNWIND_LIBS),)
   NO_LIBUNWIND := 1
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b4dee7c20ed1..d74241a15131 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -52,7 +52,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBELF if you do not want libelf dependency (e.g. cross-builds)
 #
-# Define NO_LIBUNWIND if you do not want libunwind dependency for dwarf
+# Define LIBUNWIND if you do not want libunwind dependency for dwarf
 # backtrace post unwind.
 #
 # Define NO_BACKTRACE if you do not want stack backtrace debug feature
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index a5040772043f..a7fcbd589752 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -81,7 +81,7 @@ make_no_gtk2        := NO_GTK2=1
 make_no_ui          := NO_SLANG=1 NO_GTK2=1
 make_no_demangle    := NO_DEMANGLE=1
 make_no_libelf      := NO_LIBELF=1
-make_no_libunwind   := NO_LIBUNWIND=1
+make_libunwind      := LIBUNWIND=1
 make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
 make_no_libcapstone := NO_CAPSTONE=1
@@ -121,7 +121,7 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
 
 # all the NO_* variable combined
 make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
-make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
+make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
@@ -153,7 +153,7 @@ run += make_no_gtk2
 run += make_no_ui
 run += make_no_demangle
 run += make_no_libelf
-run += make_no_libunwind
+run += make_libunwind
 run += make_no_libdw_dwarf_unwind
 run += make_no_backtrace
 run += make_no_libcapstone
-- 
2.47.0.163.g1226f6d8fa-goog


