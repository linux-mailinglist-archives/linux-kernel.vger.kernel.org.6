Return-Path: <linux-kernel+bounces-340872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07AE98789C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA26B1C22987
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738215FCE5;
	Thu, 26 Sep 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcrfJlq/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B11494AC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373045; cv=none; b=la4lFdDcAf71Adjx1Z1ftzjpC/EX/Ap7uam6jd93QMtwZwIWZtCa8PXDqzv05EPduC7faxYuwZIQDHLMLDmc3Ej/+9+vCzi6rCLV/p+AT+5N0WclB9hJmMnPX3YBktTBowgr1qMO6iAQq0NMIYNEv9A/92Ve4AxJs/7cuDhinlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373045; c=relaxed/simple;
	bh=ov/TAlvdMAcCcocKl4WI6KQsu/GEvEkh2XbLm61JsHI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZdJgnJ7tRWUHzR0U7fb68x78wElmq9lhuSIg1iWfHa2R4KFA8gEGT7cChIV420ONq/vO2EChC/ZylJKkN0OxHy+TIOnjzdC74xYThk5kEU1Stb/vMzm8mQ5YBbK7LPUg5wckOEZgQjV4xuaznS6OZu8mKoK+LV4votywuyzOSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcrfJlq/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so1821185276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373043; x=1727977843; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JvSamZqIAhjdfYEY8+najrPm2eihOyHwiLOs5JRJ4Gc=;
        b=FcrfJlq/oW4a0eRILyvNfgdgRb89uaKLHvffE+oiDx/1u42hRw8go+IWrQK4LGn0Au
         n+LX25FwAhKsYApanmE6pylTox/LgV+C6zHC9jNbcB60tGFqZlKVOhzfCA+yxlG1hHsA
         Ay1+vuOqPBa2zBIfT4Wr6DXedYsNR7iNsh9sBqZJ0zXfWXiFqNvZKYx2IXrw9I/SFYVw
         D50yfDL2C1wxudDJ0Ci7hxAJzkfEG7+yop3Z2mAmkXa9BVSND4uo5brBJz5jEC0U2zA6
         9gLUixOraknHckVNcxvhVuQtYpvJZSC46tQXdz4fbP7aBeTKjpAze2cGsVHIsO7uuFWb
         oVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373043; x=1727977843;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvSamZqIAhjdfYEY8+najrPm2eihOyHwiLOs5JRJ4Gc=;
        b=Nolkn6d0DMPNXYKoCPqIxPDlmhI9yqdAz8cCoy6QK+OMVXElK7Mumj4DzdpoyYcJ1H
         Lzu3nUMy11XD1kMo3DGAK/vgHSIVFMGHtoYGzQKJ9psYPeMTD23s47YN20TlpvUBUsvY
         zTgA8nm0VxinLfupQAMytBdZKZroSWBW85mgLacTM2PKK6JPK268ehXlYCuPDXb6ZatD
         4YWYW8oIpEDGE1x7w79fVizeUg/4epNucH8GvlvCD13SpCXfT9zrdIiICYIgI+8+Yjof
         1tWU+RtoP9P8sYcRn3pci+1zspTIIJ1QsSksWsn47J6z6FybNhFpdk8fWOwuH71/1mQ9
         Bv3w==
X-Forwarded-Encrypted: i=1; AJvYcCVjb5aW9LXKpRCiTQGSnENYgHFIbHrJZ94stZ0HkE0+X0Ns2Vp8iL6D25z2FVZjsUkH9+E797GF5A6//Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSoDL0F7jcxi8+7+5KyZD0cp0tOnOWU5Sh+K4PYHV+fzlGYFYc
	KHw6UhOaOtHXJVHdI8TqyZQVsMJ1oee+pu7wSl7T4Gq5QGJagVRgYf6xJP7kfxZN2YJBjeHMcnQ
	e+IThUw==
X-Google-Smtp-Source: AGHT+IE94gNIgVpsH2JG372X3pJtADKswnMsg7TvS0BThvzWmkQiPK4fbz8enpa0vH5yOF+Hp9JB+rFTzvYS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:26cc:0:b0:e1d:7ce:4844 with SMTP id
 3f1490d57ef6-e2604b3bbd2mr342276.4.1727373043021; Thu, 26 Sep 2024 10:50:43
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:13 -0700
Message-Id: <20240926175035.408668-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 00/22] Python generated Intel metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Generate twenty sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
eleven core metrics. Add a CheckPmu function to metric to simplify
detecting the presence of hybrid PMUs in events. Metrics with
experimental events are flagged as experimental in their description.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/

v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
    minor code cleanup changes. Drop reference to merged fix for
    umasks/occ_sel in PCU events and for cstate metrics.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.

Ian Rogers (22):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
  perf jevents: Mark metrics with experimental events as experimental
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel
  perf jevents: Add mesh bandwidth saturation metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1046 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |   52 ++
 2 files changed, 1095 insertions(+), 3 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


