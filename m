Return-Path: <linux-kernel+bounces-340623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FA9875F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C171C22F13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8614A4DE;
	Thu, 26 Sep 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1aVKkvT"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58976154439
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362235; cv=none; b=Oxxug05uwFc9+rQYwMzfG+CeQYJ2G66r2Dp4l0oPBmnMh+AUR7fksNnD2qaWsOot8mPAucW8r/WggF7DIUPoU9IosLAw9j66jrHHmFaz2RlUXvE4+hxSqgIPH8waAEN8QlMA+uZD5OiW9DS3eQGbQYvQJxzf+U6dVwL8tAOVYcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362235; c=relaxed/simple;
	bh=uEkMebtlJ3oS+pP2FKl25/DE83+yiPQjb4Lo5sy18SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uw5HqqKGGUYfFTqQ+VODTc4mIwG7JqbS5d2ZNULnpKxhkbZ79GwVMlVbALEpqQn+6cXOL1pO0TVFeGzzQT/SPJ9I+6c7m07+ak6B3TcLPfN4Dw5EYBOFHQ9IckVwca3/VT/u0xOdfMPu9WzKXYM7EmKuHQkeRhcgOkCFTOeBlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X1aVKkvT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365aa568ceso1306132e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727362231; x=1727967031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=X1aVKkvTUJK7Eg8qiaPMZy6enfQKgnvDpUy64n5wEa0L5CUDmJ4IvdRWuDcgptoMD4
         vKvdO7wwTbc3YgSg4afO3TtSKx/ZfP+KoHRV9c5Yft2PRRuDM5VpApPA7amvKmNmM3Ks
         pfwY8Hp2JaoYzKW3CuKeJ1F7ukSF3CbnC0CGw5qYMkfsZFshHxdOmvtp88ZHSXrEYUX7
         WIO+r04nu2I9bi7uutLyn8IDO/fdC7/Zirs/dp9FQvNFz4fB8pMT3+6QkDcxOKRfUgg8
         9bBdwesPhECaSY3CWWIsdCBjCMHPJB9pEPu1AWML8G6XeWlnd5eaatUGbK9yb54SG1Av
         22sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362231; x=1727967031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=xHQxnvw2qWNzQDWhT+aTcGTFYsp7abLckum5nBAag9pQGOY8TKtIO4cG65sIwmL2Bj
         g0tjGHwtNAfgCrLwLMn/6Aha5VLxWzN3Ax+u+kiaFjWnCdDOMi9XRLZldip1wACiGbTJ
         v/XHNqMjXg8gBul5DLZcsoD4Qr0T/hzaSoSZwAd91VhzVxpWx+HXMSQnNDgJkHYLL3Fs
         WFIFEukIKJigZ/KHC/kiPp8Q33zZmbJ4YrnuHTpUmqdakYefPRLpecow+MEbBv0cKkSh
         Sd8ESv5QjWFJJ3ugmXLnqjc7OVcUCwn0Ld2qxGqzWtUBWEo6vdU4VigBoO6eOr9UHuUi
         FzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3I27LWMvn5PIyr1qkgg2Z/IAu2wo5JROvDhMcroNnYMnlsuJbc+zQir7knOwfbiYQSGXNr90+mPSkdEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCgMaVxoFhsLMWSfo7MJMVvhDlhGh+rGqYn7OmHG1CdcMlLnD
	fQKZdjWDEEXoG88Dn8vbvcXQ6LHis+8kAzOl5o/XDbFABUHZPiLepgpnvLZSb6k=
X-Google-Smtp-Source: AGHT+IHFBhIAAGgVt9IOOCYfDDIgsohl3GTjfp4I7Y73RftEYhJ7VTnhJZmj1Oc2A4CYQGF88oJngA==
X-Received: by 2002:a05:6512:3a90:b0:52e:fa5f:b6a7 with SMTP id 2adb3069b0e04-53870496c1fmr5903737e87.13.1727362231305;
        Thu, 26 Sep 2024 07:50:31 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294833asm5589966b.98.2024.09.26.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:50:30 -0700 (PDT)
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
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/7] perf test: Make stat test work on DT devices
Date: Thu, 26 Sep 2024 15:48:37 +0100
Message-Id: <20240926144851.245903-7-james.clark@linaro.org>
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

PMUs aren't listed in /sys/devices/ on DT devices, so change the search
directory to /sys/bus/event_source/devices which works everywhere. Also
add armv8_cortex_* as a known PMU type to search for to make the test
run on more devices.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/stat.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 3f1e67795490..525d0c44fdc6 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -117,16 +117,18 @@ test_cputype() {
 
   # Find a known PMU for cputype.
   pmu=""
-  for i in cpu cpu_atom armv8_pmuv3_0
+  devs="/sys/bus/event_source/devices"
+  for i in $devs/cpu $devs/cpu_atom $devs/armv8_pmuv3_0 $devs/armv8_cortex_*
   do
-    if test -d "/sys/devices/$i"
+    i_base=$(basename "$i")
+    if test -d "$i"
     then
-      pmu="$i"
+      pmu="$i_base"
       break
     fi
-    if perf stat -e "$i/instructions/" true > /dev/null 2>&1
+    if perf stat -e "$i_base/instructions/" true > /dev/null 2>&1
     then
-      pmu="$i"
+      pmu="$i_base"
       break
     fi
   done
-- 
2.34.1


