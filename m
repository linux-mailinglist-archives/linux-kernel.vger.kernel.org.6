Return-Path: <linux-kernel+bounces-255801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72D934561
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F6B282F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F5139F;
	Thu, 18 Jul 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpnoHAmd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93661195
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262643; cv=none; b=bI2R3Rqw0Pkrdl+9f4FpDRKn1SAvpUSea9Crxq6/30NJTnWhO7JRNfBhZWUHh4G44ny4Lywf5yYXXhoBJd3+drGfKPf74aCheRgKfFDcJKERTiFTRkxAR61YHj7VctjXkNEBVurOr57cAXaGnaD9DQDM0Z+97Ir3Pp+iLmOUuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262643; c=relaxed/simple;
	bh=3MmR6WYn5H6j6OnCbe2YIZN1LUz/9RtidsFDq6cezCA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZxP+AKYzUQxpMEOq6riG+MQ7AJvAEkZpv4mEEQZQfP/njQKkejvjBT32igDsWTyD64KaiAH3XMSraj58GcDfVUsDLfAGmdJ1FJYPjcWppF4NRFmxZbCKR/MmBhED6zMAE7ap8x4vGcmRJYmnMPEQunuGqSOvOe78VuccOnTthGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpnoHAmd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664c185a606so6033957b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262640; x=1721867440; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6MIUEZAXr9ARz/GejKmT/R1O9t1/kgujIZ/pqahQfTY=;
        b=HpnoHAmdEZNnH8FktsKDPLDAGM7uzGnOiB9eFoRubhhuXcqE6t3rZfuNtMyLlSP1NK
         aKKS74uJW3/mPhxlsYE6iaepB9GrHvBmJj6hupYEl513dUFK923hkQbjiP2ZMEVDqyWa
         oTLcn9dH4wksbHK5shwt+/16HDgKRsNvSVK3VIEKWLkgeLk6vvU0/tupxpUhYyvVGSZq
         h7oHSPwtzXpAgp2r9Y1ptUJhO2mxkicw/vz09ZscSF07Ew04o0TaE/9qDPHBmzV0TRwF
         eJ70Mm6p4Wm8LJYsz8XkHkPqp3c3MDOFhdxGt5tsNIVudOqizc/bIRfTTCD4MggwlZ9Q
         Z5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262640; x=1721867440;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MIUEZAXr9ARz/GejKmT/R1O9t1/kgujIZ/pqahQfTY=;
        b=JpjZjKlgbNh3q40FpnVB1soqX8asTS+BSnNLm5cTijTiP4hDpwyrE55JSoElOnA735
         k9Jz+jVsl4GiXsouWCrJ9QCSAKoStPfh8qjiBp9UWGNrYp0jWEwaoQ7MvmYUUGdWHiYC
         JLlFvyQ2ihpMvnO0qbSkOvLzA7/c27WO3d1M+eIeEChVIE2/47q42eS18cTabT7UVn3O
         CbVA+uUPk7Vzcmhq6Ra3ThQBR2e+XFSd1lh+e+HjPxDw13rh/enpIbpMJ/SWWinW69QP
         DnmjVUjZyMj9dRGwnmcSimU8NJSl99dxwOjKDbDqoj/XlAAYKsJPvdM/I1kc3v2fDMag
         x5ig==
X-Forwarded-Encrypted: i=1; AJvYcCXI3KkJdpHIdX368d3xfKFpSbgwq5rP+2L9/676ZsWbK+ncoz7ZTAPJPdyT44jyDR7N2uKtPid7f2wXa3jwQgERw0X2P4Il9v+vAZX7
X-Gm-Message-State: AOJu0Yy/qmawyWgQ1ryfSRO10bTsaR3bNhE7/Mvev8S1StwkuSXhGpBh
	gyd0LgmAC5ma5Z/Rwp4AbZsxTOfAaY3TKD5k6iVfgqB2XSVfcZGuRLiIBAasRP4y500vp4pxl7v
	tYmtMAw==
X-Google-Smtp-Source: AGHT+IECxaYbhNd5fpP/BxbbwRLk6/tzdHS84XHPvPQhwjJd6j5KAeRS5gwXqiiEJfVrjEx+c1ogUd8pzm3z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d0:b0:dff:1070:84b7 with SMTP
 id 3f1490d57ef6-e05feb23b1bmr2077276.5.1721262640550; Wed, 17 Jul 2024
 17:30:40 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:19 -0700
Message-Id: <20240718003025.1486232-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 0/6] Add support for sysfs event.cpus and cpu event term
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

The need for a sysfs event.cpus file is discussed here:
https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
following Dhananjay Ugwekar's work on the RAPL /sys/devices/power PMU.
These changes add support for the event.cpus file in sysfs and also a
cpu event term allowing events to have differing CPUs. This was added
in order to test the parsing and map propagation for the sysfs case.

v2: Add support for multiple cpu terms on an event that are
    merged. For example, an event of "l1d-misses/cpu=4,cpu=5/" will
    now be opened on both CPU 4 and 5 rather than just CPU 4.

Ian Rogers (6):
  perf pmu: Merge boolean sysfs event option parsing
  perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event
  perf pmu: Add support for event.cpus files in sysfs
  libperf cpumap: Add ability to create CPU from a single CPU number
  perf parse-events: Set is_pmu_core for legacy hardware events
  perf parse-events: Add "cpu" term to set the CPU an event is recorded
    on

 .../sysfs-bus-event_source-devices-events     |  14 ++
 tools/lib/perf/cpumap.c                       |  10 ++
 tools/lib/perf/include/perf/cpumap.h          |   2 +
 tools/perf/Documentation/perf-list.txt        |   9 +
 tools/perf/util/evsel_config.h                |   1 +
 tools/perf/util/parse-events.c                | 162 ++++++++++++------
 tools/perf/util/parse-events.h                |   3 +-
 tools/perf/util/parse-events.l                |   1 +
 tools/perf/util/pmu.c                         |  92 +++++++---
 tools/perf/util/pmu.h                         |   1 +
 10 files changed, 221 insertions(+), 74 deletions(-)

-- 
2.45.2.1089.g2a221341d9-goog


