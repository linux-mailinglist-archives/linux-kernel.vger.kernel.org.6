Return-Path: <linux-kernel+bounces-305128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF39629DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09F61C23D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303B118991E;
	Wed, 28 Aug 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtWUrWCu"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB85189B91
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854178; cv=none; b=tfZJeyGJ7fyx+Dqz+V7MzTV5GcFPS3VyAPIyZVnzevYCBbdFVfxe6mvcejSRfNJtsAbew9UxkznqYy2EqarXLDx0UUXnQm0kpl14HgawXlmCQQstjby1QZB1FQORL9nz7mhnHUMnkWAJmK7A9cuIfOzUluWJxU41BRzaBtN6J3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854178; c=relaxed/simple;
	bh=TCmY5/W8UjZo5v+UmsAxTLf+W/oV6ui66khMLptw/MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xv+cwJVjhBwbvpTtdMClmALvVDYPY/PmloFfbG9Uq9X4UG1FTU3f/8YJeTa8ZayiZcYJWAEupmMRtpVTEM9cujRFolxSYV+5ShCNe/cbLk7gOw7XaVc4zffSxKPuZ0uiC9wUZkSAdjT0x/tLq7MKjCdQj50DSHMnHIEIiusxcSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtWUrWCu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f25a1713so79485081fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854175; x=1725458975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=mtWUrWCujaC6GK3StEy2a+IP/zyH/FH8WWgjSFMnjzOYuDY9u5buUBmpL2gIKtPQfH
         JHhdpegfr4TWg54mdmL4nIbuU5Mj7JvHIkxayJCfW6ECvPK60SOzvE1UMTJP+2oSrxOm
         NKDi4ptva+h7tAa5jnHZP6U7Fi946O6f9ml5mpNkuO/zxmSlxfwZVSw59F57sH3VRM3X
         Thro2XX+q82Xz7pbsHjpbNTHK+ohprR6ufpA2lCKWMSZXOn+6fM58HdJyhjrkJIlXguG
         bHYWLcKDDSp0Lo55+uTGFa2mHcVGmp+HRXKjFIKI8FvO0grc/oljl02ECn2fNuWxVYXM
         Iqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854175; x=1725458975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=OBxgc9cb22+gEZe4SUp35vuQVOmlFaSE+mJZOwKZ2j5DytD9w4Caqpt2tGbbwPd1ek
         Ek7GbYF/1slqGqd4ROAmpYHe32PIMNLdR9A0WEVEU2oFzgHJWwBpWABQ+vFTYpWPt8ob
         jVThVpIfStN0RpnJWRN2DQTnsu9YvrCoAmIdZE2FVwVYHFcRkGlEagYJS2S91+E0x1yD
         6O7nIIMHcrdSQPn7HhWrekTKuA9QBDTv1bl2fIKkmTCRXqBfCCaiFdw3t4R/ea4JocOr
         7maJrnhWsorcQdXen4Elyl03kVr3mU7QvSLQVTVdVT7TbUAfMs4YTVdYA0oHs1rhvv1p
         kcaw==
X-Forwarded-Encrypted: i=1; AJvYcCWoVNCSI8thalNq6lUMiQgHAhWJ+rexK9BfBNG0ig7l/DZgfDW6sBzuIOxXVA0mZqJV0VpG9KAjlpOfwG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBTV7bp0j/wCvIVHbmmXvQiyGPSPiSJ8gDAuDeqY773beldmE
	fQiuW725up4nkOIaldB0/K6enjWz9/GWCOrLM/+0vkRvlUZCyjKmDw/lwnOdrEA=
X-Google-Smtp-Source: AGHT+IFgmIslD8aeXezPJ8omK9Ym59j23rdPHAVaCBU3pdKjqfegi/dglTnAMLH6nBwoXlF35NdpKw==
X-Received: by 2002:a05:6512:3e08:b0:52c:825e:3b1c with SMTP id 2adb3069b0e04-53438783f89mr11126822e87.26.1724854174372;
        Wed, 28 Aug 2024 07:09:34 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:09:33 -0700 (PDT)
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
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/7] perf test: Make stat test work on DT devices
Date: Wed, 28 Aug 2024 15:07:20 +0100
Message-Id: <20240828140736.156703-7-james.clark@linaro.org>
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


