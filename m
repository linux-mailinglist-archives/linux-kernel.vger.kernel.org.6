Return-Path: <linux-kernel+bounces-249639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51092EE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D447A1F2255D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A0E16D9DE;
	Thu, 11 Jul 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSCkym8s"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223E2209B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720815; cv=none; b=YC/NQ3RycDO4GBtgh7FJJ40J4HenCzYptxIHeYF+KqS7Pi92MjnDIhlElnyrmwlHpPIXrpGVbxpitA+JW5ylqUgD59Wo1mUORFJrUm6P5xvT2lyee7FZ7HxkfQJfnQw516+ZSrUj0p/UysMU7Q5fqEZdBSJs86nehF+9ydVlP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720815; c=relaxed/simple;
	bh=nadOhPkYHmRD1KvsntloobODi1YRoy3zk7/+rRmhu9c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=JoqK/ebo1lPdJYpAuaoqAx+mgSRA52LGwOumAsNRpVLmZVm63rrMQqvRaZOhM8OOMD83e6U19GGCL/W7PPPni4UHUV0A2ZXEV7iuibZxCMiXI0SQsiXdUJSn8WawI7xAVm2KihlCoc6CYDortYIs4kioFYPRv2oCdXFERTfwdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oSCkym8s; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03fe45dc0bso1926995276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720813; x=1721325613; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vd8Kna0+0RAluWRoKv6o+QCtglnUtuOoGSBcyKDtFeg=;
        b=oSCkym8s3weL6xaYls1vyjlYBD3767kYZhiPBhRFo9O6CYWI1GUGs6Mv51hZb7YDYK
         O3UE5AOLARDNoFyqv2isFOifxOziHzDWeqqTvOn1Yvixr0YUm4roxC+CRPrzbI8yaUDw
         Dq8x7teQpaCfbAVBcjG3NFoexfvGXBPe5R4DRLdwVT25PJRsO1Wy8SgqcvzWSWMQ5CvA
         sjPNg3K5+/tBzKrlsgkh+znLGNqEagiiYFpnnGko0spx9vVYWhBftHd1OfltzCp4CYSb
         YT/PpMvyBpg52WU2nEppOpKoYxkOY0aijkTR+qJADvxNXysaN0zLnsgMgGymPdk4U/ip
         xgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720813; x=1721325613;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vd8Kna0+0RAluWRoKv6o+QCtglnUtuOoGSBcyKDtFeg=;
        b=EYI4SFoMGpudyQ7TK3HvXuuYugXTFvKrPVttyNpcjz/eWs8C4bhu+A+grTskgAv+96
         ZMjK+D5qFR4oddb/nLAHD0ydlmXTp3zPaPwOYL586VR4J70uM1whEY78P4Y+pgZS5eWQ
         dhsgHKV7uWPbvflLL6Fe67LddoW3HMJnii7weu04qttBbF8D5pZuesHWnVdXufwwEyYp
         GztaX9sdPUJdeoQAkXXRSn/suNQhNEvXfkA+Mw64IcBXfTTvUQT/FUra5fLFZG77JrcZ
         fIpV9aueHpypWRyqQbdgPHvnkEk99siLJ8Izl4ZHwzvMnqdjN6hyAVCM0fmt+z/UMAqa
         niFg==
X-Forwarded-Encrypted: i=1; AJvYcCWWOElK5o1OEZG4VRsSMVo9/ib2r/3pSEwV2xNsDHC1p/nZR7ajP1WGKxctxs6GlEGis8jInIQRfbv8rx3hQcIcvCAf5abX8jWH1Dcj
X-Gm-Message-State: AOJu0YwVJdXFHqwUNxWrDSfdPRmRNPplJF56zdDy2cHTl3zR2a21MhwG
	H+JWbKs8MDfp5E1m2ve28KspiEI1XRGdTVNz+hwvPD3wfTJvj9YvmZLN30K0b9hQooBfuJJQzco
	2Gr+vwA==
X-Google-Smtp-Source: AGHT+IFAKCKgweyOaJWl5MOnJPgmzdawWpR8UxfR4LBJcvZ/Pxrc/95vokU4ESpEhRtx4U/Yj7T2pPa8qTrX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0d:b0:dfb:1147:cbaa with SMTP
 id 3f1490d57ef6-e041b111731mr962320276.10.1720720813415; Thu, 11 Jul 2024
 11:00:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:40 -0700
Message-Id: <20240711180008.188906-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 00/28] Constify tool pointers
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

v4: Simplify perf_session__deliver_synth_attr_event following Adrian's
    suggestions.
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
 tools/perf/builtin-lock.c           |  41 ++--
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
 tools/perf/util/arm-spe.c           |  55 +----
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
 tools/perf/util/session.c           | 366 +++-------------------------
 tools/perf/util/session.h           |   9 +-
 tools/perf/util/synthetic-events.c  |  80 +++---
 tools/perf/util/synthetic-events.h  |  70 +++---
 tools/perf/util/tool.c              | 294 ++++++++++++++++++++++
 tools/perf/util/tool.h              |  18 +-
 tools/perf/util/tsc.c               |   2 +-
 54 files changed, 992 insertions(+), 1107 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.45.2.993.g49e7a77208-goog


