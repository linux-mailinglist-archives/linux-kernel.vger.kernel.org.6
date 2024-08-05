Return-Path: <linux-kernel+bounces-275265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 483EA948288
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EA1B22646
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45216D9DC;
	Mon,  5 Aug 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwhMx3X9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FECD16D9C9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887083; cv=none; b=mAuhrYG8qlQ/TQwTEHxJNvCEam9IK38R2yNTzaEPDIa9QyhHacpzg00zl0+RyckzpAboW77jU80A7FUTKezB7al/FbKWFuA8dkH4ALY4cFPdiVtgJPARIqt6FNUzmWvSg3MCMQXRTClZA4k+HJLX1BsdzTMcsCYEIeK+HTGJrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887083; c=relaxed/simple;
	bh=47x+zuJibezmnOmJ+88o3fpNTUvPozFiKDvbszlNEEc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gjUOS/rIW8UPPCWb7X4sj3ILYsCtwOFtvpTc0DeB4MxFjHhC+Ze5nXXb/HMgXw329mQw/gkIZjFHtCHHd+zmAMqgNC8bpvU6iSdJe7W78t1uGvQeFzMZSs7/EvKJ/7B3Cj9ovznVE3NyXcezZN1MCswfEYv5yivqYmfNhI7wxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwhMx3X9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0bcd04741fso9591281276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887081; x=1723491881; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGlP+W+E1rzo+Hc23sUegbyHJcwAQCTmYUNWikKKi2I=;
        b=MwhMx3X9BHKv+b6DHrgOMx/dsmbHtZUtrrN5x9iHNpqfYh3iZwgpog2bj4HzFnjUSH
         +gqv+fUxI/x6xCoPcdJMp4w0XFjnEvws6JtvRNIfPwEdqW73+kVCtEgySd+mFyfbSUF9
         rsTw7W85xBR2MGTNcVi161DGRjuWayE0xXuBas0bykoemCYvC/Qf6voWJ5WUJJX7BQVR
         rUxlF383Xs9YAx6xbuQr8QQUtHeV6QsdWrSeA3OeZCJUvE/1rjoogVJF+lTQ3rDIOFrw
         rlb6yddSFE0O+CwMoGKgHmsIttS3WvmOlejpbOsfwmciFybuBlDf2lcyMCMiWdpfAKZP
         +X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887081; x=1723491881;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGlP+W+E1rzo+Hc23sUegbyHJcwAQCTmYUNWikKKi2I=;
        b=X563hB5a2+az8rr4giCaNRDOKJPp+D9yP26LT0ssJNPQzIzIsS6tbSTgCXRFdndHmt
         /FQaPZAwZJrUa6C8tDqmVOwzYwf1r5YKtBJPqQ0yEokUimN3zn2M9tVGi4C0gFqMeWsW
         rUNaDJk+GRSJGZwA4IL3VFFaPW0V8L3PtzNrIS6NU4SR9apNI3A1t/J+wis2Q6TF9Ae6
         GIqaRXwpmAIABWSOPtjK0gbS7Bo6q8YUL92nCGK8EdCowDmRlAFnppZHTaHsRBN6hbhm
         lH4uj+Pok3LeArvupygBfghExXcSIcCveGKa52WWuUPv4kowCy3ucx0/gv+eeKw+ICCY
         i7ew==
X-Forwarded-Encrypted: i=1; AJvYcCUfxkohUB0m13/hT8bwGNkk+dJh3IdznJ/7h8go6wd7aFqSJUqb6dxeZS2gpZs+2/1L+/TWj8IK9AynCXffRrLs03kTslnpnQLdeygF
X-Gm-Message-State: AOJu0Yy0rp73jRCgGdF4dCSE+Lblou1vAt4lTuwF6xCWF8rgcXILYOpA
	O1se4B9uSCBiMCQ9aFjb0TXsB0sxIFad/UpGeDDyXdPVljJ7JWLOukI5Euh7tZEzZW+lICtWldP
	96ivDnQ==
X-Google-Smtp-Source: AGHT+IE+AeucgMIyAO3Z0FES/ae0JgHq8LbXGHTnVeU3bAh9HD4a6vZXuMVuSJRiYYFv5skWk5Mgq+Gnxr3N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a05:6902:705:b0:e0e:3f14:c29d with SMTP id
 3f1490d57ef6-e0e3f14cae8mr166124276.4.1722887081584; Mon, 05 Aug 2024
 12:44:41 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:24 -0700
In-Reply-To: <20240805194424.597244-1-irogers@google.com>
Message-Id: <20240805194424.597244-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 5/5] perf jevents.py: Ensure event names aren't duplicated
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Charles Ci-Jyun Wu <dminus@andestech.com>, Locus Wei-Han Chen <locus84@andestech.com>, 
	Atish Patra <atishp@rivosinc.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Eric Lin <eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"

Duplicate event names break invariants in perf list. Assert that an
event name isn't duplicated so that broken json won't build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fcf0158438b5..1d96b2204e52 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -503,8 +503,11 @@ def print_pending_events() -> None:
 
   first = True
   last_pmu = None
+  last_name = None
   pmus = set()
   for event in sorted(_pending_events, key=event_cmp_key):
+    if last_pmu and last_pmu == event.pmu:
+      assert event.name != last_name, f"Duplicate event: {last_pmu}/{last_name}/ in {_pending_events_tblname}"
     if event.pmu != last_pmu:
       if not first:
         _args.output_file.write('};\n')
@@ -516,6 +519,7 @@ def print_pending_events() -> None:
       pmus.add((event.pmu, pmu_name))
 
     _args.output_file.write(event.to_c_string(metric=False))
+    last_name = event.name
   _pending_events = []
 
   _args.output_file.write(f"""
-- 
2.46.0.rc2.264.g509ed76dc8-goog


