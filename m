Return-Path: <linux-kernel+bounces-229751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10A91739D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD31B1F217C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB217F4E2;
	Tue, 25 Jun 2024 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2Uj6hFL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE617F376
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351690; cv=none; b=j/QsvUhmxbslQKKM2JcrRt3smjwSu90tzdQb+k7ul6tjgjCewXsQUegpoDNhtXC6TKRRC4SfUHHiPwACaX+p535jAhvx3J+QDeXo0E5QP3D4dGHI+ltsieswZlzR0KD0z9mSb2hlInOAe9ItzJw4Q3tG9kwI3Ku1okYajOqVw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351690; c=relaxed/simple;
	bh=bwtLI3Jcufku622sK4AUh1VaGsI4g/AsTLwYxdou9H8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YL+IRmazIAZrMOVOsvBmYaZt5hq4D6TEmpXmtoC7TgsZLHrK7ER+CiJ4xWYj9kJa14GO7hhz5DOuH1AKde7hV3kkiUF+thhMFSFHlh826ddRbDK/cYsU+8FuZSM3pQoZRQ6W8zC7c10U31C0GRQq2d+g7Ey9HfloAVq4cW+ZP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2Uj6hFL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6438cfe5af9so78722937b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351688; x=1719956488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jtxp0mR0wazQJ0QHy8snlQ9f7IXPyviJrJGWoRkeF4=;
        b=q2Uj6hFLsAdKOeELndGjConhoS658D28BYTFM9GQ9ACQIkdIayNhca5+Rv+gMbwQIL
         L8+Dxcc19/3B5GKr1KiRQetPeWJ01ssnQrjDKC5TtSM6IM4ciqxKqzKrPgE3xxWTAlUF
         aeR/eytXAeJFVXR0X9wWlyVTRHlIIZb4WyyOv+I4C1mEcFcenFzya6tyBsnS/3a0dSYD
         o9sTwZTDoWQaetIZL86YBn545XGfFbi2EHWzv+i1y1Xk8OFY/DYyLHwmSnO65YiahLto
         4vXBYNIK2uVeqjYmj9jcNpIJqxO+8z1D1+kDaB+3MXmA5N67kYhLtiTOJVxoqigQoLyV
         sKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351688; x=1719956488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jtxp0mR0wazQJ0QHy8snlQ9f7IXPyviJrJGWoRkeF4=;
        b=YGw3UHu1r3ln095IHbqw8AvFffs9cFRMtSpOLZxRecOd20eWPmn0SShGaeNO5tHUyQ
         t4aJSbi8mITXjNn/i5EgT2GRhzQM0opPLUjvO45KbYcFEDniAILdQYb0bcHkEGRB7MMS
         LmYLtKlQWh/Vy4/luNTrXQlQho2iDWpe1PLNpg7B5OHxiKm2LkJhIMc0iwp3zWSz/cc8
         6+lstCrYwOSBevxOs/KBh6XU0TIYZ1sWd+zap7l2sdl7q2tKxG7ltPC2yVGhjvvAOqUK
         j49Tnksc0EPU015Yd69nARKra/zCkRrU7CUqM8/LjCoY7oUlERu/34k7XyFY3vtA1JWM
         gwnw==
X-Forwarded-Encrypted: i=1; AJvYcCVuGfqY9Wj84nTzEw5o91rvKMPRz4NUkZ9pAZ+N6SGpHy9Ka+yCN7yxyHP+59+tCvkZkN4FF4sBcPZU7t80JPewzmN0VVO95AjjHTQx
X-Gm-Message-State: AOJu0Yym/E9nsOIuRdMGu2FCraudTM1PU20rGOplp3EkkGn9INFr5S8f
	V8BDLSwidb9O9wYsTxhCQKpvCNV3gjmrKrylZ9rzXGt/zh0WEVMEJtFI5B+Nkls0r5f889sdlz5
	Wcz7nVA==
X-Google-Smtp-Source: AGHT+IEqpHMY/PPtc0hzBnoY6UQPAQ6fP/kxnOlvyQiEDGBFgD3xE956igXL9erX+1EydnCMwNQI2cg/pyd/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:d6d0:0:b0:dff:2f78:a5d7 with SMTP id
 3f1490d57ef6-e0303edb955mr134350276.5.1719351687643; Tue, 25 Jun 2024
 14:41:27 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:12 -0700
In-Reply-To: <20240625214117.953777-1-irogers@google.com>
Message-Id: <20240625214117.953777-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625214117.953777-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 3/8] perf pmu-events: Make pmu-events a library
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
2.45.2.741.gdbec12cfda-goog


