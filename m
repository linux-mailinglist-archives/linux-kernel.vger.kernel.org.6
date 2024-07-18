Return-Path: <linux-kernel+bounces-255817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA393457D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB041C21653
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF93186A;
	Thu, 18 Jul 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGEEWu8m"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F8139F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264437; cv=none; b=TuXoHqFgfEr15caSEKJkHHJFcgChpm0Hluh3VUYOXeqpuFe7bGA6+Ss0r+Tr7TfLOswUXNG82fxCd6aRTkgH153KcafqAkDSkxerdpUaDrHi+N+NnsyOHmRpHgKK1gvLOFngR5PKKqs/CswN2Vkj0v4O/jlQUzz6I+X9DwO8/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264437; c=relaxed/simple;
	bh=Aqr8txvAKb/Ks2AqRYSwD4zP+Gyb1HSS1q/uHTHPYQA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=WLWr9lYJVJTPfkRI/Vf6MJuL8v84OCjFC3Lsrruq2iKeg6VqdB2QEnWAwhTlV7Npx9kjn6/43ER9bFzL+0b1yTJWS2s1DqSgWtqYueakLawWmK25ESfDPDmG/Ul5V7rT65Hyme4JV9IdCvW1+yT1Ut3WjWfshsFNvIjg37+PR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGEEWu8m; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64c3f08ca52so5708337b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264435; x=1721869235; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zrcyc8gXqpGqFtKT/LVbyti+Na7lXHD7L3nsAsfzWqM=;
        b=hGEEWu8mynXqGavrQcBYFDZWsEn2SBOyAShnr3NrsMeoHlisTPVFxFboTkCYry0rwf
         ykW274Yo/8nkzMqYGNuz8CI2q5t/h333+c842xzmUKwv+IjWm6XySKX4wIms+SWvMzWD
         Nbyd28kROC+BOh+O4AK8lKRCQKg59wZx6a/BumFZnXw/x1mCY5wKFPqCQTsm1EIIhGze
         6OnUEFee4LMftO8PfuyQ3uhCrn6zv2KBImYTUP3QEwbNF7AUzLqm4AeWdmgQGi3XQmXr
         siP2vouchORO2gm3fJsvsF0Irx1hfRBdhpLQ2UHfJCu6ZG1EKX0w6H2xdmIqyCQb12Fp
         F2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264435; x=1721869235;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zrcyc8gXqpGqFtKT/LVbyti+Na7lXHD7L3nsAsfzWqM=;
        b=cYXI/gfFws3P38tsBi1Ck1Kji3E8vu12kqoQztxImkN1CZICjYMeT9TgUUr0qkmFak
         deGmm0/C8y5S24Yn5rSvnrgC7f2fYN9caSG2vNVUbFAxRLY3L3q/b7cFG9CiuSWjcJNC
         JE3uhN6ICN14Qd+2mPDrsvMTKMe+ldcJdPbW+mKuDG7JII4ePkxIyVMVVrtz8jCC66SN
         O57SxpIq8QmmsqaE9M2Ej1xridTc+T5TIsa8oGYSRtkQkaZ3Vcb/6DvLgx7IT2W7dC2J
         OLRfz96b8TG/wyjdrenuswWa4NcP/fjv69/cliceUIw/I1wyuJtcBQR62uIQ5CgeHYpE
         toVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBeLzi0ImM8G2W4gObSa3T4rnK/eKI0zZLGuKt1lnz0fKDS6OcCrwdTFYTUPYF0XIF0N0Ue/sHU5/23RxUTc7mqqEd9NdOlNnA4+IU
X-Gm-Message-State: AOJu0Yy/kd0nnH1otQDNlgabaDdxCwuK3omzL9umS8O1LRqD3pOc7k0G
	iOSwPqCtcSZUqn+CdhVMhZPeCtzn/MUXTxT/LlZNu5vVELBBR0k58uvA9es6WQ6IZstvrItx9jV
	hVMzVrA==
X-Google-Smtp-Source: AGHT+IElo8hh3HdU2+Y9IMQTt4azsryvxVImTHbTwr2xjvT8I8aetlbVacAN9wZqrr06oFZXpjhKQSw6x5pL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:9e:b0:64b:683f:795e with SMTP id
 00721157ae682-666016ef6e5mr1095407b3.2.1721264435216; Wed, 17 Jul 2024
 18:00:35 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:59:56 -0700
Message-Id: <20240718010023.1495687-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 00/27] Constify tool pointers
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

v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.
v5: Rebase dropping asan fix merged by Namhyung.
v4: Simplify perf_session__deliver_synth_attr_event following Adrian's
    suggestions.
v3: Just remove auxtrace dummy tools [Adrian] and make s390-cpumsf
    struct removal its own patch [Adrian].
v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
    cs-etm fix for address sanitizer build, found necessary when
    testing dummy tool change.

Ian Rogers (27):
  perf auxtrace: Remove dummy tools
  perf s390-cpumsf: Remove unused struct
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
 tools/perf/util/cs-etm.c            |  39 +--
 tools/perf/util/data-convert-bt.c   |  34 ++-
 tools/perf/util/data-convert-json.c |  47 ++--
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
 53 files changed, 977 insertions(+), 1102 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.45.2.1089.g2a221341d9-goog


