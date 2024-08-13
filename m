Return-Path: <linux-kernel+bounces-284889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE195066B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A89285163
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750F819D077;
	Tue, 13 Aug 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyEubhuE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417819B5B4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555540; cv=none; b=K341yZUVUcAnsW0Lj91W7iovyRVNAw6Cc9+OXmb2nRc3Yw60QvfeYMaQ8Bu621ho9uJ2QkrJb6Gw/TnfscdbCKVM2TBMhJEyPgEn9PIr0EciDr5OEhL+L8M7ymY6lpQEMEQHliSNqWXXqu23ZZho0SFojPvxr7EHh84oHZgt5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555540; c=relaxed/simple;
	bh=TCmY5/W8UjZo5v+UmsAxTLf+W/oV6ui66khMLptw/MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzxjDCqvCK7nYFBeKJH8qyfm97IslP+Tt0vbxztRPfCE/MupdMrqngfISUs7yAD5jdbC2ksYXbCbkyvtdnMcMtkT3Pz5Lj5C0MTZezzhXkjJ/boMB02ipurMhh7lia0if/jYw0CtvDmpnCuy0oiHcAWt/RUNhjccKsD7w/gaLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SyEubhuE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428fb103724so36911095e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555537; x=1724160337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=SyEubhuEKik3hYXSQIEkZ30iK4uJjqe3fZfSo4RIn9Iz8Hz7w7TDuqAiDazlwSIVbV
         4gNAe4IJAdnPNivrWzM8C7i3vRuibrUMXnIcjCN6bQcozqS2O8gnMTcRCXATEfg1hC/V
         r5bfi62NgxifckMKRxv4d2MiPzZQRylFom2MJWXoMVIJrfv+7DoGHdWmBTsj3/zzPveG
         fWIxyQJGy+cp+XcLMVkGL3iSHTrtMewDIJhoC4vJi0/UJuwFA7PAwapcnEQUwE+dHbAT
         g+whSboAI6dGGva1UYlI3rvZqmFjJfdr6+xR7wjYtRzeUJNYLUo9bTO9FUJYo7Jxa6RR
         M5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555537; x=1724160337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=Gs52EXzS4A4fzb12nXfIAtb/bnAEBncG+EOzzpy4QDlfgqY0I7Od4IquxYc3fDf6uM
         CiQ91hc5rLavFCYV+EJrM12soqfEBLyb8pMd9ioOF7WfIZ6RbOEzoNT1kVO5lzVLo5B8
         9sl/vJwBPI4B9SrY4jl/y/pakaCjUzb5MaRrIaKJGOA/fStsvCs5GY1HspXOzmGN/2Py
         tbHnRtO2Vj5yIKAEX1Zq10TvzQ6uEjS0l1fV5uDM+gMOqCYmdnc1DbEjXHYCthNqkRfQ
         Q9hi7T96DyGxfEfSbe+v/m1qr8tjPeDyQ3g+e3XVz58oR9KWmN3Mw1olAbO/dBAtqP5Q
         ZwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMO9lHjLwn8Z7VqjyrLSg1pbssWCXlBQ3ZBMVVWJ3l+z1oUZd9phjK2N3isr/Mf8yKF1brMp3OjyyG3IV2Z9D60sH1t0w+qsrWKDV9
X-Gm-Message-State: AOJu0YzCGyu+CHdJb2ntf4y0aWh51sRTYPKMpILtdfmkxlh/+2I4zajO
	QQbb640QFJzQZ/hqjLDByx0tvyAJ+I++518YJv/BfvIJNKQKaJ/QHae8fDvccpA=
X-Google-Smtp-Source: AGHT+IGc9t+MTAwYwGAaBX95OSnKFftghFZ3NfLAkZ7AAvwA9zVwqXl0BELY2LWwoeQ2oa+XAXA1ag==
X-Received: by 2002:a05:600c:3550:b0:424:a401:f012 with SMTP id 5b1f17b1804b1-429d6269733mr21164045e9.3.1723555537440;
        Tue, 13 Aug 2024 06:25:37 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:36 -0700 (PDT)
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
Subject: [PATCH 6/7] perf test: Make stat test work on DT devices
Date: Tue, 13 Aug 2024 14:23:14 +0100
Message-Id: <20240813132323.98728-7-james.clark@linaro.org>
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

PMUs aren't listed in /sys/devices/ on DT devices, so change the search
directory to /sys/bus/event_source/devices which works everywhere. Also
add armv8_cortex_* as a known PMU type to search for to make the test
run on more devices.

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


