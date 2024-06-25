Return-Path: <linux-kernel+bounces-229524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B131391706D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D582F1C258F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358917D887;
	Tue, 25 Jun 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4KUxqcKg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9817D357
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340960; cv=none; b=Yp0X8yBDkEW+Kx5Sad09V2n48ZgMjsyK/oHlAAo2QQiZl4WS9DaffPCdWTCwnYuMlNul2tLLyfHln7bf8zFxaIRLu09nKqLEfDJgXH1/V4Um3uxO16GjCtNBhuAu7BKNxxtIK/2k0BvGRYIbS5gWsOVmqzNpZcPDALLghCg4P4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340960; c=relaxed/simple;
	bh=bwtLI3Jcufku622sK4AUh1VaGsI4g/AsTLwYxdou9H8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fuPi+OPlPhHROXeXKh2uzLrHEEXbzrcFvcYqUi8BwzSNdaVbs/1RvWPpIFtPpEvLR+Ph9nl7kWH2ZbNKCMmAQt8XRFy4xwEkHDd9hR4A4w1wqIOXM8vywuJMS/6Vi9lC/AzfJecEjZNImB3C0+EM3mpb2aLMR4oh5YU+eM3YuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4KUxqcKg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-645180f6a74so52516377b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719340958; x=1719945758; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jtxp0mR0wazQJ0QHy8snlQ9f7IXPyviJrJGWoRkeF4=;
        b=4KUxqcKg6P4bcyAUdySNkAnS0ZUAAQDTNrXANSl3XTdjkTrs0EKnsuS3Y+Saa/R530
         YvMfsMQI0ESj5rKaovQDEUw2G/W6Xz2E2qHaYi511oVPwas38qgtdv4uTSZlk992IZqK
         difuMWbkx0lmMsgV51heggiFZZojW2GSO4nRXqVTjBtgtun+5AftnWXSDEZnIYL7j0G/
         9SEkPB25qpnh1kHcLUJKcucnuFvKDgNt8w6ASyDVRLXSq8KEdwoNDvhx4c/QCE4ni57Z
         IjldeaEVvPO+/60mdMZgQqsqXmcQ8KBZ/WBCNOATD81y12Cx6bNWYzOYVa42FP8uHeMq
         tGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340958; x=1719945758;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jtxp0mR0wazQJ0QHy8snlQ9f7IXPyviJrJGWoRkeF4=;
        b=rtwRLjjER2D2Y4k5KqBc2UoNSgz6RNnutT+6zOWMljfdFyCz7ex5g2Xe6rNB9YgW3/
         KqIXf2uzckTlWmoZXkfQTHrmCbee4DaXz98pEZossTb0QuxVQ/J78RrgqSdKLSq4tY9t
         HIGdDxCtVIDsPP85GMM1dLANLuY9E/1QUpi8YB5nJPOJku5ev4333TjBQM5po00zACqw
         eogVpf0XAwwE0A2rR5DD+jXbS+2gesJRoVZtMFFSO4v3dftORZfV08EXstZExWwNgCJ3
         XDLI4UPEOaA/UrnEEDNBCJdnHOw+IgdKgyoOO/ILIrvpAO+Xe3RAw+bSt3f4ccdPAImj
         IyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaHa4HFMFx3yflMnwADKNHYWuxNo6abwRBW+mPuNFENg4VDAWCvFvI0fqoWw31HVscmjRAPpibojMNerZeO5YDnBb8dw3ZmId/yYCT
X-Gm-Message-State: AOJu0YzpLHzXLIT5dEFV4VjZ7xNaTuCMdbYsQ2iGUPBpHm/IYCYjIdhI
	vCa59Suw6J24y8XUgcjZxiM2vEKMkCnsdtcCkAxfW8/AApN42ScewgY06ehqKFwzVuUak2jyxr2
	aXUX42w==
X-Google-Smtp-Source: AGHT+IGjuQZsjVspt/MHABb4YY4H60Ya3QAHqJAi+cDbppR5HkDLLag+kmSJL3BP67+xNJsE1rfFPw/a/cKu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:1205:b0:dfa:8ed1:8f1b with SMTP
 id 3f1490d57ef6-e0303fd438amr464660276.1.1719340958246; Tue, 25 Jun 2024
 11:42:38 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:42:20 -0700
In-Reply-To: <20240625184224.929018-1-irogers@google.com>
Message-Id: <20240625184224.929018-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625184224.929018-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v4 3/7] perf pmu-events: Make pmu-events a library
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


