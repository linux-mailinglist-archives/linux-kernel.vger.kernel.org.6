Return-Path: <linux-kernel+bounces-340625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC49875FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584B51C24D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179551531EF;
	Thu, 26 Sep 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovUvq+YB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BD14D70A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362248; cv=none; b=gOHnslVQ3DhzIKQJURMKmlQ8lpvqA2FZLrQYsvx8/YyOYyehtYnrYEX49Lm0B6WRSIMIJhVeAOUsL8EFZBKG2y637TvRmLjRaFYyffJAa/RHrPDanovu1MxF7GpmO308j3KLyCArJNLEa+BOPraSO8H0C3GxvWUQkMzTOYVUSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362248; c=relaxed/simple;
	bh=Qr+FNYhdDxrWM0dGo1ZIRGCjHDEeDYe5FyP2FgF9ceQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFba6aDfA0mcdKAypWZ9h6nVrLeXDDQAp+szgAqpTAvDap4xdefGOXC1maYictUaFYOmDeZY5p92p+q/1R9H3WKzEpQ+mz1kIzdcE5dsZAry54FnS427727L0FmeQGiaz1/DuRu2IRdpXsR4pebLVtH9Y/6qwVO6pX8FHNqLIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovUvq+YB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so148329566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727362245; x=1727967045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODdlKFq2yo+wpxcR2RtzNa0ArGaQotdno3xb1lEd+xc=;
        b=ovUvq+YBqJTdjGdUndD2ydyg4PdhaFNpNN4+Y1EuGYVlEGL9w839p+4WKd0TvPVJ5E
         76zE9txM++Fnz0ZIWGKSRkG1RrK9jTXe3jxY6HewrjjEqyWlFWbX9qWnru6fwH3jLDjk
         hTQZHWrx6oD1BeJSmJLF7W5yk5B19Cc0iKRwCyqvibSWVkngBvkDyJAVX0dYYg3eecmy
         8a2ZHyR0Fbo+/zzKzGaFqYIHECnwmD8OoNdUnFzXr7TlIoU2NgepQmuATqAiL7n7SmiG
         nZehImcZgK7fLCNIYK889vfOjYRdL5DyceVTq1mu/1AOzXVgw4ndWNV/u1hWouAg5/Qg
         rH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362245; x=1727967045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODdlKFq2yo+wpxcR2RtzNa0ArGaQotdno3xb1lEd+xc=;
        b=jJy5Jmk3BOwwAS4NLIvvqpjA/lBjdsBiCamnVK8gZOY0pkT4MkAMvaJSqTG977td3+
         ckk8bdU+cs+rmLuIvJJWEQTwR/uMWfxcDzRKZkxRhAdaOaahy0i6hMYuwK6qiIkW9gyK
         PN3K7D3Ef6r+1tg3A7bI/vKdN+pQvdEzxORY3Lg+J5yMdIFysyzFl/KpQycUlzs5SnBl
         etLZIwGII71yjA2AOrYy31BDeicgUzz+8nDZvv/MH93u3vtvYrNfOQQWEtmr7+Uuhn1Y
         cqjlFtVoAFR9UgctVOqBQeqlZht7RgECY2dGs/HUP0kGDnVKJEOOBYUG4XB3T4jNko36
         1gtg==
X-Forwarded-Encrypted: i=1; AJvYcCXwjtujQm5jjhZ+Xr+LYGqhJ5nHA/K0NhDUPU7zoriYj8W9LLCkbNNyRL62i0hMphpbtFf+AtX5s+3JbXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqBjGvWZIWrfAbLcrOXqToeokIP2o4Hj9T20tVrA8Cgs++5pO
	NsWSEFgmGYh3DDzzuvW83LYzGERY0yoE6vGabcZ4u4MFHUqLBt8rXwEvbwG1/O0=
X-Google-Smtp-Source: AGHT+IGmU9ciHKtvpxRtVIFD3I+x+IdqvRKKSQEPHUiKVg12Y1sJLmKKKX1VujHonF3Ic/bxX9np9w==
X-Received: by 2002:a17:906:f58e:b0:a7a:97ca:3059 with SMTP id a640c23a62f3a-a93a03f4a83mr522030066b.34.1727362245093;
        Thu, 26 Sep 2024 07:50:45 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294833asm5589966b.98.2024.09.26.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:50:44 -0700 (PDT)
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
	Yang Li <yang.lee@linux.alibaba.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 7/7] perf test: Add a test for default perf stat command
Date: Thu, 26 Sep 2024 15:48:38 +0100
Message-Id: <20240926144851.245903-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926144851.245903-1-james.clark@linaro.org>
References: <20240926144851.245903-1-james.clark@linaro.org>
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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
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


