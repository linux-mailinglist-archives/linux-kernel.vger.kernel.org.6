Return-Path: <linux-kernel+bounces-229749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231AF91739B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987661F2144E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D317E8E1;
	Tue, 25 Jun 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dv9GOw6b"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F517DE24
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351685; cv=none; b=pKhsGKlozqeF+BXPPBxb+cUbkbyJ4M6R49hGNyLgDCI6lepmmgbbtQODUkikAxL8ipe4sF+FqGL+BOzkDcWADskwHW6AuWDUxiB2FPjbGop5jY/V5iJNrpO/MPrHoNuiy1svSOfKsqBCXcGdth3FUXk7CPk7X8Ep/4kjJeiuUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351685; c=relaxed/simple;
	bh=AGF2g3tEA7zbe6kDn2NaGFb8pt75qgtrYCw6tl/k2BE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TKTb7HIrRPkxqzDWSCdspgSccfZM/qNDEjIL0ubZrPN2dIJfHeuwfxybuDrGU4vDzmr6v0cZmN2PjH79baI9iTOlv7U0l0JcjSwO86EY6IVEnoSuFMlGtnl/JdZX2ymneduH8dJx+NVjwqm8qt6wIHs64cFeUwrc/EhluiW9Ghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dv9GOw6b; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0268d49b6dso12173368276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351683; x=1719956483; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV5nTHz7JpmXL00HnuBhzQFlSeI21ZYNHe64ER+6Mts=;
        b=dv9GOw6brwgRK55b2Bpct+M/e95IbCTqwcH9chQ9CftE3eAK1aHKAq8A8i2K+YJtZw
         Q6kItKzQZrQAvZhsL9NTu21hpa9nwa3rtclg1BPhM9yDUZbHYCWkSaRJn95MxMOhcJbp
         7SWeyA5o+yuikdTCrNlmnUIDhsZWwxJNsrDP+zVPyYrdugZvy8FHMbJVPXsKByvwmNfm
         DD1IfASVeuAlikgBXuQJTCl+JK6RoT+GFYZN8YKXkLXLWxQFRGNfZh0e5Xm6AuK/A17Y
         IPWGD8JMI5nEQSBELZWqNnGepOyjbBGdgEIT8g50/mxRrAZFzQu0M/eI7RL03rrvGna+
         axvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351683; x=1719956483;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV5nTHz7JpmXL00HnuBhzQFlSeI21ZYNHe64ER+6Mts=;
        b=KA7Ki6x7MaDX3LNSFB9+ddUF0hbDUqSxZ2cVgdT2Afj5ji6TvfLYGQKsRB+QTxeBL7
         iFPWBsM073l8u0PhgDn19BUbVCDlRQrd8jfx9Mzg11e3gZ6mBEKEPMzPoh09u8H5KpFg
         62GG69KEQBYdgZJZrxllFHg9UAoYJ6Ll5hpCofJI+JzmDPfFY70eRFEJS4xywkJElwpO
         xJTA+yoj7waNgIn9fZsRlKDM8+pSNn7SYuz6gzuCYPXJ3n2P7lMJst4muHSh1JrsQmOy
         cTqE2/iHR26RD3wJjDkDrwtCwDmrUJ3zamCoxxSSqBq1nEB9eRXg/5ZgFCxjHFRfJzMU
         u+5A==
X-Forwarded-Encrypted: i=1; AJvYcCW9o8nt48m2UxX883vkhpZjCq7hKAPSsXOXNHJrU2dB66Pm8D23BzLxhKsPw1822R0pv0trrxcv3Tog8Fck5gLphVBQDrZeoK+l9eLI
X-Gm-Message-State: AOJu0Yyd0SQYSGqNz6u9CaioiAdPv7q+fdRi6rZG9YAfn8quy4qD1+Nh
	ki3MzBSnHPMp/y2qmtUBZv5mtV5Sz2bFcrLfFfCfawBB7BIoEqjcaGCFQindk/NgtHNJgZynlZu
	hPHk/kA==
X-Google-Smtp-Source: AGHT+IEy8zCWgmfD2YMUxVYSQZooaRbMoZ2CL2WLYr8JNXB6DT7t3q7Wwd6PL2YwS3pqDvoYGj9f/G0IqvHi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1827:b0:e02:bd52:dd73 with SMTP
 id 3f1490d57ef6-e0303f48404mr29330276.7.1719351682873; Tue, 25 Jun 2024
 14:41:22 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:10 -0700
In-Reply-To: <20240625214117.953777-1-irogers@google.com>
Message-Id: <20240625214117.953777-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625214117.953777-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 1/8] perf build: Add '*.a' to clean targets
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Andrei Vagin <avagin@google.com>, Kees Cook <keescook@chromium.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix some excessively long lines by deploying '\'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..acc41a6717db 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1201,12 +1201,19 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
-clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
-	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
-	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
+clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
+		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
+		tests-coresight-targets-clean
+	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
+		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
+	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
+		-name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
-	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
-	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
+	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 \
+		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
+	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo \
+		$(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
+		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
-- 
2.45.2.741.gdbec12cfda-goog


