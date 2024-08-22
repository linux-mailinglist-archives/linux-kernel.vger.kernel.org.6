Return-Path: <linux-kernel+bounces-297354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE795B699
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AA4B2713F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9601CB30D;
	Thu, 22 Aug 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3GyC6hc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D661C944B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333266; cv=none; b=DJkAApaxAc47uAE8NvGLUAAAm1C+PMyv6WnK3YZdzKkrRAXMDkvBj0rHIKyQlo0JlTqmqDEb2x99jHmFFRepupuIJq/JF83YxaMADf2ydteeZoU9VqdypmrUqdM1KUCaJ+q2ezOyqDOjCw1H3OEsBJ2Vywm1fG0l0PTgFVwFAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333266; c=relaxed/simple;
	bh=iJebi4RnGEDb/WDnZ9Fx1JV2iX2h8srqqUl2h1UV8Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmSzmtdTl4+Savlg2RobXyretcZseDTT8c25PEzwxJYC/ZifVRKlXw2YlWmmGurKl5oUPSGrcsFXt98tSc9C+b0fcONH/js/sHye6qxT8jAnoaG1VWLb5RmGGFxCnTRwKev7d0L5q345PgzgMaHkQZOHJfOCX8u7Z2HJbg25Jc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3GyC6hc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533461323cdso976331e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333262; x=1724938062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il04epHFd9BrsJtGAU8mELFSezcE7nnWBSPUsdUkN8I=;
        b=G3GyC6hcbnEssqlDyR9M84m/jelk+8+uWaOuDM3XXcP2ARRbmVgvmmQgfiXQajh/i8
         Egze09BNNFOPbxshSnAX6uC+nubYlWtxcR7QXvUnpfPYq+ygFMec6Y0hwHHLWU7UwAzS
         SbSC2rmr9Nn0UCwG80sge7H43BcG01fpxRfRxV5xXGHe2kqgkx3J6He3Ewq7dELpm3w+
         3S51bV6h+6N4k7a+PtNRg0sEnq5/KGeUd9l7cV8oZgDmFD1Yucp26cq71Lu48kBayQ9o
         c37hv1yN2RqLtstQ57Jr/H0bLcAxLK6xk+hCmg7ayL6/+fsEChhWT63xswh8zyv7qtJG
         AE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333262; x=1724938062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il04epHFd9BrsJtGAU8mELFSezcE7nnWBSPUsdUkN8I=;
        b=t3K9LI63RqcUNgv3jEP4sVeOmIGsuIycHupRlKd0M9+teODU3xzIxVsZ66h9NtE/b4
         GRgfiWBkYrYbLMtZ7ssX2qdhLQxS5i8raR+QyJjcOACz//m3R5KTvFNGg4bA0KglMldi
         a1k1EFkJXemhxjkZN7tpcnIjMy+pzHASSr+l2Y1pEmZAQGm0AfilrlxpGIBBH4MPnD6z
         pHlLAynTQVAdRwO5vK1ljG8/TO8cUeQw5y8Yl5F/OaoBd1FCedkWgqB7R0gbZwrqfhm8
         zbpN7j+jXxMl5XFj4vv9/bZ+UVjfSwoYHD6W6rXCQ59iYgFyGQDS3Oxdlt1+6h8YzV0v
         TCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhOxzZLOoCybVj0H1BGaIfj2sZ4Il6Bq6LkMZYCMZNFAr5BvyedpxdQaYm+pxieoPwpWVArzl+VwKuFTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaG1v5C3TBORifp/O9rOsE96RbHAP+sWgq1CvQmsXsv0LXxXc+
	nZym+5dVjhBFqjRV9AbaMwJw5n7ZAZuHD+toOh9/Te0u4bMApJc2PCCyuNRrr20=
X-Google-Smtp-Source: AGHT+IFQvEOEE4/tecvA3hEXgG5+UjX0Fvn05z8om5CzNVnFbMlGxCn50hrf7STgDD8q/iZIYc2A8A==
X-Received: by 2002:a05:6512:3daa:b0:52d:6663:5cbe with SMTP id 2adb3069b0e04-5334fae8615mr1200865e87.12.1724333261782;
        Thu, 22 Aug 2024 06:27:41 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4365a9sm119497766b.125.2024.08.22.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:27:41 -0700 (PDT)
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
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] perf test: Add a test for default perf stat command
Date: Thu, 22 Aug 2024 14:24:51 +0100
Message-Id: <20240822132506.1468090-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822132506.1468090-1-james.clark@linaro.org>
References: <20240822132506.1468090-1-james.clark@linaro.org>
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
 tools/perf/tests/shell/stat.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 525d0c44fdc6..24ace1de71cc 100755
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
@@ -155,4 +175,5 @@ test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 test_cputype
+test_hybrid
 exit $err
-- 
2.34.1


