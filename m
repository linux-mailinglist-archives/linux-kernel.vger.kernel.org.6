Return-Path: <linux-kernel+bounces-574058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F0AA6E017
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A4616D775
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BD263C9F;
	Mon, 24 Mar 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOpBFxHV"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFD33C5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834764; cv=none; b=K00s6J5MEGkKVBoVQ8rYR/hpqrE4OWul9Y0hC2OUoLpgeZtiatmqHGWVbth1e71dzFukmpA3ipKQZ6FrQ5ygsWGe5/GeYRb5M6HhAZ7mN5bOucWKmzlKG3kZN9K8qWzxJXxm33/KtxXJPVItzCTPxiQY5oHWHLetKAJF3xgQ64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834764; c=relaxed/simple;
	bh=kGGm0hHX97r5Hlte6ukMiRM+d5X7SguOOWvGRL5+nOg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Rext1ODEdzp5s3/gKCoJ+NFHKPkr15JoSWMnupk7lTFPuSbUE+sQU1UCnCpQFDy7LMF7TVhQgmQouvmiorri/s1zrh36C5VRNiSOQgL8nItJoFSiisucfozfsPSaZrczjua6kgtqE1cZJvB4HH6q4wyd0tMVkIXdHWV1grONuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOpBFxHV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2233b764fc8so75794815ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742834760; x=1743439560; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DoYbS0EKj0UryA+/vVWIl7aYLqF4j2vWeOth/Be3Fc=;
        b=uOpBFxHVlq9fIjL5njeOJ0JFIgUpaUBsx/a5uRamubKeMkikEuqu+1ytSG0ZlkgEt+
         bgMTNmcPUs1MB0Vv0pT937pTNlvIFakrnRWqFqp1LKbWkPZvlVmD+JlNcUZhQ2JHKaBK
         n3y7yyYgIE0NRJO2l3xckEpOSqqmHCYgjf4NSWwJvMCnILzYyvXR2eFGVzNPSl8LSpZw
         p6KAjXgkXZwBiG4GtCsL2JwdmeNaZXAOiDj6vU83QfEPZ24EWCPwLZtIoDUlFhpiuHHf
         oMjsd+d4rGpC1I2h8HJaedPm4yAGd5Qw9cs11Vxs2e2gAUlrB+YGcfVDxGfPngGGWUBk
         PSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834760; x=1743439560;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DoYbS0EKj0UryA+/vVWIl7aYLqF4j2vWeOth/Be3Fc=;
        b=pcQSkNBmNNIlHpJUeaSV/65hnty9GmIPhQx3hgCZqL3CcVD0KwDV5svdu1KtLBOgTc
         PYUE/aPaPOJiOiAlXJ0/QM7edQvX7S3K0zwWXjn5g3wAHH8pfyXWBJCxmXq83kwJxvcw
         Zmis9GdloIQmeMP9l5i3BXP0Qd/3FVDeyhDvn0VyasXoz88uQkeuDUFpkZh4cMdnlLWe
         8uOzhIJKL1uRilKBHiYiuWjvZotrdhDZJT+EFaSRykY9ZW8jx0XLPxYPAF+bkGJ4SFgu
         qPkR+5XpS3s4q4VRAFqt2jjs7Nlg73+yU0NDWZK4sXkXh4R/vhjvmGi8f4K1iSC/x2Dv
         /rjw==
X-Forwarded-Encrypted: i=1; AJvYcCVxA664SuNZiIDxYroBUGd6DEXJRRP6U9OgTrnuuOz70C8M0B7+kAFRMjbZgeUZVNhfOcd0riurw/sYiPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4tULEZ/hWh3KTirM+F4UF1fynqnvW8RSfZy4X7KAIYMGzOc2
	rZDfRxx1QF+OuLPtHYRQuX5J4UwUnULp+z6Pj9L4Z2tAXWAyzCxPXwcubhIjhuUkowUnp0+Qboe
	TWPi4qg==
X-Google-Smtp-Source: AGHT+IEeiuHTxFvewILH6wDwbFMGhKcv5zYy0sVfAdJuDf+15o2LQaZG/NbWHw71gAdjQTxb5tpvI0QIZV2X
X-Received: from pfbhx24.prod.google.com ([2002:a05:6a00:8998:b0:736:5b36:db8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f606:b0:215:89a0:416f
 with SMTP id d9443c01a7336-22780dbb8c5mr201419115ad.30.1742834760680; Mon, 24
 Mar 2025 09:46:00 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:45:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324164543.62574-1-irogers@google.com>
Subject: [PATCH v6 0/2] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Content-Type: text/plain; charset="UTF-8"

At the RISC-V summit the topic of avoiding event data being in the
RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
events being the priority when no PMU is provided so that legacy
events maybe supported via json. Originally Mark Rutland also
expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
M? processors, but James Clark more recently tested this and believes
the driver issues there may not have existed or have been resolved. In
any case, it is inconsistent that with a PMU event names avoid legacy
encodings, but when wildcarding PMUs (ie without a PMU with the event
name) the legacy encodings have priority.

The patch doing this work was reverted in a v6.10 release candidate
as, even though the patch was posted for weeks and had been on
linux-next for weeks without issue, Linus was in the habit of using
explicit legacy events with unsupported precision options on his
Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
where ARM decided to call the events bus_cycles and cycles, the latter
being also a legacy event name. ARM haven't renamed the cycles event
to a more consistent cpu_cycles and avoided the problem. With these
changes the problematic event will now be skipped, a large warning
produced, and perf record will continue for the other PMU events. This
solution was proposed by Arnaldo.

v6: Rebase of v5 (dropping already merged patches):
    https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@google.com/
    that unusually had an RFC posted for it:
    https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
    Note, this patch conflicts/contradicts:
    https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
    that I posted so that we could either consistently prioritize
    sysfs/json (these patches) or legacy events (the other
    patches). That lack of event printing and encoding inconsistency
    is most prominent in the encoding of events like "instructions"
    which on hybrid are reported as "cpu_core/instructions/" but
    "instructions" before these patches gets a legacy encoding while
    "cpu_core/instructions/" gets a sysfs/json encoding. These patches
    make "instructions" always get a sysfs/json encoding while the
    alternate patches make it always get a legacy encoding.

v5: Follow Namhyung's suggestion and ignore the case where command
    line dummy events fail to open alongside other events that all
    fail to open. Note, the Tested-by tags are left on the series as
    v4 and v5 were changing an error case that doesn't occur in
    testing but was manually tested by myself.

v4: Rework the no events opening change from v3 to make it handle
    multiple dummy events. Sadly an evlist isn't empty if it just
    contains dummy events as the dummy event may be used with "perf
    record -e dummy .." as a way to determine whether permission
    issues exist. Other software events like cpu-clock would suffice
    for this, but the using dummy genie has left the bottle.

    Another problem is that we appear to have an excessive number of
    dummy events added, for example, we can likely avoid a dummy event
    and add sideband data to the original event. For auxtrace more
    dummy events may be opened too. Anyway, this has led to the
    approach taken in patch 3 where the number of dummy parsed events
    is computed. If the number of removed/failing-to-open non-dummy
    events matches the number of non-dummy events then we want to
    fail, but only if there are no parsed dummy events or if there was
    one then it must have opened. The math here is hard to read, but
    passes my manual testing.

v3: Make no events opening for perf record a failure as suggested by
    James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
    rebase.

v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
    Patra who have tested on RISC-V and ARM CPUs, including the
    problem case from before.

Ian Rogers (2):
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 47 ++++++++++++++++++---
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 4 files changed, 139 insertions(+), 70 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


