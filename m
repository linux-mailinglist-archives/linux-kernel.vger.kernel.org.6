Return-Path: <linux-kernel+bounces-388612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798F9B6211
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E52A1F2240D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59EB1E5733;
	Wed, 30 Oct 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nm4V7vkq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0781E572B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288412; cv=none; b=A4TDZE5Nf1BostsB7nhmq6IfUOCFVyOcTHoa/iyEDsTM2H69E8F3iswFonzGbkoDKGTpyE45XL/ahsfONOOhGTIdOaQoq5AeLycu/arqrKLwui1y8/890YtQ0z20AbG0KSYu0evFkYr+alGPfA4gYnVcbq8E519A8mSjYx/zdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288412; c=relaxed/simple;
	bh=d/FHF8pJ8v0slueq+fAHV3I8duIMdYBFQu9B+exFmco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQ+1RMKFt4NwuzbTOiSCSqrMWAGZSzSwK9C6CthOzjJyOgfpVnjg7lFwSgkp2OPKupYsuIxbEYRqfwZ+iNygrGi2KZ3g6XKUqtKlhAJtXJTAvkeY41WKsWsc1bG0q6XHV4TM0W6V+MVjWITIrs5+aW+xXb18NxrnRhLki0Y9IEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nm4V7vkq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so60625015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730288408; x=1730893208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyDWS+jYpYGuwqnSKV2ManTocBtmYRodTmjKi3UEELA=;
        b=nm4V7vkqz/KJ6faF5PW3ZmtpqNhqdp0KxWbsUharSrDJiGeaPP0IfHlbrKp40UOXtv
         amB3CzDtEZz/nNdxzX3EItE2ABeULfnS6gmbvwsO0BgVjP8RKsSZN0iaE/sax51QPsxG
         DmlC5fJlgYdn78sXXSsXxvsvAX6vMvaFx0TrD0cKWkm5Eng7lA1mFK65oof4sxKFQOm6
         sElAINEeBXTMCxnRZ7KEuyC8CehNG5oRGB6QJDMJ7zabJhEIEqA6Sz8NGCJ3U7opAxpF
         C6o4O08IDGpsS1V4AkEri4TiliwmBtv0L88m4GuLkEGWk7pVxpheybalkmUhfsg3um5B
         7CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288408; x=1730893208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyDWS+jYpYGuwqnSKV2ManTocBtmYRodTmjKi3UEELA=;
        b=dg6eryXjXKMKlroOu6ih5n6NRezfy5Egrb9q+2x+6y3ZlpQdhMv0LsbH1b6oxnkHf3
         OCg9Jmf3cjcHR6R2KllMXcMd7tv4tK7A21ZyA296my3A5fn9u///LzJhZn+b9NYQ/aNV
         DSBO0b0idCwZVXpKl0vHJY1Nsvu0K4XJTweBdTzUYWmvv8ZvdjD/kU6/Qz3qne6iF9Ex
         XkhFnhfCKqxn9e+9z7FOYMjGNDe64Kk9Bvq4DUEoLtJRuYpmkBAuApKntA8QvKd3acQ2
         3b7e4GuLC1G/UuHv3Zm05/Igg8MHh5Gk+qf6oy02ftDnNFu/m7/2sXOs4muH0FpHmXjb
         TYyw==
X-Forwarded-Encrypted: i=1; AJvYcCUNY1IGiRdFdtaKvwjFt5qWQ6ZiZ2YfC51dta2UvyAgx6Pvw54GXbVf7HdPa9Ok7i5bA42mXWHkRHFwey0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhG7PQbz+BLE5O+TWGS/l3p9Ydw0ivw5sbrrtxbiETsohkQgOF
	6ViImxAKcWJ6XckReQLwOougeDtDvMOS1TNm1OQDS+VFuCFbuzAyj5dk6WXGewU=
X-Google-Smtp-Source: AGHT+IG/EGxoba9efCvi8ShRo05h9yQcITPDgjVaGxzgq1DBbWgIiEyF8Y+mPbCexVOuxUXoAhkQdg==
X-Received: by 2002:a05:600c:1f82:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-431bb9d14afmr21602635e9.23.1730288408266;
        Wed, 30 Oct 2024 04:40:08 -0700 (PDT)
Received: from pop-os.. ([145.224.65.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca6f8sm18885045e9.39.2024.10.30.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:40:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf stat: Also hide metric-units from JSON when event didn't run
Date: Wed, 30 Oct 2024 11:39:45 +0000
Message-Id: <20241030113946.229361-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030113946.229361-1-james.clark@linaro.org>
References: <20241030113946.229361-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We decided to hide NULL metric-units rather than showing it as "(null)"
when a dependent event for a metric doesn't exist. But on hybrid systems
if the process doesn't hit a PMU you get an empty string metric unit
instead. To make it consistent change all empty strings to NULL.

Note that metric-threshold is already hidden in this case without this
change.

Where a process only runs on cpu_core and never hits cpu_atom:
Before:
 $ perf stat -j -- true
 ...
 {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : "0.000000", "metric-unit" : ""}
 {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-value" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "good"}
 ...

After:
 ...
 {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
 {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-value" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "good"}
 ...

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a5d72f4a515c..0e16eecfbad8 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -854,7 +854,8 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
-			pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);
+			pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL,
+			   /*unit=*/NULL, /*val=*/0);
 			return;
 		}
 
@@ -909,7 +910,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
 						      &out, &config->metric_events);
 	} else {
-		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/"", /*val=*/0);
+		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/NULL, /*val=*/0);
 	}
 
 	if (!config->metric_only) {
-- 
2.34.1


