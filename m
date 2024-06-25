Return-Path: <linux-kernel+bounces-229522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018E91706B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EEEB25066
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B4817CA16;
	Tue, 25 Jun 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBRBNvDP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172217C7D8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340956; cv=none; b=q+UeVZsVGjvQcwQqd9Sp8fimTFzDOwHcpBC9rPIWBpQvL0dBKbCKG/RzaZ8qrXIN5Lzz9sATpj6wWVbzMT7IKuwyQw+ChJ95snGsQjPz0e9oz7E831YPM/IdgWQJodfiyK0WYzvZwNhOE+WTT7sT+NV1JBasQP+s4tZN3xMS3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340956; c=relaxed/simple;
	bh=AGF2g3tEA7zbe6kDn2NaGFb8pt75qgtrYCw6tl/k2BE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HB6OiRwysqHgdLweY+cjheTh1xBT47N+3Oa9F9tX+YMwbvAgaE2o9QzhwpABQ8O6SKsaybDVoFmmf4Wrk9vy0mEqIDVNc+wRDd7x/OWYNfF9Du9N6xr0Pw6QhfaMwTdGrvcSWaVQyo+5EG5q/Thhxld2AewUZ499L7hy5GQTxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBRBNvDP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f43c95de4so133674467b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719340954; x=1719945754; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV5nTHz7JpmXL00HnuBhzQFlSeI21ZYNHe64ER+6Mts=;
        b=DBRBNvDPUtW1x6hXMhBWdqkw+AkD5Gxc58tkSZVWV/9aE8rIPzK3GlYWsJwY4pfkwA
         Dw21+60h4fz7fel3hZfDqQBW8xh+6H4xIemophdwHoawncML1u6u5t6WV8dZTtBg4jDa
         NeEuGj/+N1juS0TrzeztK/cnvQ4J68q8mEOAsY410G7UuQmWU4TBUGCtfWw5iXJzrs0j
         FnFImnJ2GiXZbmmbH9x3dpTS1aslvJRh1t/cwCK5gmn3N+7STslMdShtT8bPcl79Xt3P
         /wSnaU4otGPsxGVCcSxppVL3hQJC8IdFDuT6CifXr1H5bkZB8dWY3THqE3V3+VajArTm
         yzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340954; x=1719945754;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV5nTHz7JpmXL00HnuBhzQFlSeI21ZYNHe64ER+6Mts=;
        b=xTk36PK45nqcG76Fv8Fo1tg3jjl7ttuDUsq09NjeoNe57f0Aep4oRKDyUbzgSv2lXc
         uMcxCk+xQxl//YZfic9yd0HHEmEyCdNDVypW4bFCdKaIsl/kpPIBOnGi/wwYS+uDZU35
         jqlea198dA+sLaSZ76XhiYycfs5+52QOhyU85d2QISWZ/mlxhxpx/qpC7hlxO3qEXHLk
         Acb/nkldm0gIFmCD+k66T/sGrjL/5C3ioCpNhtQj9Zs1OQYvLvG0HOEhftW4C4Mpgu+V
         Qt50k31IpYbd2xBF9IqMa/eshulIGSPtBjDrTseN+LCTK+H9m0bbmY74JEmq+X5LXIDk
         c7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUDIzx5SiBQnIldx42EVkwWHkZwTXafOom5Lbg1xSLQaRhzODSlMxrNWjKHPIVJbul6IoJZxxjo6Mg1+9YlfbwU6YtYhFcDyizWaGqc
X-Gm-Message-State: AOJu0YzjxU5l5xhvA/Ec0ssjqDbMnKUFCm3Yn/qg24mh6am+DIfwl2j1
	4Km8Qcy9PNXtM1qOdId2L0AFc7y55XyWmXBlnflfYFc0fKkf0A9EqX0YIckOgUs2qS3pnVfm4qK
	ZtKgAzQ==
X-Google-Smtp-Source: AGHT+IErVDS4+BQzyqM0Y2ip5PBZLqG9tNZcT6fn1gaXhPTz07VhyD+wZQTwxXPfyoMPvV6/dX+SSWlNQ9BM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:6201:b0:627:de8e:736d with SMTP
 id 00721157ae682-6429c6dcf86mr302617b3.6.1719340953696; Tue, 25 Jun 2024
 11:42:33 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:42:18 -0700
In-Reply-To: <20240625184224.929018-1-irogers@google.com>
Message-Id: <20240625184224.929018-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625184224.929018-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v4 1/7] perf build: Add '*.a' to clean targets
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


