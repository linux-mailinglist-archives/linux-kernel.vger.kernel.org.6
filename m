Return-Path: <linux-kernel+bounces-323323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC80F973B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B241F25677
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C505E199FDE;
	Tue, 10 Sep 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZ1QPh7W"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B9188CC1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981523; cv=none; b=qFvwMkzAOlZdRRAuui8JlOmyg9SS/FnZeRXNsXODDdM6pvUEnRkV1ovvgbaKZUl5vuVJJ+A3Y+KemTJsQuHZR3WjhvmD2HqOYWB3vgeRv1YKDgQTxJSPA5uKU3I1Tzvo605L6LlB2MAMjM35VQcfhPAjfd3EcglkelJdH8MtKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981523; c=relaxed/simple;
	bh=hd7oyorl4TOQWVxg+vhsoBj05DEdVB7R33IhLz/6S/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bto6b41b8mYyGL8JHrk/isX6u0UJOXaRBJo2U6fNEmMyZzhK0okYiNvI5HK0vJpJfWhMZWAfTwvFBnkdnFswaI5hJDryGTdG41tI2YmDPK6FJd+PxJkIy6qqMWDwnztGcvhJhK2JC+JcPF0gD67qR346i/kyWK4JWhYCsigTMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZ1QPh7W; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c1963cb6so3562235f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981520; x=1726586320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV/wWyP/OuoFa1Q1XSAgXw1mLQzgLi2JT0YhtXRGetA=;
        b=fZ1QPh7WHjyKH+VrNKGazUVUSD+fGshtPmNA+qVsDwEFqoYBTyUitvY76gznjJ03eX
         g+iSoSU6EIwwc/Ggp60IzInmrQolcI/nScRJB9vGNdOybhEJLy3JUBraSrtmoFFo5JpO
         gRJtNYehkRZIE8Wth2xbUz64b0pK9AM72Fh+zUt0ExpVzbzMU6slNyXW6O9r60HT+kU1
         NscqMDFRct4iyULzmT2bL0hiBidXv79Ns4j5tu3INC5sKE8woKBq10AwbYFGtIvx5/6h
         Lzbu0UWsW3yA+JZaMRtYdq6xQcnVz9KSHl+JfrQ6RCdz7ZPsR9W3Bo71t0hu3oBC3OQY
         U/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981520; x=1726586320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV/wWyP/OuoFa1Q1XSAgXw1mLQzgLi2JT0YhtXRGetA=;
        b=bo50R9J2egy9qoKRgWz31b1tsjxIH/aVkN3OANiK7ZSBVsVbwwSwTCaKY6EFE/QWSo
         vhG3n8vIValSc2WbICDuuYjCkq8MTH46RycoC52io+c9B03c7BHrw+27X3tcwl3Jb9TX
         /XdLrXU33/Hdr53N4+kRgz25SQxqWB9I9QFaQvLovfSVMsjvfUhrbyqFGI7AOZy+wIj+
         5gIq/+LwbZqmuHkSXl9snzv9jSjEGxIda9r+gtHhKax9/E58Pr7FoORbntGqgBi/T0En
         cN08tAriwn54w4TfBHeGt6b5DJHHqQy1j4BGZrIxemslla3778TvH56TeU71DA4j7bmx
         wgEw==
X-Forwarded-Encrypted: i=1; AJvYcCW812wehbsE7rKDJFs7as/4yp9GSufmreil0JZBIuo6RN7eyZog5agGJ9c1NBrTfYisN8qoviJWiEZEb04=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVfuAfEbM0le+DCJ+eLNpM2SBqO1cfphl+ZbXRphMUkF2/mTm
	H4Kc9xyXeLR9TOS4ET9aBPukw7eJuScdOt50Y9k2qEhrV58YUKEdgdyqDxL3QPw=
X-Google-Smtp-Source: AGHT+IFvmRJ3kwcH44X8tEVQpW/XuglOxSPCkP6MHjK2ehbvCFJ8Z5bWzyalPeu3oqnDHG3TOgB6LQ==
X-Received: by 2002:adf:e544:0:b0:368:445e:91cc with SMTP id ffacd0b85a97d-378895c9deemr10636514f8f.21.1725981519545;
        Tue, 10 Sep 2024 08:18:39 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:18:38 -0700 (PDT)
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/7] perf test: Make stat test work on DT devices
Date: Tue, 10 Sep 2024 16:16:24 +0100
Message-Id: <20240910151640.907359-7-james.clark@linaro.org>
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

PMUs aren't listed in /sys/devices/ on DT devices, so change the search
directory to /sys/bus/event_source/devices which works everywhere. Also
add armv8_cortex_* as a known PMU type to search for to make the test
run on more devices.

Acked-by: Namhyung Kim <namhyung@kernel.org>
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


