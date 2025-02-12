Return-Path: <linux-kernel+bounces-511096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A14BA325CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1354D1688A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194C20B21F;
	Wed, 12 Feb 2025 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+acD+PF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A82080E6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363082; cv=none; b=XXBO4MpWCRBZJi888gCgx28W9z7NsBgIiHPmAjsQ4bAKdy+CB1LUVAwXdZokejuf8KdSJA48GrZs+BBha82QtzuhRV/2TJO/VBJQbTrFUV6eJeWdEvu3rCBwAYzsDdx98s0eQEQwUj0HBnYiqx4baMvtxCP8tMfPucqsXcVxuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363082; c=relaxed/simple;
	bh=Jj5P7lsHwRRACyRdpFpJidnBldboUVSsGulb+KW5U8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lt2+iGKbCDFj0MjcPMIMpfR9weGfVwJOI+vUt16joD4qgvQ5y26QBuhD32YWdFMPYIOn3DC6GEdT3NaslVvj7wOHiA2wCPKejp8LeOi8j/Wa46Gav9esL5i8Zaf611/ZRkrcQ1hBBpb2VIHVgGHi2kd4LrVd0dEzDui7wcVvjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+acD+PF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dc6d9b292so3002870f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739363078; x=1739967878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5dUatvfzva4ZYttIH7CzveR/pu2c86Tt8pcZSDn9PI=;
        b=C+acD+PFVYJ+3arHmrXYE/HTSFPsox4GB97uD6bAmO/iqifBcAXE+1gx52F1epmZnl
         QG86fvQHW4/pCYdJD8yS9yScahhIKEaa3KT8EX4pO1AuFFK39f9Wki6DJOYFmmm9cDJS
         04s7ShnmQZ++PfvBeIImtl4moXFmuyp4JcfDOc/ftJ78GTEHUX3C5T+L6X45XodAA43c
         +hKxPzm+NcsZiW1xpNz5kA1zgsUAYA4c7HKWU2nXkCDDOUfrmooQlL9FfZkdVuOMh5xs
         1HtTT3FHYBDl/QqMfUhpx3ksIyNeYYanL5njFHzC0/BgJV/riJmXErvFUly7eFGGwDZe
         WNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363078; x=1739967878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5dUatvfzva4ZYttIH7CzveR/pu2c86Tt8pcZSDn9PI=;
        b=htuJMs9Ar+vwBNJof++0/4X3TJoTegmBW5Elt6j0fUUi9/kFFX5JFOahUoj79A/Atg
         PT90Qt4KKnX9SYBPWU/6mTnyxDxaWf+qp5PiCUBQIcvilVjtiFxI43HkkrCv98JUr76B
         t8e83B5De1cQB7y+twFyL8S12xth2XnqftViFl1n9QB1ZdBbVA8h9ueCW2bgybGgEzlh
         7RSZpj0myiIQdRCS/dYq7zq9S0MB1ZoYyKIgiNcZspcR5KbcOPqSHqy2Hj9tBBVmPC9b
         +iGFCgcSzx4r7c8IVvZFHN5ldJ/NFMBokN9zyCy12O9a5T3wMsf1nG/0Pu51yym05oKc
         iexQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEv+bOvHcXdQAqeiXHglz1PP0hD0BJMAHpKSpBC+bKsA7A/uy8X1uwjCpI9L8jC7HC8XtLugm8vjHZhIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwc4BUfhPK0ZKuN7eLbUnoVm8VMX/i52sgGYPj2+9lgyd5YGOw
	4ux/UnPhHCKv8Wsb5BjdWN5tciNkMWpWXsbss++tsHjvboeb7ZJwB9Jzw4gDmo4OVHrvBf+WsYI
	JIKQ=
X-Gm-Gg: ASbGncvb7bw32qAI8kn8iTXYzSlK6gA6bE/T+JX5ziANrHC9aKtHosjluxIJhxb6IvI
	hvfutQPYmrNWSud8Wdr0+qIbJyxo0diP678MRqjSWE0gzzH4Bx7shzXS2bj68FQfOmSwYsqY+4/
	4uQ0qK1NeYC0YhNSH9GHqpcU70pfuclwL11eCeEd8/pRHJHQiP0lULyo2N0cNCfuvXG5yUdEyim
	tZmoJW/BsMEscSZodxzeWCbg0MIb5uPuOe7EsAsf1TzZo6Ytc9kPRoTo8W24lGHGhiD3Mt90uXI
	VAxovZQVo3hyF2U=
X-Google-Smtp-Source: AGHT+IHURBlQWis9afi1mL83V75xfgS+gg8SDfHCPxDC8+IXutihLiENYqrtgOOvxV5P7aw+tiwlCw==
X-Received: by 2002:a05:6000:144e:b0:38d:dcc4:1dcb with SMTP id ffacd0b85a97d-38dea3c42e9mr2448660f8f.2.1739363078483;
        Wed, 12 Feb 2025 04:24:38 -0800 (PST)
Received: from pop-os.. ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38ddbfbb4ffsm9287276f8f.94.2025.02.12.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:24:38 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: Robin.Murphy@arm.com,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
Date: Wed, 12 Feb 2025 12:24:12 +0000
Message-Id: <20250212122413.1184503-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy hybrid events have attr.type == PERF_TYPE_HARDWARE, so they look
like plain legacy events if we only look at attr.type. But legacy events
should still be uniquified if they were opened on a non-legacy PMU.
Previously we looked at the PMU type to determine legacy vs hybrid
events here so revert this particular check to how it was before the
linked fixes commit.

counter->pmu doesn't need to be null checked twice, in fact it is
required for any kind of uniquification so make that a separate check.

This restores PMU names on hybrid systems and also changes "perf stat
metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
test was gated on "cycles" appearing alone which doesn't happen on
here.

Before:

  $ perf stat -- true
  ...
     <not counted>      instructions:u                           (0.00%)
           162,536      instructions:u            # 0.58  insn per cycle
  ...

After:

 $ perf stat -- true
 ...
     <not counted>      cpu_atom/instructions/u                  (0.00%)
           162,541      cpu_core/instructions/u   # 0.62  insn per cycle
 ...

Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e65c7e9f15d1..eae34ba95f59 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
 		return;
 	}
 
-	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
+	if (!counter->pmu) {
+		/* evsel__uniquify_counter() uses counter->pmu for the name */
+		return;
+	}
+
+	if (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW) {
 		/* Legacy event, don't uniquify. */
 		return;
 	}
 
-	if (counter->pmu && counter->pmu->is_core &&
+	if (counter->pmu->is_core &&
 	    counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
 		/* A sysfs or json event replacing a legacy event, don't uniquify. */
 		return;
-- 
2.34.1


