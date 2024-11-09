Return-Path: <linux-kernel+bounces-402695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD69C2A91
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8B62823E4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406D16C453;
	Sat,  9 Nov 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSVDcXKJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18667156F24
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133131; cv=none; b=nZwtiYTUVUi9eZg/Ixg+ZxV9KrCgKDaFZI6BVdBOFnr02wMvH+mdvgvl4EunOYjKBIteCYMJNNGLuBecUE07sxry8nLIADptk5ngtpp/FA2yqfBlpjcLl7GFVVUejCZL+um0qnQioNRArlzFh4UmzIgDyfXfITZ7uv5tIxQqS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133131; c=relaxed/simple;
	bh=pAXQqpIWa0LYLnnCiagfBMCxcQEkPLFbkh484k/DoZU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uQPKCUsluAlmm/hvDh61i/z570s1DJiE0IpXMorxSuGrFDx62cg+okfPJ+EGUkkllmq5DOA8svXBD+KIswU4aW+nAEyzLpdKcxw3U3ZM3vANL2VjlZs9PQ+fTkUgIBfrrsUx9YmVc4VEv1CN0gZtFboblkY9EBtNwfzh9TVymDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSVDcXKJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea863ecfe9so58924427b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133129; x=1731737929; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNpFEdljNjn4YHB86JN+vwHrvAgwAz/em65+hZvbLSA=;
        b=XSVDcXKJ6PomFdiLZrehVMi1e2bC3bHBBECtjUmj93/lgufuaGc+Yz3Nf9sO2dPWF3
         gMdcogGJmdTS5qM7tzAts4PTBq0HiK8xf9LmGzq1EbIVAA0SIKTt2i6WIfYZM1j8Y5zj
         Pnjdsa0M2WTxNoeJ8A17QLLu1WMHbeqLz3Sw1o5nRrdaDIHmZZw7RtBKdsvl1vvXs9lY
         xZ390crG8G/PjPV9Rsz3R8cX4rWdUIxYIliu4Ws7ovS8PTiTdGacYdkgpSKVG9GY/rMK
         QRper8wjW9Ho6sG9Q4TMl+y5nsdjQUxZsNVDlov9PC8gDfvB8uf+RM3W4jg+Ase2nABf
         XTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133129; x=1731737929;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNpFEdljNjn4YHB86JN+vwHrvAgwAz/em65+hZvbLSA=;
        b=mKPy4O8TPUj8DpuOmivqtFiNbhcKvu3mWOr72RMhHDuUjkzD/j/61DNUHcPzRJVZ4G
         2Laul7zG6U96qwg9TDtIi8ea4UaaJvaygp7g+PVchlZKLRG/ofHRWGk56iGH3cq1/rvI
         gO9avhfyL0bQI3lKn0Yrtgr1fQOFT6vzr3lAOjf5Gc4PccED+9UhANp9l8ZqNX0s4BDa
         W+7u8qaD2UwVY6UKh25tdn0TlHP+emsm9JLEozrU912rTUOAFrMKFCcMEV2fNOnswdfq
         sAnLMS2V/MvsNHUO44gxQARNkhDwcgvJZjAI4Sno4c2hsDFk5w8NxNQ2iqb8gjKX7V9Y
         qXww==
X-Forwarded-Encrypted: i=1; AJvYcCVn+YlbJKwN4V+x/axq3hYIxPGpswzOxueP14FzRgnudBtCFBUWi8Ru2vykmWwUL/0/oxVXMfpjB/H7DFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEaWN54e3Vl7xFF83IqsPtGCkmPwuvpEZTNKh3IlHOdlCbHcX
	35ldvhgz7qFry6/FjV5FmqtIYv2/tCuCGRydLFF8pG5FL/I1KooJlMVhRn1atzB2gTlwkxmRCln
	oEhKKRw==
X-Google-Smtp-Source: AGHT+IHBz1DzCs25wFnpS+hrkIGaGnqfLGqytn4OYFpA0dqiuyktNOQMHkXGZaEFY5qq9xiWZkSKzUyPu9uD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:949:0:b0:e1d:912e:9350 with SMTP id
 3f1490d57ef6-e337f8beb2amr11248276.6.1731133128821; Fri, 08 Nov 2024 22:18:48
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:59 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 12/22] perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

archinsn.c containing arch_fetch_insn was only enabled with
CONFIG_AUXTRACE, but this meant that a NO_AUXTRACE build on x86 would
use the empty weak version of arch_fetch_insn - weak symbols are a
frequent source of errors like this and are outside of the C
specification. Change it so that archinsn.c is always built on x86 and
make the weak symbol empty version of arch_fetch_insn a strong one
guarded by ifdefs.

arch_fetch_insn on x86 depends on insn_decode which is a function
included then built into
intel-pt-insn-decoder.c. intel-pt-insn-decoder.c isn't built in a
NO_AUXTRACE=1 build. Separate the insn_decode function from
intel-pt-insn-decoder.c by just directly compiling the relevant
file. Guard this compilation to be for either always on x86 (because
of the use in arch_fetch_insn) or when auxtrace is enabled. Apply the
CFLAGS overrides as necessary, reducing the amount of code where
warnings are disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/Build                 |  2 +-
 tools/perf/util/Build                          |  2 +-
 tools/perf/util/intel-pt-decoder/Build         | 18 ++++++++++++++----
 .../intel-pt-decoder/intel-pt-insn-decoder.c   |  3 ---
 tools/perf/util/trace-event-scripting.c        |  4 +++-
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index bc56a8e70f34..c5df4a2cf180 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -18,6 +18,6 @@ perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-util-$(CONFIG_AUXTRACE) += archinsn.o
+perf-util-y += archinsn.o
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 650974413849..340544a6f5ec 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -122,7 +122,7 @@ perf-util-y += iostat.o
 perf-util-y += stream.o
 perf-util-y += kvm-stat.o
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
+perf-util-y += intel-pt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-util-$(CONFIG_AUXTRACE) += arm-spe.o
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 30793d08c6d4..f99d150059b9 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -9,14 +9,24 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 
 # Busybox's diff doesn't have -I, avoid warning in the case
 
-$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
+ifeq ($(SRCARCH),x86)
+  perf-util-y += inat.o insn.o
+else
+  perf-util-$(CONFIG_AUXTRACE) += inat.o insn.o
+endif
+
+$(OUTPUT)util/intel-pt-decoder/inat.o: $(srctree)/tools/arch/x86/lib/inat.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-CFLAGS_intel-pt-insn-decoder.o += -I$(OUTPUT)util/intel-pt-decoder
+CFLAGS_inat.o += -I$(OUTPUT)util/intel-pt-decoder
+
+$(OUTPUT)util/intel-pt-decoder/insn.o: $(srctree)/tools/arch/x86/lib/insn.c
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
 
 ifeq ($(CC_NO_CLANG), 1)
-  CFLAGS_intel-pt-insn-decoder.o += -Wno-override-init
+  CFLAGS_insn.o += -Wno-override-init
 endif
 
-CFLAGS_intel-pt-insn-decoder.o += -Wno-packed
+CFLAGS_insn.o += -Wno-packed
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 47cf35799a4d..8fabddc1c0da 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -11,9 +11,6 @@
 #include <byteswap.h>
 #include "../../../arch/x86/include/asm/insn.h"
 
-#include "../../../arch/x86/lib/inat.c"
-#include "../../../arch/x86/lib/insn.c"
-
 #include "event.h"
 
 #include "intel-pt-insn-decoder.h"
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 2e9da0b089ef..8d71998a9ecd 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -272,11 +272,13 @@ void setup_perl_scripting(void)
 #endif
 #endif
 
-__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+#if !defined(__i386__) && !defined(__x86_64__)
+void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
 		     struct thread *thread __maybe_unused,
 		     struct machine *machine __maybe_unused)
 {
 }
+#endif
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 		       struct machine *machine, bool native_arch)
-- 
2.47.0.277.g8800431eea-goog


