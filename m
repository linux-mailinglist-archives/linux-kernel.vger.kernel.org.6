Return-Path: <linux-kernel+bounces-312703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C0969A09
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEEE28430C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A91AD278;
	Tue,  3 Sep 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ruQdr/yK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC01AD25C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358938; cv=none; b=i1ao/qX3X6IaVza2bvVavXzoFtqyQlowGFm/nZNVHe5BofAIJzps4W9bk/SQP2xGgKvbnHy0igvsz7QxYSnk/9Oh/N3N9ZtgTZZ752gM+opPErMIQnQHZcWYzeV+gYs8dWkbVx6adIQWgh/i/KPAQCNN69trzXs7adtBjFnmC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358938; c=relaxed/simple;
	bh=9zOMPSCaKIlKWc42AsHnEYsvI3nEJ1h/7wDK7dHA3RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAoA37SFKdOpE+X7+zuk73jsDn1SA3LHo/QyrL3OorLcLiMjKM2lwR9ffCXejTGZuJtfGNIjs7IWRicEPQKjt4q5XZmQ0jHoPg/MM42p953z3m7Qjdf7ecvH5dwtUZQ0HrNBT/madgtKIJHvDLarDx35CxMn0TB7cD/8MBMwpXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ruQdr/yK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42c828c8863so17219065e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725358935; x=1725963735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJKJCBpUvVPcGAEYnax2qcSOD0MR4G3nPcSezle+qU4=;
        b=ruQdr/yKU0QuGV8XorD21dAEZ3d/hPbb4uYXcf0SL9rQ3h3j/v9n0jp2RHKA8GDhkX
         HvzY/iIS9Cf1d9K5wBp/xbLV1TV1KPZhT3leE7KvOtEMfOk541ns7qYA47RF0KxSt7Ut
         l2/NKkHiCV4HxSOW9wBNVknYoNkVVZHTtCZ+V8+W1uj7pjLXZhLngRyp9+1+irRiW/wW
         +UfQKHpeMGhl8g9uEJX9GGOO2j37VN2LMVN5dHwQ/bwqB2glcYgSVC6szOHcbcwMHcng
         sKE3iNtE2b2g3Yj+0/1O7QbNb4UxXpvbkDTo2QO9kNlgnAGHJhsEmXwNMiuZyzGFmx1M
         a3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358935; x=1725963735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJKJCBpUvVPcGAEYnax2qcSOD0MR4G3nPcSezle+qU4=;
        b=iNTS8Q47h69IS/Qf1Wb6L21xY0C2jK6wJMd8ehTmzgSHC0vSq6ugbF283nGKvmhAd6
         kvo+lC1SFHMcaUul1w9FyCOiuYcNJeTWEaLPOoK5tYksJVBmt+J7d/MWLzR2XdWurPeC
         ofmcJFA87tqrXQY71QVVnuHFwgun0eQ2KPEu29ulpa01bgn+65YBchNEO1p+q0swFyqW
         t8Zeuuknf1SOK2AA5eqyHq9/vAoF7hcDu2w3/hFKwoZX4Bd4tNiuEdBCSUPhsECC/plk
         qVj34/8CZhWHYPC2oxdCajeXji6lEWwH3h6p4k05qT1OhXFuGoqxC8U2l3mHsAfycDbU
         wp0g==
X-Forwarded-Encrypted: i=1; AJvYcCUCZmGAZChBdYWWxK8USUzdjmWdTWgO1MMJI6zEWFkN5h9NAN3hl4NJKE5ziNoT08zqN1QbYQ65O0ujA0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI51uKzCbf6H2eJjM0K7VXZ7uJsxIulNoiPoKL/qidcCBvOSGr
	Xlac9IF+vpmPrOThZdeWe9zYS75SlA7duPs0K112j0z0RT965tn+cHZIoxRy2EI=
X-Google-Smtp-Source: AGHT+IFgSoyyOtImdhFvpIkfkxAvYNeSg4DDCvj9dTZ/CYpAWzZrXxUx8ASLwX+TMI1prEH2Ay5XJA==
X-Received: by 2002:a05:600c:3b1b:b0:42a:a6d2:328b with SMTP id 5b1f17b1804b1-42bdc64e691mr64706745e9.30.1725358934675;
        Tue, 03 Sep 2024 03:22:14 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274ccsm168739995e9.37.2024.09.03.03.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:22:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/7] perf test: Add a test for default perf stat command
Date: Tue,  3 Sep 2024 11:19:51 +0100
Message-Id: <20240903102005.78049-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903102005.78049-1-james.clark@linaro.org>
References: <20240903102005.78049-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that one cycles event is opened for each core PMU when "perf stat"
is run without arguments.

The event line can either be output as "pmu/cycles/" or just "cycles" if
there is only one PMU. Include 2 spaces for padding in the one PMU case
to avoid matching when the word cycles is included in metric
descriptions.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/stat.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 525d0c44fdc6..5a2ca2bcf94d 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -148,6 +148,30 @@ test_cputype() {
   echo "cputype test [Success]"
 }
 
+test_hybrid() {
+  # Test the default stat command on hybrid devices opens one cycles event for
+  # each CPU type.
+  echo "hybrid test"
+
+  # Count the number of core PMUs, assume minimum of 1
+  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
+  if [ "$pmus" -lt 1 ]
+  then
+    pmus=1
+  fi
+
+  # Run default Perf stat
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
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
@@ -155,4 +179,5 @@ test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 test_cputype
+test_hybrid
 exit $err
-- 
2.34.1


