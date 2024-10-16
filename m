Return-Path: <linux-kernel+bounces-367249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8B9A002E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2821F262A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685C1B3941;
	Wed, 16 Oct 2024 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfhSnokz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E91AF0C5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052712; cv=none; b=rOcHUs3s5chSXGtvPGn0ZxepOT8+mvniNQepY/dOSRMO7IReo1c7hjq4QewF5pUhWn0SY8OYpmjFziIxhf3mjrjsglE5WQR4toxfUmiwqpDAO/Go3rQfbe/KwshZSxc1+6OIzoWQ4FStfZ2nmX/XwD3jNeIaW2e500kRDm/M48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052712; c=relaxed/simple;
	bh=atNphtq2muvnpNjRyq+CfSdLflI1yp8tf59eJGJ5FKY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qUxkialsOqat0Thq8PBQ1HSmlUwbT/GBs/VLeo35XcI8QgWYHKQKPlk/khMActeMR3s44M6G+roSB/eR8jKUrunpVPtGaVrCLpoGGWYZMe7hBQdwVKJQwZi9+RMwyxYnjWzkNmv1cxQgUpRLsPMhq4Ltd96gZvTw8bKemoHPOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfhSnokz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2939e25402so5335212276.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052709; x=1729657509; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9FBvcyPFVemeh0oNlvVwr42rd3aNqdBh2Zt6Y7kv3s=;
        b=GfhSnokzPlTdThNa+NEMJ5l9YQcMB62EJc1mOKCi01/q67Jr+JqHy3WH/UtmNwbh/m
         kku9tcPZ3NT6Fq+7shTyB1I2nMmIvhNaZcoHZql7aBec5Rlg2jQ4SfjKSXfrGXuGUzU8
         sNcc3vU8E+VLNg8nxmTH3fgT5a1oWNFcjkra2jdz7JNQKFWGaqLSTWZKdHPH3jYS17fY
         H6W9e0lvfiJFj/t6a63+uHYsQU6l56TVyaHL5ELo3KZDjr6w84r8bUiVw+M/iiXLerFD
         PdYNNrFLeNpf+XoDIO3FaPAi42jEC6B9HwGIkG2+RdfhdOErMQ4M/RiBfhOiu1yG5BKk
         ZKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052709; x=1729657509;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9FBvcyPFVemeh0oNlvVwr42rd3aNqdBh2Zt6Y7kv3s=;
        b=nV3GCOib0iREbQ//FbIBs8j2mxdbjKR/zj/5IS2yRVD7F1sgEOa04Wp7s+RmWaxUv6
         nzXaaUj9nGRQzDYlQamzIX1Bq+EgDW2WxhVDKedoQzsGBy0Jrn8VQ84KCV3dzbl7uh8m
         0h1kMzz7esjfTtj+vOe4ieG4N0tJVvbS9qY8JW+nGARFXoofqJHkefcoLpuLgUpXOCgC
         FRxrqxJNtQz8uvjSFQf7xyOopzzyo6quzIZ7weW6WZkX5aC0shZ2ESvoEyWL1q8ee13v
         6o4T5qIr4VogrsyPTsnZhQlk1uGNXOHCDRnKm+VAs8wkzAvxyMXHzOEisqY/9OgRoekH
         FIRw==
X-Forwarded-Encrypted: i=1; AJvYcCUSk9ubcO9xTFZZmUPSerulxlvNvA9RWDwwZWAZw3t8wLLtj15gUQfmZZcafQ8MN0P9BUqqPsuzR4p88Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQ5ISttHVMBZxMqyMrxDVucjMj/4M2v4rjSOY0C34thv1uSxq
	MOBJmAVOw3RPuUGZhU1UdBIbNpe9lnQYVw5q2z9CxBgOnX/G6y4Cw88Zo84w/z0YTS2l1KtTQgq
	Is7LU1g==
X-Google-Smtp-Source: AGHT+IG0WlG2n418T7PMxezvNke9lFkjjek058CnnTXKNxeKbgILUTZrua9v/4XFvBZYiE3o8pXnS/9hYV2Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:d614:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e29785a421amr2168276.10.1729052709171; Tue, 15 Oct 2024 21:25:09
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:14 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 15/16] perf build: Remove test library from python shared object
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e54c6953cf02..957b25322786 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.rc1.288.g06298d1525-goog


