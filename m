Return-Path: <linux-kernel+bounces-234793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B991CB08
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E84B22CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D222EED;
	Sat, 29 Jun 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNDKMXEt"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BBB2570
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636850; cv=none; b=II4gnSE5zkRYJREcm7+42TKf6tjnopAbWelCIRusWDyd/GeBDX48zKE1YjtVdAl79GRUD3TMagU9q8pFvs/kqI6h4/lRzwgXQ53iihzVBklfMdyL9TBhszjiCpUsm9ekSYktrHPGrv64rp2Azt5gmuYMYbsCljvYByA1NQaWq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636850; c=relaxed/simple;
	bh=ulgnEXeySFIkrktz7yXWAqrrSl4AnoUp7YlCZDC6t6o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=UTq/3avsnZZcGluWDl3NT9xYkSqRbApG7+PUOgEd3qO5cUBkrTpdYsvrtJtXh4yxeHgk9diVOoDDnWsa+uomZBFM8+x8kE2lbbivORDJY+YrvDP/ZkDIquENMw5rxgQ+GcA/bU4LGLZLYwHscgiMFzeaLBPXOJJAwzrOy499308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNDKMXEt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf44b87d4so13766247b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636848; x=1720241648; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/0dC8Bwm3vf/Imiu0GWXnmXRUHRnUVX3GhUs/K6jXVQ=;
        b=pNDKMXEt4vuOwp0Iozt4OYhdV1Vq/DiqEbcyJOd3CONAbytZBmHbI3zfMDihqqyjgk
         woA4t5A1zMgoQgW4qA2xtDp141OtP0bqfOKq5bZKnBrawFDMZMlMpbqWzTGzTLRhpmGn
         ne0XRJbRnROJxM8N0ZaL+buLJPK+bcMRJfdyqlwZJI45MdeeIf15MAk6Xm8a8ovsVu3S
         CLMeN9cNYPZit7cOKXJJDTJCqBtim9ZQ4+fIA7pxbnK/aLIq7mJj9qVLexB8LsNQt6cl
         fbHeOuuvbtdEls/OgGK2w8KsOhHz6xBlwjJxtwqNZxxDhL3n3hiWtUjO2VME+Z78B0sf
         pI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636848; x=1720241648;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0dC8Bwm3vf/Imiu0GWXnmXRUHRnUVX3GhUs/K6jXVQ=;
        b=XW8fcJWavtJ9yiQMCWmTCCGMety73R2x2YdwU5v5ku4w8MXRTPuIJSrZA74JQTZlxv
         b+8o4y/9MgkIM1epK7D3Y/K+WpJuV03rajDP1KAzoxora5sObZ1i6Kkg9bwGbHVYfiRb
         KSPZ8/myYSUs0vq1a25XrMU5vd459PiFRtHf6CFOxjNktJfxEhvAcZt3C/moRGZRR9No
         cgAJCfZKV4OO01huOJx/CPmIZ6UOXny2wULCibIIZVp2pQRIX7tDnRZBBWswfsuvOh3N
         JTIdAJ6mqw66SPsEKnbCfuzPj05zAxw006CmbhB23VQRU5ebSpbG/72u9pzw2MRuSksE
         0fYg==
X-Forwarded-Encrypted: i=1; AJvYcCXk3jJEgLkm1aEjg2i8w1qW9JwNAPvdTEFYf3dNli12dmJkpwsE2IBoGb8h1vkeYKGv3Gz/ewCWzJjr1enJGcUPUsIxKqgVJUmTKEXo
X-Gm-Message-State: AOJu0YytobxSUYW4aiOH1ltrx+ZyFMo5UxHCivsX+KwfltZ+EPYseJti
	Fbs+qjyMm9kXkDNgPTJScLY0CJDRUpNbYV8ZU9g6PLrXSkk+xAV9RdQxjxpFjqgWhrDI6MuR3cL
	pMRHuXw==
X-Google-Smtp-Source: AGHT+IHoHdrZmEBlrpZ6Zqpk1K2Ypd9vGdWOS5MBKTc36yPJSr3winrBSZVjqq0a+AN9vOt7GZ4Og36DCWr+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a81:9281:0:b0:648:2f1d:1329 with SMTP id
 00721157ae682-64c6b773206mr325697b3.1.1719636848038; Fri, 28 Jun 2024
 21:54:08 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:22 -0700
Message-Id: <20240629045350.285243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 00/28]  Constify tool pointers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct perf_tool provides a set of function pointers that are called
through when processing perf data. To make filling the pointers less
cumbersome, if they are NULL perf_tools__fill_defaults will add
default do nothing implementations.

This change refactors struct perf_tool to have an init function that
provides the default implementation. The special use of NULL and
perf_tools__fill_defaults are removed. As a consequence the tool
pointers can then all be made const, which better reflects the
behavior a particular perf command would expect of the tool and to
some extent can reduce the cognitive load on someone working on a
command.

v3: Just remove auxtrace dummy tools [Adrian] and make s390-cpumsf
    struct removal its own patch [Adrian].
v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
    cs-etm fix for address sanitizer build, found necessary when
    testing dummy tool change.

Ian Rogers (28):
  perf auxtrace: Remove dummy tools
  perf s390-cpumsf: Remove unused struct
  perf cs-etm: Fix address sanitizer dso build failure
  perf tool: Constify tool pointers
  perf tool: Move fill defaults into tool.c
  perf tool: Add perf_tool__init
  perf kmem: Use perf_tool__init
  perf buildid-list: Use perf_tool__init
  perf kvm: Use perf_tool__init
  perf lock: Use perf_tool__init
  perf evlist: Use perf_tool__init
  perf record: Use perf_tool__init
  perf c2c: Use perf_tool__init
  perf script: Use perf_tool__init
  perf inject: Use perf_tool__init
  perf report: Use perf_tool__init
  perf stat: Use perf_tool__init
  perf annotate: Use perf_tool__init
  perf sched: Use perf_tool__init
  perf mem: Use perf_tool__init
  perf timechart: Use perf_tool__init
  perf diff: Use perf_tool__init
  perf data convert json: Use perf_tool__init
  perf data convert ctf: Use perf_tool__init
  perf test event_update: Ensure tools is initialized
  perf kwork: Use perf_tool__init
  perf tool: Remove perf_tool__fill_defaults
  perf session: Constify tool

 tools/perf/arch/x86/util/event.c    |   4 +-
 tools/perf/bench/synthesize.c       |   2 +-
 tools/perf/builtin-annotate.c       |  44 ++--
 tools/perf/builtin-buildid-list.c   |  10 +
 tools/perf/builtin-c2c.c            |  33 ++-
 tools/perf/builtin-diff.c           |  30 ++-
 tools/perf/builtin-evlist.c         |  10 +-
 tools/perf/builtin-inject.c         | 159 ++++++------
 tools/perf/builtin-kmem.c           |  20 +-
 tools/perf/builtin-kvm.c            |  19 +-
 tools/perf/builtin-kwork.c          |  33 ++-
 tools/perf/builtin-lock.c           |  41 ++-
 tools/perf/builtin-mem.c            |  37 +--
 tools/perf/builtin-record.c         |  47 ++--
 tools/perf/builtin-report.c         |  67 +++--
 tools/perf/builtin-sched.c          |  50 ++--
 tools/perf/builtin-script.c         | 106 ++++----
 tools/perf/builtin-stat.c           |  26 +-
 tools/perf/builtin-timechart.c      |  25 +-
 tools/perf/builtin-top.c            |   2 +-
 tools/perf/builtin-trace.c          |   4 +-
 tools/perf/tests/cpumap.c           |   6 +-
 tools/perf/tests/dlfilter-test.c    |   2 +-
 tools/perf/tests/dwarf-unwind.c     |   2 +-
 tools/perf/tests/event_update.c     |   9 +-
 tools/perf/tests/stat.c             |   6 +-
 tools/perf/tests/thread-map.c       |   2 +-
 tools/perf/util/Build               |   1 +
 tools/perf/util/arm-spe.c           |  55 +---
 tools/perf/util/auxtrace.c          |  12 +-
 tools/perf/util/auxtrace.h          |  20 +-
 tools/perf/util/bpf-event.c         |   4 +-
 tools/perf/util/build-id.c          |  34 +--
 tools/perf/util/build-id.h          |   8 +-
 tools/perf/util/cs-etm.c            |  49 +---
 tools/perf/util/data-convert-bt.c   |  34 ++-
 tools/perf/util/data-convert-json.c |  47 ++--
 tools/perf/util/dso.h               |  10 +
 tools/perf/util/event.c             |  54 ++--
 tools/perf/util/event.h             |  38 +--
 tools/perf/util/header.c            |   6 +-
 tools/perf/util/header.h            |   4 +-
 tools/perf/util/hisi-ptt.c          |   6 +-
 tools/perf/util/intel-bts.c         |  37 +--
 tools/perf/util/intel-pt.c          |  30 +--
 tools/perf/util/jitdump.c           |   4 +-
 tools/perf/util/s390-cpumsf.c       |  11 +-
 tools/perf/util/session.c           | 372 ++++------------------------
 tools/perf/util/session.h           |   9 +-
 tools/perf/util/synthetic-events.c  |  80 +++---
 tools/perf/util/synthetic-events.h  |  70 +++---
 tools/perf/util/tool.c              | 294 ++++++++++++++++++++++
 tools/perf/util/tool.h              |  18 +-
 tools/perf/util/tsc.c               |   2 +-
 54 files changed, 998 insertions(+), 1107 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.45.2.803.g4e1b14247a-goog


