Return-Path: <linux-kernel+bounces-184334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073ED8CA58A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E71F22768
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0A8C1A;
	Tue, 21 May 2024 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clp322AP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132907F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253493; cv=none; b=V0zsbOtErTeMEYUbCCCE8Imj8trqxXOqS/ygq21fsyY7qFeloMmQ0ko7Soh9buk5G2UJpuLBR6rxCJxZ6zS1s1xTd7ToUsRqGQnWe8Y/iIOx3NBuuM9STIcXSXMhDx3FS5J6d6C/5inewuCxsBou/CIA/fh3Wm0VvAC86gT1/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253493; c=relaxed/simple;
	bh=HnZOyTLA1z7HGjFiTaimfVCHoyCYiv6gxIK1l/WLd9c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=bh/CUognetbl1yIF/N2PDqBxGIHj3IgQ37Ts+3VT0FC5yTUyidXphO+Qsh1l2ANwDdfLhMvooHUJ/6vWZLgk5COK0Y1BNaUlcZTQUMwvOwUYqs/kvDfH3fnWmzx68Jm3hWyVIinRXZGmKmTQaS+r7nCFOl/FZNPEJmPC5qW3bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clp322AP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6202fd268c1so220343337b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716253491; x=1716858291; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpOLP0XnzrTQf20d05HSRvs4OM1Ncix8hyKknNTHteQ=;
        b=clp322APGH01SehhXEomMqOXDsUBlV6LzkR909b/LG8TnlVmQEEo0d/q4XoQV/UcRd
         NI6q9shi93Gg4LvAfTMCTlGnZjdej2Y3WUbP6vEbJ0Twq7mnkfJs0c2MdMWqBiqwTMy0
         YibS5OYcVH7V9qvruf7e5BmdjqNfTuytX9mDhfTNOo03vyiVcKDA6/ggKpJxzwAHpJhT
         9J2ItzI2Om2OR+/NFgsuFoBWxeAvvOEKJcylOYBatDtFBWOZeXtAHKRBn8CzBbVVVu37
         za0huhStK95cGnKTpVW5nYYK75uNLGswQOLfg0BjGDCoDE3tbwkhbZKcdBAamaxqLdiM
         y29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253491; x=1716858291;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpOLP0XnzrTQf20d05HSRvs4OM1Ncix8hyKknNTHteQ=;
        b=c+czjIxb9ZyiJIYIbmccweUtlzEE7aunGzjLazX4vkO5oAm8XWAAxssGpQJQtv3yhh
         0DPjw/H7awwc1Y9FeCszURBVJiljnoRQk+EGI6vFWaL+Pcwc520cin3S9+vf226xY1js
         Q6arrb/cpON9z5SPSf3BNOMIvO7b6cyqwaR8HszsgNIOj8kC16wwJ9X1BTl+rvgURa2v
         prlpd1wn5HsdhaW4+e//WVruGbmpq7Kk9fOxTGepBjmklxG6/pE4RebuykYiky1dV9f6
         1k37t+5Smq2aTtBhboRlcJHS3qsw2hlCNpg7+SH5bsMeG19/qqbhJ0Gb9/fFwdiGZiXZ
         Bo0w==
X-Forwarded-Encrypted: i=1; AJvYcCWqrx5r28OKyvMzr/V72wimqozhZwlDit/0D2cQBevZP+ELI4jBpSo68cBirzY8zw1MIwPVeER7vmBZGMphSVw4IeTLETwkIV9YgxQN
X-Gm-Message-State: AOJu0YwSlupmUeWMW65l4WXzi9uysognxrDImAKHgFL0d32e3mKd97Q8
	MLw0a6wM+nUmm2vuzV7N0nsNEeUXf8/NG3h/dHOf3hSBsykZVwhZrvrJ9Bq01OmcJMfao9ZQAYt
	lwrC4XQ==
X-Google-Smtp-Source: AGHT+IH3laioA2ReSfTb001L3Np4E6P0YRTj77ACLXkl114QIRHb+vY7xJeursyPnrL6W1q5Bah5nKB5u06g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:6902:a8b:b0:dc7:7ce9:fb4d with SMTP id
 3f1490d57ef6-dee4f322140mr7251230276.12.1716253491136; Mon, 20 May 2024
 18:04:51 -0700 (PDT)
Date: Mon, 20 May 2024 18:04:36 -0700
Message-Id: <20240521010439.321264-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
    using a shift as requested by Namhyung.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 33 ++++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 ++++++++++----------
 tools/perf/util/bpf-filter.y                 |  7 ++-
 tools/perf/util/bpf_skel/sample-filter.h     | 61 +++++++++++++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 54 +++++++++++-----
 9 files changed, 171 insertions(+), 70 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


