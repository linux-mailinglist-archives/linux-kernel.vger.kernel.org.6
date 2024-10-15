Return-Path: <linux-kernel+bounces-364876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6F99DA74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC711F22C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40EA45BEC;
	Tue, 15 Oct 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkJ7GR8E"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966355223
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950528; cv=none; b=uPGmRTxYXQPjgsyP/y4+mZpXBmrO2Ll3OLsMsvCTtoFuk4kV0Y0iaMQ4kENhcdnc9INZi5Jyv9XKWVE9mtaaxqM2cXXKeWAhJDEjjlSArKvFMIIFSu3PK6kYKIudbImfnOFnt8hzSOcY9k0mnabyGVotGkI9RpCkyrpUc0NI1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950528; c=relaxed/simple;
	bh=8NLROw6KKSFllbopuuSL8swQth3r2BSa+1UDDDHl3pw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PwBKvEmGhuleN03DmMe0J8DgdMXsRRVGOKuNQgAecU8asyMoUdHioK+eJuqRwJ1Ed3g4N7x7mzN9ja7Uo0WE05U7BJUTQHzdyXJiHZEamiPnVauT9PNTWDUe5u3dh8Nt9nZQWR5AT5+l3Ir4VlMX3chlbtDKLOPMcYxIoW7g3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkJ7GR8E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd230so89948387b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728950526; x=1729555326; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sWId1MW2gWjJ8B3DXmeL36O281P7L5ABFWtGa9JPb4=;
        b=fkJ7GR8ELB0IMktL66LFMxyRY3m4wdi6btEokpppTEGCojQUNCxR4oyFF21NidwEBr
         lRguGwWEOG8dBoIpzfqvSGv7/tpb5mPTWTdNTnlC3x3PaLSwWFV9A5HGNVD7tRtb0CPj
         N1rSlSI2M2PwnZDKInUj3t1RlBpJl/eO8aziTu7eBIaUnltbkjjnUa241tyPLwcg1+VH
         mruccc9EkxsfkziGe6sad63esjDtM7e57FYUv5n7SWqpiz9/1xhI2NqzNtPiptg7Yawa
         IWw+WsTX5e0Pyc1/dG2uKekNPtOdRgWp0EgBqpGZeLXwrfe7pkVio8+MZLSMe4PZfviQ
         CdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950526; x=1729555326;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sWId1MW2gWjJ8B3DXmeL36O281P7L5ABFWtGa9JPb4=;
        b=mj++2R2FvkwtjBBJKyuuHMloAeg/7mRTYkm95dZojKcLn32tGDqDkbCBINGkZ2rHiV
         GXUK6C3+GKUopOoD4gqXq9hpM8tsOPmEN7I7OLD4BpNJLnV572VZ0CLtg5l1CRBdEQX1
         AQKCLC5AU7DjRk3kojsI5f5tOrZdzweb5a4fxKt5gD5gI90mzPKSaeg+VEL38Jw9pPJN
         cc4CBo3gpODn1c5HpmeylTCUfuqQSPPOIIso897YNWFevtpPVckHuUc9ycW8Q7ghRnjp
         SErB3GQ/cqR2QcxFBWXfOGd89CdyZCYy+fg5ypUQe5YWc22SnTQh41gavNLgJgYvKyB8
         4TTw==
X-Forwarded-Encrypted: i=1; AJvYcCXV+G/P6b1aCcD88iGC+wBVWdPRkK0c8dfBW3ZK7zs6gfLaM0kQco87jbzrmzcn05g1D0QZ4f3Qcdg2SGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyru89mcwnUjXwVlvQ8s6nEonN8eOq3yURdSAQgjzo5gjhiGKkT
	y6KwWgUTUvUa6K/cf2m5RWuS9oLEnJDxSjlE5f0n0LKvcV5sXsKD4uYK9kfmQ91bsAlzZne3mAn
	CB9mhQA==
X-Google-Smtp-Source: AGHT+IHFyTiWxaw8Ek0l8rj6yZD1R6f2jnu5vF6MOt2oGc8LyxuLsasPkZ2Bh7M2Yo+gJ2nm1BVEIFgcatJj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f1f9:f6b6:68bc:5a14])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e12:b0:6e2:371f:4aef with SMTP
 id 00721157ae682-6e347b2fe3bmr320727b3.3.1728950525613; Mon, 14 Oct 2024
 17:02:05 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:01:56 -0700
In-Reply-To: <20241015000158.871828-1-irogers@google.com>
Message-Id: <20241015000158.871828-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015000158.871828-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 1/3] perf test: Add a shell wrapper for "Setup struct perf_event_attr"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

The "Setup struct perf_event_attr" test in attr.c does a bunch of
directory finding to set up running a python test that in general is
more brittle than similar logic we have in shell tests. Add a shell
test that invokes and runs the tests in the python attr.py script.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/attr.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/perf/tests/shell/attr.sh

diff --git a/tools/perf/tests/shell/attr.sh b/tools/perf/tests/shell/attr.sh
new file mode 100755
index 000000000000..e094f3baffb7
--- /dev/null
+++ b/tools/perf/tests/shell/attr.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# Perf attribute expectations test
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+
+cleanup() {
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+shelldir=$(dirname "$0")
+perf_path=$(which perf)
+python "${shelldir}"/../attr.py -d "${shelldir}"/../attr -v -p "$perf_path"
+cleanup
+exit $err
-- 
2.47.0.rc1.288.g06298d1525-goog


