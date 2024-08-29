Return-Path: <linux-kernel+bounces-307160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A91396495A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D0B28516D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E571B252C;
	Thu, 29 Aug 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMHVrK1W"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3A1B1429
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943735; cv=none; b=tv2xHZ1lXNNN/LyToEyKd6tK05JpRnFf6mC5j7atMBPqss2aM2r1hPI+yRAo1KpGYQhFyYSbQvheE9lTRR6OmY6Rv69pEAXucn+CW8E15tkAqIR4JYf0A4dr7X8m8COgiIgCLCD6PfEajE80mPUHYDGD7KWG20Cj/dLE3iNNMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943735; c=relaxed/simple;
	bh=zgEgmrdD0ptR2rv9IaNbtPHc6vf0nOiTzwH2GpRCEzQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cC+RHe3hExRcsj4hex6+rx6R+gP/3bGAucQsWRPHDTSEiLlpBeDRgorGb4Bm9B5cXfQCDt7r4aqTFTlmIXK+1sTHEsYObPzvbQhl5iDd+hsKk2uyUdq84PEGcQQEb2F+o/pr3sSnqWn9evgDG0ImUB14+OsNE8UfE7Nr2/z2seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMHVrK1W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b2822668c2so15417357b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943733; x=1725548533; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dluq5P0RLumNyO/9SBujDaYG7Xf4enGWH7djPxvSwQE=;
        b=NMHVrK1WxA5xHhkCsD8bF1dpr/PGQeDx1x9OlcNiTReOxJ7k4NxdCHggdXAVLMHsi6
         ExF4mFfbZOoRCbLOZMhMBCox1gpY3/uofZ21yBTyDQONKXER0J14lH/9J+JC2hKxV0Dc
         yHG7wOvRSFCVILOpdsXEYhKzmiaQWUypZ1AhoXGeV2+8jWrkZ4VXaJwnNHS9NdHy/HSF
         UIHrB4kP24fmgxtjICZs0CRI0teQZIXOsRjbK/fNepH6m7EgPXVweUvvk1Os0hbQ66Ip
         o0fvnfTLd2nw9b4Zfo8f3mzkRfHKPXwH1c/tBZzEWU8ZllbMXRSf3betwQuF7cuT0j7e
         fO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943733; x=1725548533;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dluq5P0RLumNyO/9SBujDaYG7Xf4enGWH7djPxvSwQE=;
        b=Exj5YWGYaNzwe5VQKbYkG5NgJZG2s5yNWfkNwDm+7VppFoGML1Xzy5zLaUWy2XfRwX
         uO9JBZi9UrYb2IFV4WxMOwobWDOLN0KeB+aKs8bpQ+R2kDwXwgMZarZiLTMacGVRvc0+
         MVy/bKvW+I+lukHM40QAR8fSWxY1Rst7X2fS0o/zQdEww1ZdRRzelY8y3PSf4TD5ylHk
         aVrWG65qubxeHi2ZhXmKbiEdR6LY4RE6mqKGwImo8mMftt4TQM8dQz4iSPJWIsf0BP3O
         69Mx/WZXKI9uvVSWkjvYqLw5mPYZbsgiuE5KK1mWBGowSzCtNimvOb4beVqK1K1GGBvD
         C+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGh+y34epuyKiZ9BL52V3tPFoSG8HuZVkceH+RL6dsqJIbf6O3XLM79Um90UmiYHcubRwqiEmLUi/AlrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQTKA9n015uqAFBC3xoMaQESL9P5oUxOiP7pTMUXCiUs1YcW6
	LG46Am3dKlhveDywvvgTNI955fyJvSMwiC1L4wvTI8QTgUBfnW2j+RHH4pDzU1tMyi/KIADaAov
	6Tv4GCQ==
X-Google-Smtp-Source: AGHT+IEdQzNDjrLSj8WCqHhsyY9AarRDhFOz9K/cT4ZO+HLVQ56DRWKoceVvIf15U6oWf+LD8VSWetf46MRm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a81:d10b:0:b0:6ad:feb0:d010 with SMTP id
 00721157ae682-6d2e94d0921mr376307b3.6.1724943733046; Thu, 29 Aug 2024
 08:02:13 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:47 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 1/8] perf report: Name events in stats for pipe mode
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In stats mode PERF_RECORD_EVENT_UPDATE isn't being handled meaning the
evsels aren't named when handling pipe mode output.

Before:
```
$ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -i -
...
Aggregated stats:
           TOTAL events:      23358
            COMM events:       2608  (11.2%)
            EXIT events:          1  ( 0.0%)
            FORK events:       2607  (11.2%)
          SAMPLE events:        174  ( 0.7%)
           MMAP2 events:      17936  (76.8%)
            ATTR events:          2  ( 0.0%)
  FINISHED_ROUND events:          2  ( 0.0%)
        ID_INDEX events:          1  ( 0.0%)
      THREAD_MAP events:          1  ( 0.0%)
         CPU_MAP events:          1  ( 0.0%)
    EVENT_UPDATE events:          3  ( 0.0%)
       TIME_CONV events:          1  ( 0.0%)
         FEATURE events:         20  ( 0.1%)
   FINISHED_INIT events:          1  ( 0.0%)
raw 0xc0 stats:
          SAMPLE events:        174
```

After:
```
$ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -i -
...
Aggregated stats:
           TOTAL events:      23742
            COMM events:       2620  (11.0%)
            EXIT events:          2  ( 0.0%)
            FORK events:       2619  (11.0%)
          SAMPLE events:        165  ( 0.7%)
           MMAP2 events:      18304  (77.1%)
            ATTR events:          2  ( 0.0%)
  FINISHED_ROUND events:          2  ( 0.0%)
        ID_INDEX events:          1  ( 0.0%)
      THREAD_MAP events:          1  ( 0.0%)
         CPU_MAP events:          1  ( 0.0%)
    EVENT_UPDATE events:          3  ( 0.0%)
       TIME_CONV events:          1  ( 0.0%)
         FEATURE events:         20  ( 0.1%)
   FINISHED_INIT events:          1  ( 0.0%)
inst_retired.any stats:
          SAMPLE events:        165
```

This makes the pipe output match the regular output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This bug pre-dates commit 113f614c6dd0 ("perf report: Use
perf_tool__init()")
---
 tools/perf/builtin-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1643113616f4..5c21ca33ca08 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -811,6 +811,7 @@ static void stats_setup(struct report *rep)
 	rep->tool.attr = process_attr;
 	rep->tool.sample = count_sample_event;
 	rep->tool.lost_samples = count_lost_samples_event;
+	rep->tool.event_update = perf_event__process_event_update;
 	rep->tool.no_warn = true;
 }
 
-- 
2.46.0.295.g3b9ea8a38a-goog


