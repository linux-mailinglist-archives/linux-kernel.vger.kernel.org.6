Return-Path: <linux-kernel+bounces-214101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9456D907F70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E871F21CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF6157480;
	Thu, 13 Jun 2024 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPtBisXP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CC156F36
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321508; cv=none; b=CPenBgq0xE16H4qTRCNxseC7XD74UbpAqfbKvVzN28gmWOLWMUHroq36eGnb/XwwVdrlmYp6Ip72Ay23/xaWOXoXKwYQkY636e+tEFfjaTXTG0urcfxabjT1vq7yH1YDn/kebuFq1ohGtBUBZxBeByLLiape2aZrUqzLaiRGwnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321508; c=relaxed/simple;
	bh=0n3NWiOLohwJNKVKL9gV3Koesj5loLw/lRVeMyy3BQk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hCcrpdJHl7AGrkUdAlAm8l+4LaEOrTh4lCDZJsyxvEaCFXqfCrmnv2KT1svf/BF7bKDixxaNt39mngVS9N74M/BmcCfC9v8ZmuUmqXBSfFyDJHqhOp5LhrE9SGSGeIPxXCDqqWavfw4nPR3Qd0j6aBAO319pQS+nMIKAFpreVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPtBisXP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfef7896c01so2723659276.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321506; x=1718926306; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxA/uxqQnuEGimdVVLwjMbl2Ju2kVgaw0AA0enSCOv4=;
        b=fPtBisXPeJQJTiULPQiFjCmvHHJbj/Ej6YVO8oH5ulF98wNoCyEHGl6rnPQ8MM+2me
         oihcrKKWFBOji+NM1Vgiv3B/L+6SXD16GGEZbF0Xc+LWqLJT+IHvnhv3NiH10JECHk7S
         SYYxPqCCXIqRA/cNluRAkgNW1BFdfTWqk5wt0k1e4DeptHiawJvwiG6mCCYVAfKL+5q4
         iJH7d8WLTfsgoHzjwbB8eOx99cVBzQ4z4BR1sE6lFH7DECCdTfU7jsgqRiierwwhFzLX
         QrJ7DNNEPhaYv/QK+fHOrl+D3EVN/fwUcC1NYpGgJb1+63MLAfUPDaO2yVgcQtoldL5D
         c1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321506; x=1718926306;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxA/uxqQnuEGimdVVLwjMbl2Ju2kVgaw0AA0enSCOv4=;
        b=M+iYB7/fkYfyy0Pnbfl2eDmnUVxlvnNhdClfjbYJ0SoqsdmihQA3dWUVyjlXMAPJUr
         Omhnea8XGzElifeBYJ8n7GrgyS+MVvjMrzJQ2z8JhJkAcDXbSwxsWo9i7KZ56yThvMtg
         d8hKfYgVPpHNyzz6subl4GtUSwmidbAHXdiHxBXN49Y5eW+v5xTtD/DdYY+/Ch1Mx55Y
         Xk1sIoqqMEUW6FN9hxKerU4UXxNlSoOLRjBdIwnTCgEBkvBGHwlGjqb/RJizfvM+8T3k
         ihs/9G9Zn2/9FiDBExmUxGavaqlYgusfXb9eRNExckXDtj8HNp3mt1C/1Bn8/Sm/pQ3w
         mKNA==
X-Forwarded-Encrypted: i=1; AJvYcCUybtFyqTbpOJDOzgYyAFx50ftE4c5oCIPo9AlPZNT47GgY1sWY0lfQC9hFbykUDFQX7Nt0qwy/K1r1tg5zrMwTguv8wJXfECZFMogk
X-Gm-Message-State: AOJu0YzRJ6yPrwIlIVlG/ZVuTOp+ojflaoGUdOV4OycfS6oZ5/kU7VqH
	QWSev/crYX+k5pHpbRYq0+3ptKQMRFfBw4WFfNAkXpGzRusj9ANrGY6yRm6RLFyZy7k5X9FKPxY
	3rp8C+w==
X-Google-Smtp-Source: AGHT+IG0QxtJ2klO/2YXDc0iBujvmja2VH2aEZOp3HvulIB/G5oRb8rNfXRnL0OTcbZ0KYmVBuD4OITIspBw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:1109:b0:df7:9609:4cd8 with SMTP
 id 3f1490d57ef6-dff150d9a54mr275213276.0.1718321506207; Thu, 13 Jun 2024
 16:31:46 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:17 -0700
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
Message-Id: <20240613233122.3564730-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 3/8] perf pmu-events: Make pmu-events a library
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

Make pmu-events into a library so it may be linked against things like
the python module and not built from source.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.perf | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c5a027381c55..9640c6ae1837 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -428,11 +428,14 @@ export PERL_PATH
 LIBPERF_UI_IN := $(OUTPUT)perf-ui-in.o
 LIBPERF_UI := $(OUTPUT)libperf-ui.a
 
+LIBPMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+LIBPMU_EVENTS := $(OUTPUT)libpmu-events.a
+
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_UI)
+PERFLIBS += $(LIBPERF_UI) $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -721,8 +724,6 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
-
-PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
 export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
@@ -730,18 +731,21 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(PMU_EVENTS_IN): FORCE prepare
+$(LIBPMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
+$(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(LIBPERF_UI_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=perf-ui
 
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
-		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
+		$(PERF_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=gtk
-- 
2.45.2.627.g7a2c4fd464-goog


