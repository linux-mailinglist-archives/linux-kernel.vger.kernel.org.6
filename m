Return-Path: <linux-kernel+bounces-406950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75D9C6690
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E4AB279ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DFB22612;
	Wed, 13 Nov 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICOc/ztT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A30208A7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460806; cv=none; b=I2dRnIFYrAash1lflDsKiJvhfOgRlyKmOLPLFQRsfq7xARSpxVVrQzv3gYfb6SB9gwtKlMLbnDkQkENjEEPzhgNnGrqMYXbc7Zpg6kBSisxqGOH6HjPxG5N5vmhkFgCPNkIt9WWTeIli/SmBsR0WQXJKyFvLxcudiT43yACe5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460806; c=relaxed/simple;
	bh=27n8L5sWSPJhAE2JEG3O/r5G40z8Xit8zaf4tomXVDQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=V3ePPXJjU729HzgACcb6vEIpz93Vg1iqKOtTSHgvWPnf6a0ED3eKEmPdudSMeIbm1KTQWey8uqAlwwQclwWg16pgV77xQJBV7vv8u+6PYEwjEFA5mb2jGHJ59JJEcqhB6YwhAl/BqMxnl4c6+kFoacWjszffiOwnNM9pyTJQ27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICOc/ztT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea82a5480fso114529307b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731460804; x=1732065604; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NiQczml56JgVVMWTkxc0gHOxNZYXXQnLIMolkM8qQ3I=;
        b=ICOc/ztTNpIrODtKBrAVLrJhfnlZPJTOnmB4d45BOCzasHlmAQCFgl0ZB0/V5JETW7
         xnaA7HFw7lNiRpH65/Yzs8ea5WxuSud5v4Fe7/vJgoTWPLv+wpn2rkLpf9SBQGBQnMuC
         NteHPDbygICN6a9V7raXXmumWso5vlStSsqUd/VHkCqxq66ZAUWIzuo9yRe5zP1M/PLX
         97ORNmZDn9w1uKYL4Go7UUOPXBXyaNChVwhvopGU4Z8adLO0kwS4pBDmc46Rn6yl93jd
         9AVx7O7snLKFTa9L6o6FuR5nkQdKa8Xb/aLtwYwM6qFuLhMs0bG8h8wg6Zr2dECXg4AM
         ASiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460804; x=1732065604;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NiQczml56JgVVMWTkxc0gHOxNZYXXQnLIMolkM8qQ3I=;
        b=xNHkcBAnkfgAFbatY5dVa/zYbsMzaivGMGkPAv7hISSl+ZqY531+WNv7teflVi1c2L
         cDb7UAEZhx9cTvSyPBsez1P1STZfaGYeT6vCDF4JNbRtWmpxWwhGCfzP7JRDEp6uFiE3
         zYg5OIw+nKnegCtVYiCi2m+ZJRTwq1ZtVqnUKNGvWK7NgeDEwQpgjRUlJyIh1fMr/cFf
         b+UZ1zXBNEAj7MO88mEj6O0CILTSBKdRhUI5KoBPa2vVP6sUJux3nxsjqqR5gqSENlYr
         /7AqeRK/BGnus9Ch5V+sgUdE/mMQrck3B0v48TBhVo8S5qm3H27DPypbPamZQGXRQQgI
         7VyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYIgcH4/go4WwrGGk87iXhsB6EgsI/Ud+mTQOJwBtTiI1/9O+ijI8+nplcYE+ddIFmBbF04mAAXrjan/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHWoE3eoMp29kO7hi0g5i6ifnNnV2JGwZJfvQFY6wJCeB2rt1h
	rubaB1Fns9m4DQ5O09UVlInNasfdLbwNASvQ0Vf5AZaWygpoqAWleiSEn/9/XCoZ1SstAltMzMN
	z+tS8Ig==
X-Google-Smtp-Source: AGHT+IEGILWef6FrLG2dff4ry+9/9vbZOuphjIijHW0mVc/gaalZy4aAfkn001gZ2CIKsGYePE+4YgGAkh/G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a05:690c:3688:b0:6ea:fa4:a365 with SMTP id
 00721157ae682-6eaddfec9efmr1467337b3.8.1731460803953; Tue, 12 Nov 2024
 17:20:03 -0800 (PST)
Date: Tue, 12 Nov 2024 17:19:52 -0800
Message-Id: <20241113011956.402096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v2 0/4] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
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

Two minor changes have been added to help with the error message and
to work around issues occurring with "perf stat metrics (shadow stat)
test".

The patches have only been tested on my x86 non-hybrid laptop.

v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
    Patra who have tested on RISC-V and ARM CPUs, including the
    problem case from before.

Ian Rogers (4):
  perf evsel: Add pmu_name helper
  perf stat: Fix find_stat for mixed legacy/non-legacy events
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 22 +++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 145 insertions(+), 73 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


