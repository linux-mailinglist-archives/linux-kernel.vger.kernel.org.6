Return-Path: <linux-kernel+bounces-214099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE3A907F68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11DEB220E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3218E155CB7;
	Thu, 13 Jun 2024 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H757mI7r"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084F14EC7E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321503; cv=none; b=WZLV22dH4eWBVNO9lO39G6k8eo1YQU9ja6shyf/GNRuegB8bW5vJ8ri6jY9OUXSOfmUYYPVle+21jr9I7gfm3qTZaffUhKZV08eyMvNRZkUHwe8T/C/zjmTiElvrsLomd6+N7i3D+RpKpkHVWuGD/N64V1tDRixOn6DzKcwMA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321503; c=relaxed/simple;
	bh=ERrHbjKpSrLndzYhYX3mAlB26TR8JNOzocZcSDYCu0o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gfnY+3mQrthKiN4BR2zDAMfXDt0CFZKp4OzHd+P4i4OPMW3KDpMZTU97fDqWeYjz86FwwnEHl1nGwTBReETOp1H9qLUqR1uqPKX14CZ4MFe1tbo+yDwnmNHRR46YdoCNro7sko574jm/VWsxAi3l5RlsvRFihCXKMYEUvuLRYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H757mI7r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-632591a256bso2762617b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321501; x=1718926301; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbSOB/P6de3ygMIG7fdBTW+eS92Yyh1ZhXc/HewO9bA=;
        b=H757mI7rXcdwMc7RqT84wjqCNsslS7Dbcq4i+lTRPlyCJ9P2El/c3bh/VmBHGTkl45
         qeXaKeiIjnCG+LdUNZ1lx8Z3FTpbMkKA/SorZmkj5kaEqXF7L7TYi4eCK0SVCIKyGwQ/
         Aeim6hodHDGdFKp9ZGhlMAach1u16QOKemf0iPa/wVMvm98cMakuQFj+4SOIDBm8s3rx
         xFkI7uMEUiQzKE2LoTeo429sA8/TMcD7FZXRRl3tZgK1DPKgRr8N9Wh8PsKrF8xzpkOg
         gqEE0rJlE8oPKohPLTealsZ/EYdeR1nVt0zp9ookmOHFb/iAqPbqg3CWkrYj2+eyPiny
         lqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321501; x=1718926301;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbSOB/P6de3ygMIG7fdBTW+eS92Yyh1ZhXc/HewO9bA=;
        b=NBawFw/NdfiZKVLv7iHQWxgmkYC7zC3+Nmq7deWFjf27DJjId0GE7pfzeSUZxrcDca
         Poj+7Ce1Kvu8SM48sm0h8CoLHb3sv4Khi9awqf8xBZ1/8AYnmTp7rqLtSjgk4iHVzUIv
         19Mm/oEkfCq1RJuB+bat18ACR+C+dmApLYJJXAIgUYnNqTEGsWX9A5VnWtE8gueTDpXP
         L7bowNNC3jo6mAIUJB090NYwOmxbjNwq6fcRksZx1tzbml134NtPzTnwB7hxbEUtCAB0
         Dolrmlx8I/fbV3pwJ2sQ17Pk0G92D+Wsr7B3Tm3rALHlN69a2Hs/EbnPDU8CdDiR2TaN
         yHNg==
X-Forwarded-Encrypted: i=1; AJvYcCXB6Ec9ijtF4mYNd1zxPBsq5IJDASa48wI+fxrsHPlPLKnAD7KHpIXb/l2KElLuXby7KfvPATy4u37UWNtZO6qXef7bRqWrDxeEQYYm
X-Gm-Message-State: AOJu0YzQClt/Aj/GhrfoT9YvrF9dFdRXYCMe2qD9Z5yMBHlXPTAiy2n1
	lZFbum3+WvwmezHpg5Dpm6MBRSkUT71gNuu4BVBD5Te5B3Mq45J6+/a3ZQfFGja6rWrAhaztyVE
	NESzxZg==
X-Google-Smtp-Source: AGHT+IHE5wM91COFyENsSJs6TdkrEyube8x5jVXFZVcONmu94l5YziFn9V2oVKc/3BzWS0BiAYO2r5J5dtvN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:690c:d1b:b0:61d:ece5:2bf with SMTP id
 00721157ae682-6322265e839mr3417667b3.4.1718321500762; Thu, 13 Jun 2024
 16:31:40 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:15 -0700
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
Message-Id: <20240613233122.3564730-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 1/8] perf build: Add '*.a' to clean targets
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
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
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
2.45.2.627.g7a2c4fd464-goog


