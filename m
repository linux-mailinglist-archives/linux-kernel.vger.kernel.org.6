Return-Path: <linux-kernel+bounces-309739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D243966FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5BF1F22D73
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3C16BE01;
	Sat, 31 Aug 2024 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Q2XQ2XX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFE1758F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087868; cv=none; b=eJdDcSOXN1riuEelw788eOesk0V83d1A9BDHD1iMiwu4f8xjixr6yUeLAUDUNS+M/ilOt+5ew+NhiKmpeC/9PJXw9fefanS3LHg4qGkkCOMfnkT9eNFcMvM3Uw4Vb5kF+Ff5vtyT1IbrSIezNI4VBSrPYB6YQ/JmwNSSM/sIvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087868; c=relaxed/simple;
	bh=XVNfhs0bK32n2PUsqr3Dy1HmPIqiOmkZ0KlzLN1Y2bI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=gP9IWzn903m2n+yrDCsszhKjwLXF/AEnjRMt5MHnVbP3CqwEk0R7VK8FJjFa/8gpWlb5ZSPGtKmy5634B+istJMNBZSksM0O6qIJMe6BOwhA62+lKqD5++Di5FeUguhvzoQGQYjk7H3OUyl4IsoDZfkig0e8aSXVrYwfJm+wNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Q2XQ2XX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3aa5a6715so34151087b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087866; x=1725692666; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yix+TBZPkXSa49ue1ChfBQwhkMaD26rQNK5r6EhEs+8=;
        b=1Q2XQ2XXs4Wwe8kHtQTTeibT2lNIs6kK7/cAcmYTEf546xE3Og448m5RUdTkyzn49T
         LhSgwJS28adATwR4Nrgf62yzVJZWziNThD01jftL3aTkRrbm58QGaaAI+LjOztviC61y
         QiIfKzSMTzc52satrat2ktShRgEQwxcsyE5TAVVxdnshRRWRgkoCDjZD9pJq8hcPc9wH
         0uP8mY78W+qU1i3jZAsTLHAGl5Th9RjmnsjWPCP/2uVgRB0MEwWEdAKJneypu/fR5PBh
         bYu/kQ9h7T0HOs5ZFU6vBDnobauIYQqdtoAJx8t1D0jMmnUKe8iVf02VosXscexYMPSX
         y/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087866; x=1725692666;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yix+TBZPkXSa49ue1ChfBQwhkMaD26rQNK5r6EhEs+8=;
        b=NKc+/2GrXNZIeLMeAwYz8shQmET78B7MhoXqiwgTbT9aePNlNZlHzpNzlJnmpm1v0t
         9JhAmFOSSm4wLmuDFh81oweZZIL3ARLkJgs5e9j+0n7e/mhnSOsIs+y7Jl6APh4u8FbM
         7ww0XOdFhaKeUbYNhPOn3pxnj6T15mRSCryWw+kN0l6xTagqQgtae9RaWrUoMQoHwrEC
         0PvilJ2nQemf8YaMDWCFXsskysVT+IRhKp5011vX83AqAwXOAJHn/FvnnUd3EgX1uoV6
         9JEhYPPh9HwLHnvQNVD6vznWrbpp6CluBkFL48aJfZ7uwC8zcK8CH/5jYIhIhv28vg1y
         pWIg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+n5BfmW4H/Qs+2inExcAN7juAV6OhONhxxfZvzbwSGLtt6xfR9TLptxgAfyNOmmoh977/g9UpwJlxWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypcbs7w7WntfJdABvXZHL//6W8vpYJdyDQGqxzusl/1I0M5l2/
	/0+qfAlSKoTC7ka9QlkIjU7pxxuy1Vjfr4w1LWqByOZxQI07gh9iu/Q9XWw79CumJQsy3LxGyOy
	m0fLvGQ==
X-Google-Smtp-Source: AGHT+IFSQlqCaooK8EKm3oSpG167pQvMkiIAlIb5MBJCP0D74T3jspayC9ArNyHScKXixrYOkTzvSYAFVc0S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d5:b0:e05:fb86:1909 with SMTP
 id 3f1490d57ef6-e1a7a1a339bmr674564276.6.1725087866165; Sat, 31 Aug 2024
 00:04:26 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:09 -0700
Message-Id: <20240831070415.506194-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 0/6] Various 32-bit and test fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Running `perf test` as an i386 executable yielded a number of
failures, some of which are addressed here.

The first 2 are straightforward use strtoull issues when parsing a
64-bit quantity in 32-bit land.

The 3rd patch just avoids a fail when `perf probe` isn't compiled in
(in my case as LIBELF wasn't present).

The 4th and 5th cases fix the breakpoint length, on i386 so the
sizeof(long) used matches the kernel's sizeof(long). On aarch64 the
value is change to 4 instead of sizeof(long), ie 8, as future kernels
may make 8 an invalid argument.

The final change addresses i386 watchpoint support not supporting
8-byte values.

Ian Rogers (6):
  perf pmus: Fix name comparisons on 32-bit systems
  perf time-utils: Fix 32-bit nsec parsing
  perf test: Skip uprobe test if probe command isn't present
  perf parse-events: Add default_breakpoint_len helper
  perf parse-events: Vary default_breakpoint_len on i386 and arm64
  perf test: Make watchpoint data 32-bits on i386

 tools/perf/tests/bp_account.c                 |  4 +++-
 tools/perf/tests/bp_signal.c                  |  3 ++-
 tools/perf/tests/bp_signal_overflow.c         |  3 ++-
 tools/perf/tests/parse-events.c               |  3 ++-
 .../shell/test_uprobe_from_different_cu.sh    |  7 ++++++
 tools/perf/tests/wp.c                         |  5 ++++
 tools/perf/util/parse-events.c                | 23 ++++++++++++++++++-
 tools/perf/util/parse-events.h                |  2 ++
 tools/perf/util/pmus.c                        |  6 ++---
 tools/perf/util/time-utils.c                  |  4 ++--
 10 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


