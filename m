Return-Path: <linux-kernel+bounces-255768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F29344E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0031F2244C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46A05381B;
	Wed, 17 Jul 2024 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlu7UvmG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6262947E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256459; cv=none; b=tzIo7YApqEvTDL4iLPSdrExpdGM+QNfXJJfCdPIzwwR5+kjqa+Ort/ZjWaTiGpXnWlMHtpoH0CxQiofSuCxGkU/ocCaMYDNTJ5HyOLPxQXwVIt3/iNMDamJYjDFc7jXLkAfZ+lBgvfvA6DNE9Qo2VB5j7/fgWeQmeAv/5KNlFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256459; c=relaxed/simple;
	bh=JrW8D/ojxXf0j/SIRVu/keJZ05s+oq/LzWd9Sm9U59I=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=U611kWRc+4cYxXoqBw1W0aopPB8Pcf03Bs4kJgDV6M0aq9bX5b58iGGuRrFvJl6THpt2mIZ1Fiu2hbGDgjOpvQWrsEmDTU4iyItdPlI7vulOHUWQ4fPGtTnXEYuY4W74m+1HV8UbwHASsFB8P1JCwRypR3P04Sjwzod7kvyggPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlu7UvmG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65eb8845bc6so4105027b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256456; x=1721861256; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pR5ziDZUrbtvXuAxnnNXi/ECVNOOFYw5IhaL3PqW3bc=;
        b=qlu7UvmG+I2JuCEESbZEI8zikdsD1J2fuy+tATTOfkQWEK9styyxhHGc80mhd28hGF
         qaaAifhozibOkGhNKXQrDUpqZTLgK5pWfDDI/HivJ6aRrzfoycKkfx2YYqaN5BEi7WUT
         dkoeyp7ZGiFZSRJmrTHfry7Vi6TFR0azEjHWOLlPHI5pc4xllVNP9Bz6jEbNeoC563lM
         m1rHp7MgdoEAqcUxTTihUG9HcXtXrp7nYrFmSHvKHz6nEGXOfpJ9P17iSh1U2p2V5qOy
         0umSSDRfmQz6gR90jmQhxQPe2OgV3Fl7eVmzMUChwDIeiQio11DVUorKhNdojO6H4v7y
         L7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256456; x=1721861256;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pR5ziDZUrbtvXuAxnnNXi/ECVNOOFYw5IhaL3PqW3bc=;
        b=nH9SIWFOiewdvmFOEu7SFhPW2o8OD6XE58Sdd5iHKimjXH6+7nJ6W1tZHOWWgOxLM4
         wCmXX62b7LKVB4adnx5hgLY/q3syG9opNpSRtS85aDn/3l+wkEojjk+fI9Lnp18yOBWq
         +/xQZoc9dyxLNRX3PBRrU9o2pli+0DlwnNN8r1SdHZuPfY3aC5EXNUEPIGid0pAzqZNt
         pW2wpnGw8Y/18MhNv47qThjFj6+3IMKkWoHAhCkLhhUQyl3huVjwUsJ4NS8cGtMdmoiA
         gnz+LOzpfJz/85T/ekglC1ubMKvSyikV0beWbLG2u0Sf3EgDnAfqeM0UwF1eCFFWxPaj
         5/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXIhBn0W20zZ4Znbn+CuCm4ZKotBTGQyAN6yLauFxAoDGAVEWTKqVb04QBWMdsiDaS98lAb7cqliw8Wt5GKcWaedmDgIqzTkcbIAZQ3
X-Gm-Message-State: AOJu0Yzj+n7B0P3GcAP4JbDyM8+xDj8A0nNh49YwnuptbU9E9GTqwUZz
	qzunvWxz7XZL2DrhuaUJTWGzbzMj+5vT2eNS4b7vvRERL3it2g/hGo/7LzV3PynqHxncaOaZA29
	tIv1OPg==
X-Google-Smtp-Source: AGHT+IFLybgLrLOsOM0ierUBa3tUykoM2MDdu9F5Fmoe0eKzh6IXK2QnVCT/xdZ4Oztpr3BmZVt4vE6ZnMQK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:39b:b0:62d:a29:537e with SMTP id
 00721157ae682-666037ff9bcmr772777b3.4.1721256455917; Wed, 17 Jul 2024
 15:47:35 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:26 -0700
Message-Id: <20240717224732.1465438-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 0/6] Add support for sysfs event.cpus and cpu event term
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
cpu event term allowing events to have differing CPUs. This was adding
in order to test the parsing and map propagation for the sysfs case.

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
 tools/perf/Documentation/perf-list.txt        |   7 +
 tools/perf/util/evsel_config.h                |   1 +
 tools/perf/util/parse-events.c                | 156 ++++++++++++------
 tools/perf/util/parse-events.h                |   3 +-
 tools/perf/util/parse-events.l                |   1 +
 tools/perf/util/pmu.c                         |  92 ++++++++---
 tools/perf/util/pmu.h                         |   1 +
 10 files changed, 213 insertions(+), 74 deletions(-)

-- 
2.45.2.1089.g2a221341d9-goog


