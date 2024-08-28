Return-Path: <linux-kernel+bounces-305129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D439629DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5741F21D30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1E19AD6E;
	Wed, 28 Aug 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgP+lcep"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0411898EC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854194; cv=none; b=q998JTnEIGUX+r8mT1FF8nmVayFXVPKvdy7yq/P/6vx78ALCs0OY77l3RzH3LPzNFjNoKhZu5SDesnowWAxN9bYjGSmsOJYUfJAC+iqowwM49fj0Cbk7PFjDtdQFrbJ+8E/L+XXYfc8M5al8VZOQ2x8GtDPSCoWRXjEB/9ZNQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854194; c=relaxed/simple;
	bh=iJebi4RnGEDb/WDnZ9Fx1JV2iX2h8srqqUl2h1UV8Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHJXIHLNguxCqmODGK9zQFbYG452ajkCcZUejeIZ7920m+E5+uTns97p3hiku2tPE5uHKgzh5we+gbm3TMJLPvc/xWRGaXPke4woKPOvDXolj0zMPD7E1mgy3R8MoTVWd448lGO4ooWUsPW5RiCx0ydEgKQdM9hncOL0+RzfCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgP+lcep; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso7344289a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854191; x=1725458991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il04epHFd9BrsJtGAU8mELFSezcE7nnWBSPUsdUkN8I=;
        b=cgP+lceps/CN0jW83sVt4yrHOj7+Id/AijP4zEz9JG23yFc2pVVOBV2fFNJa3oofT9
         ZZf8WOX6JLJFaz5hxw5TMZ3Q045CT1Fot/WTC7x9KD1HzK5N85KcubZU+AfGwD2/0m6D
         N+NX9WzugHmXV0U5V831Ngjq6VVaKkLAKL4uhy5QYxRSKkj9d+xLF7jl0AXwRjIpi8X9
         HQKnJ/AfyQf7pWr7+agxms5ckEZlEWbh9EM8Z6+DDuXBZ1psVQDzjFJTg65qN/NQKXrB
         uqakSa6477tA5k50j8TGOYu/+ziczdValV1yEpreGKT+PfTox60FKURVfTdUwISAoEJE
         25aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854191; x=1725458991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il04epHFd9BrsJtGAU8mELFSezcE7nnWBSPUsdUkN8I=;
        b=ddMDJT54cZ83ORmzAv5wGg7+WJ9aAimausB92JEvIdn1trVZWwBJr/CvqFxizqO58f
         aP2ZxrTHHFEosrfsZIg0Gy5uKROY51gp9H3aFyqDmLBfjDyCAnRvYzWaLqUOyNT2hj8r
         M6KarmNSjuIWAPv6iDKpx5Y8KgzVT846I706saaS+IrAe5u6cP2hGC7xr+LblFWF0ge8
         5zjwC/t6bbi6Jbbp5SyHTKus2/xd+cZ4yWUmp0BRlNJaM5yv/DNqPc0vmmYTDhxyiMDH
         UUgqwSvv5dD86smSVGD3SgtJZemBaOO24yk0vK0Ol2G0jXHouB3el5YL2Cr6tVVl775L
         nAEg==
X-Forwarded-Encrypted: i=1; AJvYcCWHKWt1DmWRIvWtraBk5TMM8TYGeQJV/nOof0//jUA9bXrhwSubuf+m/G1yTHV6swWDzdQiOzs/YCq9vJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExpYj5bjwVt4bqUJgivZGmSE3CLbvithxIinN3uB9D2hElkXb
	rYvBeXXdc3hX9RKrVOJDZKvKZ2DgQs8UWv4D5TjfJEygy0DII+j2/QumFsC1Kio=
X-Google-Smtp-Source: AGHT+IGfU9r8eCZ1F54SsYtSTEbWp48pODz+BAIgPEFvEm7Ao+dfQxCs2umNAwFacPms+yzwmqUedg==
X-Received: by 2002:a17:907:e6a3:b0:a7a:ab8a:38f with SMTP id a640c23a62f3a-a86a52c37c9mr1305055766b.41.1724854190212;
        Wed, 28 Aug 2024 07:09:50 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:09:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com
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
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Ze Gao <zegao2021@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] perf test: Add a test for default perf stat command
Date: Wed, 28 Aug 2024 15:07:21 +0100
Message-Id: <20240828140736.156703-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828140736.156703-1-james.clark@linaro.org>
References: <20240828140736.156703-1-james.clark@linaro.org>
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


