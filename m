Return-Path: <linux-kernel+bounces-345243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919DF98B393
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC6B22C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2C1BBBC3;
	Tue,  1 Oct 2024 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGqzsJC0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25371B86CC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760215; cv=none; b=ZnLDNs7Xua3BdiFgxFGNBKgf7v1O9r+bLBEOr+oRKUys0ZwGWnGPEmzOtY8usKKdrCJabNNYughufPi6jZWN2uCmZnNadd7CC+HU0shaP9k8dzV9+AcV4P6oPAR5aSlGHO8/xw/7yG8LZukZcNqJGFiVCojBLPZZbqvW2w95FF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760215; c=relaxed/simple;
	bh=Y8Z+G3E1FwYZnGTVV2SNsuzXekibwKvHxDpS4gzFmHY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=CXjgLtR8GNrPfyXVTr/x0U52shPWMLGYEEkCXuCwQ6nzzCR6wi0+1CPQZB6K2d4tLGQ5unHI0MNskImbCV1XEjeV2epguDhicXRz7CT4AlKkB/CIN8WAqzRG+00uvG6eXXwF6JFArR7YzZtGvVFstuZsFfv362Za1+bziPpjLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGqzsJC0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e249e31ac2so53840677b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760212; x=1728365012; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hnPZq2wqBO5wayp+/qP/HbZeSdJX2pF+L6UWiisy/g0=;
        b=lGqzsJC0CZmDxjgep4+m1n4w0bgXt8aRIDqQEnbAoMqE3AjNoHoXGC6NqSSwGhQmL+
         LQ4nXsF/tTRLfQaIEUe3uudi8PunDIBdvPk2kXcuRvjn8QNViJqZLavPgptWsX/GtIJP
         cBrAV3DL3yzZYVwbEePXjd8gOtc+dAXuCZ+2mslpYnhRRmCPjJx7SaEbBIXGJ2jwMp6w
         qS6eoaKERTtVx1m5IqLU7Rxz14I+DJbSesKrKt4XE6DaAkTH4CI3q2uWVNOXC1Qa5PJM
         AXiatQshK30inGmEKc6wwB69VTg3aAYwodBak1ClhPYhRQAkjHzGP9985sNllaDAaTzB
         Hc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760212; x=1728365012;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnPZq2wqBO5wayp+/qP/HbZeSdJX2pF+L6UWiisy/g0=;
        b=dedBPomCWZ0z3XU6Wk5gQR07EHaWrVDadb7zHvDPgRTkHBlGXuB4/C88KmrYS40xhX
         1Y0uXZoje5/8D/M4ctgZGHalB0oTrlT4oGdyPz1XhND/MlKYe/mzgCOktHGC8tjS0js6
         WcXcZDsJCxl3DsfgTgR1CQZ6UkjyPDjmzLyv/2dBnmkCej1UUtgs0AuFfi5fV7vYc9lb
         NMTLZwzLQPpRuav7Hc+GgFwaG8fuJRIwQowgVyKBHFviX5DYcO8hmCLBVzMwXiNY5ERD
         ulc9I2TFBg/01Irfy/lhKg4LiKbTCa3oCazdP6ozU4fbOcJduaowG6taLTJmJNYVkeWg
         MROw==
X-Forwarded-Encrypted: i=1; AJvYcCWQiMkZ4QnsmJZish8bI3UrT+S7xWyf6uSIdI3NbhRv316jSnMWcKEEC0JPwJf0xEY466sAWKhtJ6yPpkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38h2npIAhYvuqBIRlxgXu2M60i4iBGUeRzt1RaPD6Sn7FvWLD
	gG2hVO5uLtWY1ko2jH1daZ1/EjuP/8lS0epEXySM7iHbcDz8B54hxshigLwHWcwNl5KQ/Q8OKHK
	qnyVVzw==
X-Google-Smtp-Source: AGHT+IFufDeXAVmZbG9ihgubBavhEoecSpbNDyEAJ4lV55EVPCl28X+PgpGUKLM8QNB2RQYqA4s6NzGbs3t1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a25:7bc7:0:b0:e20:2d40:4b82 with SMTP id
 3f1490d57ef6-e2604c799e0mr102605276.8.1727760212503; Mon, 30 Sep 2024
 22:23:32 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:23 -0700
Message-Id: <20241001052327.7052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 0/4] 2 leak fixes and lower 2 test fails to skips
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix some memory leaks that show up testing as !root. Lower some test
failures to skips for the !root case with a skip reason of
permissions.

v2: Rebase that also cleans up on the bpf_counter__load error path, as
    pointed out by Namhyung.
v1: https://lore.kernel.org/lkml/20240924202916.1560687-1-irogers@google.com/

Ian Rogers (4):
  perf stat: Fix affinity memory leaks on error path
  perf test: Fix memory leaks on event-times error paths
  perf test: Skip not fail tp fields test when insufficient permissions
  perf test: Skip not fail syscall tp fields test when insufficient
    permissions

 tools/perf/builtin-stat.c                   |  2 ++
 tools/perf/tests/event-times.c              |  5 +--
 tools/perf/tests/evsel-tp-sched.c           | 40 +++++++++++++--------
 tools/perf/tests/openat-syscall-tp-fields.c | 19 +++++++---
 4 files changed, 45 insertions(+), 21 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


