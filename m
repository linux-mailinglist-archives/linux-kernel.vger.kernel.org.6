Return-Path: <linux-kernel+bounces-339221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938309861A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C91DB363E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841091953BA;
	Wed, 25 Sep 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5gFFP+j"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C481741FE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273788; cv=none; b=QvM1Yeu/SnkreGiFxYjfzBoGESFFcsPIJ/1iAIdMcJfzePGD4zdBTcuOJyOEykA9IHZcjXQfOK3/x/zz5tBwJr+qOicyqtizjqi+N+CN/y+GztZ9RkwJ0tVvCJ05in0bhtU7WQV9yvF/sU0kM0OalXy7Dkxx6ODNM4npq2Z92Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273788; c=relaxed/simple;
	bh=Qr+FNYhdDxrWM0dGo1ZIRGCjHDEeDYe5FyP2FgF9ceQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwbrkyRHSdpHR3TSpGXxDJNjoA1RaKvhP2PnvZM42CiPH9+xBx7/sheYBP9Iwy3nsQ35fXPYC4bcpzEJuAP5PWXaL7iQdGo8NGYWxW+AJvftxTZWF6OVRCsvc1p+1h3CWWNtGFXcizyRdnKFuk/SPf3qzFx/9L82jXBfFOCw14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U5gFFP+j; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso1854132a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727273785; x=1727878585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODdlKFq2yo+wpxcR2RtzNa0ArGaQotdno3xb1lEd+xc=;
        b=U5gFFP+jBSSKKyXDF04x9LWzYHWmNIjn4UPipwIF3hDHZsZiyH8F4FkEIHVTTMjFyS
         1ByDuL41j3Lyt8Wa1h77PT3syi9X97Pi+L69C105rYwPXGVALZ8uCKlXfV3OqXCA6Njm
         OPei2Y2OLioNfHOs6/igIl/zHNRAQWc5+hzgPfZdcdH9Ub2+/tV9El33m6mZTVC5o5eQ
         H36iUvrcuwhienYqLy+ldkyFgDTSB6wGEm3PCWbGHJUQUeJwEx9Cy2t2eYMRgx+BWAV5
         vgFKcDZ7O41noobyaWvNC4VJ1rOgkQgghDReiZmD9drq8YsZcNk2ELALTtedPPk7YGbf
         rhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273785; x=1727878585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODdlKFq2yo+wpxcR2RtzNa0ArGaQotdno3xb1lEd+xc=;
        b=DBxmib6VT5An4a5zvD9OO4j/LlxggJOi8J/dhj0X9jjrw0/PyZRjdAc8hTmz5xqPb2
         s1rvUknAII+MW/E9TV6vlDGSggjw81TXRyCKxI3ZFBXg9ML5/sdTto6lYDCHfx5UtX2f
         2+3lrRBK3wQlSdME9aVppbeqZShAm1cJqKKHDywA/TXIobm2OQYRKUrj3W7E/oeoTs/0
         D0ln8OuNGe7USgnBQ1CRzJDyERwOz3sK8XmoAFiS9Iu3+iQvRFIFvAJfKk+ZjAt115pg
         pLM+lqdCIz4rmu2uhS2qby3uvG3WqslOrThNhzEA5o2HH/HARo5Zr9vNzhjm9CEANUmv
         NY/g==
X-Forwarded-Encrypted: i=1; AJvYcCVgreZUsQEUFtM5ZoyJZtz/ow9V3Z4DHkU9WErixfF6OwT6rvsdkkdkN1KdwKgpIPCaPHdperIi928hjMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8n0+KGFCy/6HSe7Ie0Vs/v7UCJhHBUgm632kWuzX4VB208eh
	KdogWLhhuwPiHaZAL4fiFTXAKTE98stDv7aNIcmEyobxawtwFz/BS5JmmnYOHdU=
X-Google-Smtp-Source: AGHT+IG2TxNwhu+N9jupV3mIiqoC9ylXfNDjHqjjJvslXkqzozyl4LotdvwzRG2eQ43GgUpz5d3ZJw==
X-Received: by 2002:a05:6402:35c4:b0:5c3:d8fb:df6a with SMTP id 4fb4d7f45d1cf-5c720a2e8d8mr3371349a12.14.1727273785455;
        Wed, 25 Sep 2024 07:16:25 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm1888005a12.27.2024.09.25.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:16:24 -0700 (PDT)
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
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/7] perf test: Add a test for default perf stat command
Date: Wed, 25 Sep 2024 15:13:45 +0100
Message-Id: <20240925141357.1033087-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925141357.1033087-1-james.clark@linaro.org>
References: <20240925141357.1033087-1-james.clark@linaro.org>
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


