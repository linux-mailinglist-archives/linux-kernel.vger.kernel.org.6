Return-Path: <linux-kernel+bounces-556976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E61BA5D1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A0B3B215A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87175264F9E;
	Tue, 11 Mar 2025 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezp/DxVA"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF1264A7A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729006; cv=none; b=G7lX+M7n4JVO+IOnh5IMafLdBia7DzpMPd91HuX4/mPAgYvWnigE5SmcAq9iDmqWBz7bYxYF1T1Zt8KZW3KnvDW75Y36G8ayn6Fv0gKoP78FRaa+kdmpTAAGwzqHfcmisb7QWt851ArOj36IgYOIW6poSEYFycpqa8tWSdlMCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729006; c=relaxed/simple;
	bh=wGRplBneEc1rIRRdZMJiQ0Fw8JqUQP1EAzOvCudzAIw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jop79m4sKAvE8BTuXaeYoy4MUx6kJiO6ENoSutMU1yStoTVOyB9LjUoG3ceMkKR7onhK/XmGxcTz+PCI49yWviUrswssF0HPqWIMT5SEjw+fgLrv+EZ6fvMnvc4RogjUQOUq8EAxYi5NFwtfrIriIwfMS6xnYUvlyc/mIUC2T/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezp/DxVA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e572f6dee18so8507692276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729003; x=1742333803; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cDMG93hxPUKXZ7cLkWYorGVfJKpRaqSUmDH4zrnk9A=;
        b=ezp/DxVAj9Iwo7Wft0119uEysxdHgUA+xb3T0a8ZAIHYyDo07B/PQ3QZGYZY/ON53a
         eHuDsylj0zivr2PDxM02eM6l2Q8JjCWsSds76bSdqxHvsC0MniG8OvqsGUZWNOX7DCdu
         TxNP/pf4wca0zL1T4cToUaJSa3emcLNL/vAkkB+HbNwd63h+AwLfg9XbVYWpJr4pkWsd
         WOnC0hwbyQZT9q2rf6PINcDlezufsOe6HLGEw2Uqh+ZUbUlKYkhSbgkyW1pDOA3yWhCh
         pTJ3cGYhIT7y3Vlll3fH4PB7aT1UfCK/o3DtAdX/w9ujg8S6FZO3tKL7+6O6xaCkJBAw
         bt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729003; x=1742333803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cDMG93hxPUKXZ7cLkWYorGVfJKpRaqSUmDH4zrnk9A=;
        b=ucwnigo1XNqL3P4jLzu24lLgk9z9HohzjE5v5LKW0zlaMsxLRABqdjd8tv05bdBxWs
         lzt2CMAVymCKPpWfRSgIqskjy9pKdSdCJF4P6p4uoJoQPHfhBLMZ0m0yU6O1r1bxulns
         4dHu/404Dat7vss16BYuHIUBdkc18JDpg1Rca9RAm9JLx7YQwFuI6wouFB6B2gAVQG54
         AMhVekzDzXl3e7Ym1B5J+Il1WwpGQfMYGDADCXRVOblUu/KRfSX7Ly6lcqWWMsQL9Cyk
         gBXMmrXBRrnJCqX9jUg0Tp96TSXL2/PDGAZSmYpyu7srO4xk3BdaSR4u8KxabN8z3fCr
         dLBw==
X-Forwarded-Encrypted: i=1; AJvYcCXGTYT+C6iJPfSxvrmzEdZPBgVj5s0+mS+pguj6atTE4ob0MNWwkDKBRQkcfEG/61qScLtDDKQEOIaWtC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzltrMbOcX+8dTU3lizmhqKA/+LA72GVo16wI4iAFEfo3SGlgB
	R1SByqUkwQ54+WiBLxJ8LxIzm2o4iBv2/bw8a9lSLUefJ23+gpdK+IYeyZ39jWKsusLJakxMgAT
	+GQbXnw==
X-Google-Smtp-Source: AGHT+IEiOPSjPvcxng/rOefKJ2Ly70BAOiBxBmrwoe/2mKuAHw/kJPRmtJWO7sdKvqU40lKe9m72eTkVulcl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:2d04:0:b0:e60:b036:664e with SMTP id
 3f1490d57ef6-e63b517afadmr35491276.3.1741729002756; Tue, 11 Mar 2025 14:36:42
 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:23 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 1/6] tools/build: Don't pass test log files to linker
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Separate test log files from object files. Depend on test log output
but don't pass to the linker.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index e710ed67a1b4..3584ff308607 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -129,6 +129,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -139,7 +143,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


