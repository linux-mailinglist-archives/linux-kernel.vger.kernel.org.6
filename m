Return-Path: <linux-kernel+bounces-339219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF9986393
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A3FB360F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEED15C121;
	Wed, 25 Sep 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GT+MiHYR"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688F18628F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273775; cv=none; b=JZCx0GLqyQ4nwxwoT4GWaOAZzdZ53bTF1TumHldhJrKCn5BpCEjEo9oSyThse0Gp+RfwF5kzRykOL1CFN/5Zlyz4h5u5AxS/7sCAI3D9trDFsNZrbIIFiAcCYclJJbEQl+YA4oxD8qm1qbYmYlNtW5Wh+ldlfnC9bGlWo3ilwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273775; c=relaxed/simple;
	bh=uEkMebtlJ3oS+pP2FKl25/DE83+yiPQjb4Lo5sy18SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRjW+EF8QU1axA7IRlSU8oCQ4JHoy1VXZA2yL3x2Ms8gbd/2hFkbyL4W5Gn86dVVob9up3pXwQPSnUwxVIlNLlJ3fTQuKQeB15srbBl8iAyR/pL4DRrEZihWaofU2pgrRiCcu2n1IqucfJtGZXh1ncMO5fSIhBZivxJbg7EFSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GT+MiHYR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5356bb55224so9196510e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727273772; x=1727878572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=GT+MiHYRB8wmvV4ff5HPiwArmoKL+2vzruAJHOcF0jx+VpMbxKa2IJj5BeWAwPC/UX
         iiPF1jknSGSa0gCJxIRpq7OBebGC6hwGo9AtPtVG+e4sEwwf7uFSAvCIKlvH05R1eafJ
         dPfIeycXDrrGLXoYtv0umSj2wAVyyg+oFGrw9XtKOkfCQsIBQ3wbgiku06m1q+c8fzth
         IiIts4z0gNMOMtWI3yYCtatb3Qxt7nx4LUxdF/kdk3c3VRqCzMJ7F/RLTY15sqIGBjZS
         +0wSgqV6kQq6/qRZTqDf0q2dcLTXgINwX07yU/qDw33SLQ0FKL3bq65hwArcHu95lF+a
         ZK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273772; x=1727878572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=eckR0z/FxJawt1NdMv5hzsPCN3j6+lJTaBzU+a9LN6/1NDCKrvf1QJpoxrVtZd63Y1
         WOi/POm5EQP8flpZ6Q7MwUHiSNksq9UZUFt5Y1qtUj46gluQPLTwkZrCQbJbnAYba6Q2
         vgemU7OtaNDYPmaL5kGbWFBhtpKIf9eUDL7yecUmfpx7QFoX6Jj7NrDj2D+3/8+D4lqV
         EifiYqCxMJtf4ydkfL5h3C1FPYtTriPDiRqgNocykOSWOvw5EWB94sb+FVpcqAm9u61Z
         Qo+ed1OTh44m4Xl+CQp3mxUtEy8gy5pxuk9yb1bLhXhojnVF4eSM5kVW/wAYPGuiIkjw
         Cwsg==
X-Forwarded-Encrypted: i=1; AJvYcCUqbP0HnTVNY5J7Dwt8e+lOlyvuPEj/ZEKV0zQk/xlfqzQYPiQk5SdUYF1MESLyf7WEKiIXnT8j8jPdLb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xTwSmlc3vfbm5dnkTehN81AAHYRerlgEhgnQ7j/3ghHaSVie
	BVRSKT2hBLfOioK/17P/Yv6ylxg+Vr9qj/lxSZI5wDLQq6r4MXT/N6RizuShLX8=
X-Google-Smtp-Source: AGHT+IH/AokU8nE5Yj8ombOw44PhKPwV1SxEafUhKBgeHTn5hoNRs+iZV0lhr7F3HawGiH9D28Flpw==
X-Received: by 2002:a05:6512:1395:b0:52e:9b15:1c60 with SMTP id 2adb3069b0e04-5387755cacdmr2000950e87.48.1727273771713;
        Wed, 25 Sep 2024 07:16:11 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm1888005a12.27.2024.09.25.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:16:11 -0700 (PDT)
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
	Yunseong Kim <yskelg@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/7] perf test: Make stat test work on DT devices
Date: Wed, 25 Sep 2024 15:13:44 +0100
Message-Id: <20240925141357.1033087-7-james.clark@linaro.org>
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


