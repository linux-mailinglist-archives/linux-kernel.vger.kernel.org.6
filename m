Return-Path: <linux-kernel+bounces-189123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A5C8CEB83
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3B21F22660
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9612EBC9;
	Fri, 24 May 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAD9ktp2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DE84D05
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583967; cv=none; b=W1TKFUwy7fwa3jykuABo5aToANzEMUIYKTA1L0/Sq0j8uRLVmEbtw4nRYTjOfGx36iQxXNrajxZBjIz1xdpQL7U+ScGWJy3i4ztSu8a87h8KPFOAidL4aXhcqlzKorXgQKuWcFVe4seF3WE8AxhHr8OMUCYvnymzehPG0nyw0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583967; c=relaxed/simple;
	bh=gCgxAKw5lQYNU12HmtYzfHgtWOefJwUEBWIEDW28LCc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=FvMdPl4/YcrCbRGJsaHu/oWU5Dzoe2lHwKvl6kqyvKvZuJnzb0XrOK0Iyzmr2dyI1p1R6k5Sr5t8gwdy4xPnKnntB+EB9X4UBAW1Atu9wpT5bQKoh8HHtvvbMz5ty/g/6aOtXA5IPVdNcRMB4KBAzdWyRBb1ufCCbAKbZLUvOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAD9ktp2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627956be166so12831407b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716583964; x=1717188764; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xB50v1xJEh4tZDBD3Dhd7HLyGrQgpvbCGS3Q7EGX/w0=;
        b=IAD9ktp2pieAZMNUGmOtQX3oXWD5IaYbozVDgCDR4L2qY31pg3y7mj8OKm0UWlQiNF
         uAJU9qpd42U9x+rPC+uqRQVtCPi9SZ40lBwCzTdut6hLlsacYTk4RXNb1e+w4MyyXCcs
         BH24q8Xr51jbo7gv97WSI5n6QNus/U4yz1MFnDksAEPQZh8tHwKQ7oFJlboyHbKL0or4
         1Cv03DzzjwuRmTZ2KYReD8CVxxEuq6i7jRtOtTeot/uvxbaFq3n3xcBsjJK4pzNng4wo
         ppdWnB3Z52lxOJz89n++LZDR+h5qklOU3gHYPCIoUWDcyUIsl9DS7yQGgfbuV7hr2Vis
         bd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583964; x=1717188764;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB50v1xJEh4tZDBD3Dhd7HLyGrQgpvbCGS3Q7EGX/w0=;
        b=O+QSCFyPjHUlcPQstlN5KVMLjdz+Sv/OKy5+/B1Kcf4ct8UDrXMZZ06Up3xrZ26+G+
         G/BGdNAENbbxOrTvX8LK83pRILQLAZEA2rTej27HDA8JOlISvzIURFLQd4I6usbq3CrB
         8gDW+sstpyD858B5i3a4R/hu3G8LKmfhZ3jFlno2naMZbO3646kynE6bN+PSTVd2hfKs
         aW2sQC7Dk+E0/znPs8yfS+Lz+cFn5ibgZRZNqUcoCLynfEeVUMwkY5v6ZT/ZFKqOG+kK
         3b1aAur7lUKKECh/TrtrS/O2kmN/oHKnKGFhTJzkpkIa/X9W4v4/SQZUzrIN72mN86zT
         3KkA==
X-Forwarded-Encrypted: i=1; AJvYcCXXIgufdBHlj7r+kICvFKsCWNqdfBspMxXHCAaQOtmJA1hnvrIRCEpLXkpyddomEJOTb3G7e+ENN6yA89nIoocdHtEpD1CHCfeEaf6a
X-Gm-Message-State: AOJu0YwLBum9GbZT6P89XDfcRv/bEvxvnSdyJRY28v6wnN0+gjU3F9E1
	z2whFz0hUkoIa+eCwjlv9TK2QsDkWU0UJyLVqKC+9y6ZpjFbeZr13G8vjD9rJRZizEYPN9t7Ezw
	HgoQH+g==
X-Google-Smtp-Source: AGHT+IEAyhX5lsFIRyG3c890XY9BUv/ot0WWIvwVB5kr3LpZpWAHUbdUSqtGYIOLdsbz8z3ovR5rl4gVgJvi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:690c:6a06:b0:627:de4d:81b8 with SMTP
 id 00721157ae682-62a08f75ed8mr7726067b3.7.1716583964450; Fri, 24 May 2024
 13:52:44 -0700 (PDT)
Date: Fri, 24 May 2024 13:52:24 -0700
Message-Id: <20240524205227.244375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v3 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

v3. Move PERF_SAMPLE_xx asserts to sample_filter.bpf.c to avoid
    conflicting definitions between vmlinux.h and perf_event.h as
    reported by Namhyung.
v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
    using a shift as requested by Namhyung.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 33 +++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 +++++++++---------
 tools/perf/util/bpf-filter.y                 |  7 +-
 tools/perf/util/bpf_skel/sample-filter.h     | 40 ++++++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 73 +++++++++++++++-----
 9 files changed, 169 insertions(+), 70 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


