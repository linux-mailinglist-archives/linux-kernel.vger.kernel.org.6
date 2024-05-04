Return-Path: <linux-kernel+bounces-168821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87A8BBE32
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456E11F200F5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724484D05;
	Sat,  4 May 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAUyOz6M"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F871BF3F
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858689; cv=none; b=VPMQA0mE0zD//wTnXTcdhf9p3VLxaT8SEzX3BTYjdwuMTxZkEI3N6jss1Jq+pqNrITC+7mRhVhb7QzG/jp8N/QzKfIfUf2EUgTO9ZKZx2ApJoyVu1Gqa2T2sU1i2U8dCsbAQ39UWpMk/wM2JITlDhTXm3oClB8/d7cjBZZATHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858689; c=relaxed/simple;
	bh=jwPQPE0LaUnBq10rb63Q5qQmTUg0UxtBnAXGrxMj57Y=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=kog24REwWv5o4yFo59glZh04YnLe+j8pprX7GAFZUImEdNtMDc+Yrw6oX/GbWFfzvVNza0iN6EPvAN7Fc8QkDZPHRePosJ8MlqYfYC9qVcAe+6GLiez+3x/b0CcTsiG32+cYKDVFY36z6IXuklOVgcOCLlH9aOK7+KEMZAWPKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAUyOz6M; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be75e21fdso18332317b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714858686; x=1715463486; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rB3YhgzfwXwrL9B2CMfp1D4aEZDjDbBiJNoR565UiE8=;
        b=dAUyOz6MdBTBsd+2X3z8xDoDINEvNN73Y+KkQzIA4AAAz8XqelFf/iTBMXv63tQtyW
         5eF6gpUbyZ0Xqmn+Q0Bbkvk39jsJ/GauM/ilH7cbtiejSx+PhUKna1CLvRkJcKKBUrPx
         n7ODAmSc0iLTTj3FqwjezPguXneghOb58QcKDmrOe20cJAFIYySwc3/BbNHO9oXHY7OZ
         j1RXhk5qJg55E+drmx7cLVIn2sNSfldGoXwAv1X9aeJ+H34SrirUJClh1F4PVmeCuQcg
         snU8oCKMjApumW0ZZ+pUt5tgAnCjp1pT8LWVM+BFT+nfXjlW/0837dRzZvHpPnyHj85g
         ZaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714858686; x=1715463486;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rB3YhgzfwXwrL9B2CMfp1D4aEZDjDbBiJNoR565UiE8=;
        b=lCKsnQgNiOcYioaUyHiHssLBnmKh8VmMjypnNK9ys5N7kJp9FAwBmlb89x39Kxmag5
         sUtRPFhPIdMplYp60NVivrehVYQvZgCwtioVjHXuCKkXpIHufZwcNL4F685dyNCeaPOz
         1QzZgUWWQZCMElrPJv9TYR7QDxmL2giyD1FqOWYn3+qQJByvERoLTzKRPJ3BYLN5kw4I
         OqlYCuD4WsXK34BuwuszZSZ3VGADlEx8qJSD1DjIW/pS+OhE28wh8Oeb82PeIbcPHyLy
         mqa0kYfuarSS0leDf6C9/F930BJZi4MvxE1Fk8jRI51rT+0I//BSGtGfDIY5aDM3xx7S
         a4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrY+jMbSLXhp1O4uBwLYxH5r8KrGhT74Rwi4NwbGPGVNSTzlz7h7SoYKs4iz/fWH4aUnyGHGrky/+N2Kv+59fOeXPak77NChKcw5hS
X-Gm-Message-State: AOJu0Yzy22ulQwhb7TPiFtAuVeZ7/hItn1nXvdR/PqCvRR24tuHM/vb3
	WRPXcotOSkdtEwCyYJxwp+qJ6go9ffg1yGXOJlPpGHh3KHLxRY/3q9ADlbJZd3nwGIxP45k7qr9
	jLpIPyw==
X-Google-Smtp-Source: AGHT+IF03zHilytjeysTzsY6wyb+AMpYb7yNvY7XzWmDT62USyKMxuJ1J6m2IwbM10cVzmUTDiv584riniF6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:d233:ffdd with SMTP
 id w7-20020a056902100700b00dc6d233ffddmr2150280ybt.0.1714858686641; Sat, 04
 May 2024 14:38:06 -0700 (PDT)
Date: Sat,  4 May 2024 14:37:56 -0700
Message-Id: <20240504213803.218974-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 0/7] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

7 more patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
a near half year old adventure in trying to lower perf's dynamic
memory use. Bits like the memory overhead of opendir are on the
sidelines for now, too much fighting over how
distributions/C-libraries present getdents. These changes are more
good old fashioned replace an rb-tree with a sorted array and add
reference count tracking.

The changes migrate dsos code, the collection of dso structs, more
into the dsos.c/dsos.h files. As with maps and threads, this is done
so the internals can be changed - replacing a linked list (for fast
iteration) and an rb-tree (for fast finds) with a lazily sorted
array. The complexity of operations remain roughly the same, although
iterating an array is likely faster than iterating a linked list, the
memory usage is at least reduced by half.

As fixing the memory usage necessitates changing operations like find,
modify these operations so that they increment the reference count to
avoid races like a find in dsos and a remove. Similarly tighten up
lock usage so that operations working on dsos state hold the
appropriate lock. Note, since this series is partially applied in the
perf-tools-next tree currently some memory leaks have been introduced.

v5. Rebase, adding use of accessors to dso as necessary. Previous
    versions were all rebases or dropping merged patches.

v6. Rebase, move dsos__purge NULL assignment to dso->dsos to above
    dso__put to avoid a warning reported by Arnaldo. This was part of
    patch 5 in the v5 series.

Ian Rogers (7):
  perf dsos: Switch backing storage to array from rbtree/list
  perf dsos: Remove __dsos__addnew
  perf dsos: Remove __dsos__findnew_link_by_longname_id
  perf dsos: Switch hand code to bsearch
  perf dso: Add reference count checking and accessor functions
  perf dso: Reference counting related fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/builtin-annotate.c                 |   6 +-
 tools/perf/builtin-buildid-cache.c            |   2 +-
 tools/perf/builtin-buildid-list.c             |  18 +-
 tools/perf/builtin-inject.c                   |  71 ++-
 tools/perf/builtin-kallsyms.c                 |   2 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-report.c                   |   6 +-
 tools/perf/builtin-script.c                   |   8 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/tests/code-reading.c               |   8 +-
 tools/perf/tests/dso-data.c                   |  67 ++-
 tools/perf/tests/hists_common.c               |   6 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_output.c               |   2 +-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/symbols.c                    |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   6 +-
 tools/perf/ui/browsers/annotate.c             |   6 +-
 tools/perf/ui/browsers/hists.c                |   8 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate-data.c               |  18 +-
 tools/perf/util/annotate.c                    |  17 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    |  38 +-
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/data-convert-json.c           |   2 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/disasm.c                      |  40 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 429 ++++++++-------
 tools/perf/util/dso.h                         | 500 ++++++++++++++++--
 tools/perf/util/dsos.c                        | 286 +++++-----
 tools/perf/util/dsos.h                        |  18 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/header.c                      |   8 +-
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/intel-pt.c                    |  22 +-
 tools/perf/util/machine.c                     |  50 +-
 tools/perf/util/map.c                         |  78 +--
 tools/perf/util/maps.c                        |  14 +-
 tools/perf/util/print_insn.c                  |   2 +-
 tools/perf/util/probe-event.c                 |  25 +-
 .../util/scripting-engines/trace-event-perl.c |   6 +-
 .../scripting-engines/trace-event-python.c    |  21 +-
 tools/perf/util/sort.c                        |  19 +-
 tools/perf/util/srcline.c                     |  65 +--
 tools/perf/util/symbol-elf.c                  | 145 +++--
 tools/perf/util/symbol-minimal.c              |   4 +-
 tools/perf/util/symbol.c                      | 186 +++----
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/synthetic-events.c            |  24 +-
 tools/perf/util/thread.c                      |   4 +-
 tools/perf/util/unwind-libunwind-local.c      |  18 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |   8 +-
 58 files changed, 1410 insertions(+), 933 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


