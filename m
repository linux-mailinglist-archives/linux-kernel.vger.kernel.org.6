Return-Path: <linux-kernel+bounces-284890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C5950674
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED215B28E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC319D063;
	Tue, 13 Aug 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VacMwHr5"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22B19B5BB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555549; cv=none; b=E8bh5bsA1KvgyLhiJ/quo73YiyY/Xdun0od+uhKchrgbsOh2cOpXzFhif+iYZS0O2BlEhq6yhroO+MvVCtTVLmTLHP9oALF8a5onY51vyYo0ivfvE2TJkc5H3qU4C/rHkMaTWu+5amMxU/CqWSBill8KwiAO8XNiiDJ/xt4wA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555549; c=relaxed/simple;
	bh=iGoL+HLhqexTWkJ+dZ/JHwY3v5/+1jHfueA9y1XMENI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRB9glKaO+Vw8j1PGkSRP82YVYbWnE4xsXCfev16L4Ej1BsMaVZf3uYAhmY8sTqzf/CQXwlBzC3K3m6DTa2FNQ/dnrJiE7ztA7bFQpViSb2+dITtX6CD73iXjchL3t9ok3XFxSuSvSclpY6PseoRkvQDqQDUaFK8ZJDLmJncWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VacMwHr5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so4846782e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555546; x=1724160346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqh5EYvMFCPE5arJzUrVuYN8olqKoGJkP7ilX3wyAGI=;
        b=VacMwHr5yxVPr+U0smjT2svEZ0i/m5fxq0A+O4pdyImIjbn8dpW2gEGKYpoGQCq3uL
         3WuOoYVm8yYckSGZmpqcR+1BfIm/M3M5qHNN9USHOZfkT/vDF/kRe+w6qzu9mcCp07XG
         Xr59FoESDgWF8Th/eOTFtOzs7mVxA7y9g6FvdswgaY4LoqRiIbEtxt8viO48cI77tc89
         /iqIftiJfLGof4G6uFJKcYPzaRsliYjPAWYREwr7UxP9onv4Az7oL+qRx0T3mH0EhgdY
         O/N5bTtC6np+CppNWvBApLGBpsLKHlxJdBzqbx29gO3qZRl6Qn/BGiq0mkbOHb3LBGan
         eSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555546; x=1724160346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqh5EYvMFCPE5arJzUrVuYN8olqKoGJkP7ilX3wyAGI=;
        b=UJ6dUezSGXlhMfr9BtEH/oaDOE+u0ujyZfITmPBi9aNDUFRz4GoPssj24boBIsegUv
         kjHtQa5JNpsjCBKwW0btOp+JqQISjiqV30NauUVJfMmLwVFFdqeU+aZc8MHdr55CfKvK
         DnimqYTn4fASjmsYWFhKitXK9EtvqzyGze10CxSKeYroVxtwdT9tAsvvWr07fxJn75Es
         CZ2Lnwz0B4lvApuBvBkxq1LL9Fvjp4sF4OzfUXuB+mysVm7+Tn7j/HNv4oxpj/RK9y+I
         oUaWJjssxdrnzjmfxmjF8L2/b0Qj2f7iJvS7/zWUGSqLkvHq007/onEAfjUuddCKab1s
         ZeTA==
X-Forwarded-Encrypted: i=1; AJvYcCUczDHSo3pWVr5egy79WV/CUIeGCNObz114Ry1sJ95gxnAXZ+k/STB6VcUvEmo2XmeU9H0mN8LNFJ+kA7YerR7CkWEewpLa5azBVeFk
X-Gm-Message-State: AOJu0YyE2lo6NbaffjrlGxjq52KJcDTXuLQGT1BKMXRlKsGtBn/sLwIo
	RygnBRuNTCHjcS8EhNWGB7xvEy+GkaO25cZsygN4F/v7YmyMMn780TAaST0ZAkI=
X-Google-Smtp-Source: AGHT+IHMLVGDigrqektOOEcKtHUBUrZ0H1yBfl4W0aPOysz0l5q5wIN+XwIpSkq9sMLm2xPQfj7tKA==
X-Received: by 2002:a05:6512:2348:b0:52c:e0e1:9ae3 with SMTP id 2adb3069b0e04-53213694527mr2503106e87.57.1723555546132;
        Tue, 13 Aug 2024 06:25:46 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ze Gao <zegao2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/7] perf test: Add a test for default perf stat command
Date: Tue, 13 Aug 2024 14:23:15 +0100
Message-Id: <20240813132323.98728-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
References: <20240813132323.98728-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that one cycles event is opened for each core PMU when "perf stat"
is run without arguments.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/stat.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 525d0c44fdc6..7118cfc37f48 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -148,6 +148,26 @@ test_cputype() {
   echo "cputype test [Success]"
 }
 
+test_hybrid() {
+  # Test the default stat command on hybrid devices opens one cycles event for
+  # each CPU type.
+  echo "hybrid test"
+
+  # Count the number of core PMUs
+  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
+
+  # Run default Perf stat
+  cycles_events=$(perf stat -- true 2>&1 | grep "cycles" | wc -l)
+
+  if [ "$pmus" -ne "$cycles_events" ]
+  then
+    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
+    err=1
+    return
+  fi
+  echo "hybrid test [Success]"
+}
+
 test_default_stat
 test_stat_record_report
 test_stat_record_script
@@ -155,4 +175,5 @@ test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 test_cputype
+test_hybrid
 exit $err
-- 
2.34.1


