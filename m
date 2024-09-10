Return-Path: <linux-kernel+bounces-323324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C0973B64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C441C24F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905C199FB3;
	Tue, 10 Sep 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEr7/BtE"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11036199FA9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981539; cv=none; b=CGcJ/scQ9bbD1s8FaTYH5MxfFRWGpOXeAVIOJxYp3kNs4TGNufipgOwwEJfdCXkQzh/QIkWw6oC8+QaF6yBHwCc+e3puHWDT/nfSEMoed8xX/dZJ+GqvcyvRoR5X/07/2+uQi+qRCj1OcWeo21q703Y62ByffudNkZiQGjqylJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981539; c=relaxed/simple;
	bh=B7L8eicaLL/uQdqZZRGKF332ltFTMFjZxuNmtoxY+qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjrubYfKtbHk1CpDDrKj8qeXPoiBTADvBD6OfFaXsTD49JX72+5Zs4FjjlcKz2aKelMC1PzTxYzbaNxcBZyVqZhkAdYlUcKBJvi5GekBVC2M6Le+Fsem5N3XVfV15EsxR1M0LBDkhXHEZn+iwOAZGR3bgRC8weXHBqKOUSUjPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEr7/BtE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c326c638so4231297f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981536; x=1726586336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzYejL55jw2kalTO5A0DRq7hhLyM8T3G+Vfejwo9sVk=;
        b=gEr7/BtE13W5sDCDX8u125oEB9fkDvvPXsLSfAqeMfWLFDS9sELGm/hWoFEhk2gyGJ
         Mrm5gubKEpHrCNNWb1a0Fh87VCIRU5yluJ4jWaz7RTPhWlLYm1SYM1jL7LOMA5I/Pxhy
         b+wYVSJHf9okd75fb1jgxAjuHljf42J4Z2eB3gCthb1EU0GVSCkuCsupTH412I5f1zna
         huWrggSs5ffDt2GFyp8TmCpQy8y6qdimvTOK+AM+zVJneZ0naKMZ15bFLlR+i6wXMxYg
         mJBbEDQiFIGgkDfQl4NcCEkVn5ltkwpZBDuS1bwx0FMTQ6CLn71Ho1ukT7mkoTyVNy8r
         qCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981536; x=1726586336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzYejL55jw2kalTO5A0DRq7hhLyM8T3G+Vfejwo9sVk=;
        b=l59V1rzqS9nYfBoWYbAleHTNB/lKd0aGjw99ZYy0T5m4+yrbQ4tldvtYljfgouT8tV
         wHJb6QUEoq1F6UJZXaF6G+Chz/8KXj5Rk431ug3rqnrb/IjV9KYdjLKiJldZejZ+98Rt
         AoCgyNuK/K6o0Tw7yEv3rgJ/fcjyVgh1w77ffpIhEl5g0bQfXFHU/ZjjIRiBhmqd1iQT
         QZ/jO8a1XIndepxY8EJZFU80XPkXr8aWZ2IdNMRxl7BaMmfMQh5lbsDIzkoTCG9yXdGa
         oF183mTcnfdFHwM+wEquAP5jhnqeDrU1Wy6tSH0VdZBDC+kvVYRhlhmtB/XMav0Kp5/r
         /uTg==
X-Forwarded-Encrypted: i=1; AJvYcCU+v1nO7ZGymcALhTYGUtEbKlwg1xLlBuL4p7+MEEMZTzjLUoCRDOJGDwEdUsB+r+RQOGcwER0eGcV9dcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPqSORTtuKuNSOd+zCbqHPlLdgRpReqiEefcGAa2mkEehrq/6
	smkX6o3auGpug10uAp5bbDRskCCI6RJCbCFeuyeTYLAYBkq/yxHXZstsIBgT7yM=
X-Google-Smtp-Source: AGHT+IHy/RhwX57CcCqc82tipU7Ic/6+Q/to0vq5e7VGq8SEkdeQH7tu0qUqClXsdQ0xyoyauIPQiA==
X-Received: by 2002:a05:6000:d05:b0:374:b399:ad6e with SMTP id ffacd0b85a97d-378895f20damr9927699f8f.35.1725981536253;
        Tue, 10 Sep 2024 08:18:56 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:18:55 -0700 (PDT)
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/7] perf test: Add a test for default perf stat command
Date: Tue, 10 Sep 2024 16:16:25 +0100
Message-Id: <20240910151640.907359-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910151640.907359-1-james.clark@linaro.org>
References: <20240910151640.907359-1-james.clark@linaro.org>
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


