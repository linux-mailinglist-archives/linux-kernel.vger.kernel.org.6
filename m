Return-Path: <linux-kernel+bounces-340897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF5E9878BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F16281C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ABD1C6B4;
	Thu, 26 Sep 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD/B4Gbp"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C61494AC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373436; cv=none; b=kVUbFSUAAU+0hOIrAMjgw4HwCs7gA0P9KgpUNUrTdcShJi8A4bqhq3ffRtlkzZ0wB0d8ggpi+ykMyJctz6Uk7RoIaq5Wll58NKxlKvATA0h8mw/DizKqSEwzDTglvkDI+363lz+GGr+2Qh3CCRjcCqYp1qLB3qechsj4G/NDNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373436; c=relaxed/simple;
	bh=yQLTFAI6fm2S6WA1+4rUoCU2eC6pNpVtiygrTZySpg8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EPHKMdUm34moSOVtV9SJDeRTNCzimYIF+aEy7VHZwFUZhtSm5mZs2pX982AhP+DPAuvZ3fthagUOSL/GaokBNqUkuxSCwDEx5YLSDUglwxrf4wL36UI1Uil4gC4iFaEvfUvLEDRa4V4ikoMqToO9z6c7fofbtj0p8JVGZDhRx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lD/B4Gbp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so1874999276.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373434; x=1727978234; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0i4jjOvP6OpA7ZpA7aNGfOXmC8iMW1XimlebYcMMOw=;
        b=lD/B4GbpGLEftoTZSyU4450o5OeUq0WSByYTOK6jhW2TIvJI/eJjAMkek0yvPIgqxu
         /j/RT1+xqLfHuGBwUDbS/XO3X9+g3AVVPfT9pX5QAjV7x1d/EroeeOmv/4mavTrGjbQR
         2n+tROE8a3tgAEBCMfRhCWZc4xb76E0rcijOZkLmc7xstCW+3ghwazJd0/kdiP+2EJFP
         N4JoSGbBLXT3DIApzhyr6bn1HVmKmLwPD+fluBJkca9HcDMl1qAHqpCTY6e4kFqBlQ9R
         imVhsY5TeZiltIKHNPLdy6i9SBiTSDQQxczzwYzekqLr2IeGt5UQ0h4dyAhsg7AApxsm
         gnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373434; x=1727978234;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0i4jjOvP6OpA7ZpA7aNGfOXmC8iMW1XimlebYcMMOw=;
        b=uHjIAQ7ZfBfi69pbOsF6vfKcWzUf0/LtKmDT98DwVLV9B9YSBwduAcrtebujIH47CY
         4VAMUvNV3rUA/EElQbgMqjlqfNmKJiVtlGFDICa4FCG17c72F7MHQx8NyILe+cCFWova
         85rg5qxYOGJzy/tzwylzdm90hmxv6v75TdBijaB1O9ONqD74D2aHEsrymEXWFETHnQGQ
         hW3VqwNR/p5yQDWGSaryxIMYFYT9BqpHg7obg2PA/srpc/2Bs8mWSGvDl+HArAe88VEA
         iZwzRMWcPKsooUrmTdjn3y780atmFT9B+OEhejzhhI2SZ2FPV4Oe5VzFkYW3+5XR7ORf
         C7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCULOnuaJYjHvnix4QXg7lSmhTmnv+ntJtsqw5JTnJIJrvrXH3gQicB8kKeg7aIaX5SOKa5gXSrW4br/a+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4cSePQghlCdIyq5bfLBRrueffIQre6xAQW55p2P5C3oak7Ydr
	XrxdSyenER1EXm5EXxaURaeqJwqplASUJcNXlQfrCbINnTsQH6itsGugBYUUPGprLmkB9X154Uw
	F1rhlpw==
X-Google-Smtp-Source: AGHT+IFrKrFTKYqE8L8NRygtNLax5RL2MI+YZtF6E5IqIoKgsdCqpSLZjmvEJGFP2HwHCduugVzIY5xcDu96
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:ce4f:0:b0:e22:5bdf:39c1 with SMTP id
 3f1490d57ef6-e2604c883d4mr144276.10.1727373433466; Thu, 26 Sep 2024 10:57:13
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:57:07 -0700
Message-Id: <20240926175709.410022-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 0/2] Python generated Arm64 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.com/

v4. Tweak to build dependencies and rebase.
v3. Some minor code cleanup changes.
v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.

Ian Rogers (2):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel

 tools/perf/pmu-events/Build             |   2 +-
 tools/perf/pmu-events/amd_metrics.py    |   3 +
 tools/perf/pmu-events/arm64_metrics.py  | 149 +++++++++++++++++++++++-
 tools/perf/pmu-events/common_metrics.py |  18 +++
 tools/perf/pmu-events/intel_metrics.py  |   2 +
 5 files changed, 169 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.46.1.824.gd892dcdcdd-goog


