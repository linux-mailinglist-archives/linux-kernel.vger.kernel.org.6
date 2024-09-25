Return-Path: <linux-kernel+bounces-339469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC698659D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6D7280D69
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1076A357;
	Wed, 25 Sep 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrSwGy9S"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A160C152
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285419; cv=none; b=PBEqrGRVLs+WIl72B/X2v/PZM8fEiPrjZ8qD3v5iMZq5bI/CVzjaYI8Ac7o//Bz2JZIs3BDn8zZ57BMHNK1A+MKEftrLPYhuDVWEOkL5PGI2vmsLq6tyae7IhtpiZGujCbFCIN0NelIJJ3a7QcG4Qqkx2vMN86Xht6ertYrecwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285419; c=relaxed/simple;
	bh=6lMrxe8sCTgBy01/mf9iIpgXaSX/UU8ZeE/q0YQhcj4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EISDKfzFTFKIFzSI+YjnV3TAs7Z+O/w4ko1ZFm3ZmcKHxpvjqliD4jixCfO9JMA/bJKbpPHlTB2Ps+RIBmxteF53Z8TRhfes/HDxuhICChZDeCfbUJoG77a+XYIJgUbkJ9x8FUvBsK1gyFqgjAj4+zFjtTrRPR1W3vkDIneDgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrSwGy9S; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e201a37e5a4so164755276.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727285417; x=1727890217; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o7mmItE13oyNMD526yrDEYQPSrEQwCMg1pQdM7EvhJM=;
        b=PrSwGy9SQzZJ91muSfew88JRed98LJr50YV/sIQG40NdjkUzZ4391Xok56sJLlLNyt
         S8cNn4ekjIIvQ0O7LZnxQepjHbp0s6peccS/vo93ywgIosWPb2eRKyNi/XjKL8TTXHTV
         NySj5hwukjN/zyJdPqvgRiH+xPjfeHo2hwRXnRTqIF7gouWskR+m8wBHb+oUsbSg1JzK
         qOI0cAK8zNhyxjENDrTqVcQmrhefGA5+H9KdNaLuTqbc9GCRL6V+YSaNzE2CQnBtBpad
         XmcnviCfq2Hb2/z+lQ1koT7eiV/xuU0EkRl7Z2r7MUMFyuvq8umUcbbagVeIFHN5adGF
         x3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285417; x=1727890217;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7mmItE13oyNMD526yrDEYQPSrEQwCMg1pQdM7EvhJM=;
        b=ngMFJHSylOMdIdgN8LqBNiILW08J+UTr3VHpbdNVtnXq8svCyHs54BXfgXOt1ogOrG
         6igqDSvtx/RNjlOgwheOPtc8fCT4sC+P8J1HUD4jHYGOy4mCGjO8tdqcJIa4B2RX0sA6
         9nowp85g90e47q14ZvTOhejhsFLp/UiZFc7DGnalprK48FROFKhHoWMb0ppG/9PcFtDV
         Y6EV1UFN3xPgMYYg/KqcScUgpTWEzHdJnoOuR/4uhpI7OHqt/kkTcHrex5VXHdQxCcZw
         EAJedEGXIhJ68vE34EXHNX4Ogko/MhtueMBelJhkTBe5yQ3Si4Mhi08mKGL8lpZvjCAH
         4agw==
X-Forwarded-Encrypted: i=1; AJvYcCVxC7ydOq5us9WY+aXhJC9o/iEfKxPK5Duvm1LjkN+9Axab01A558+vB8IOarhJfqtEelXAM/E2e2Y4aBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UwpEzMpBWjlSXtXmM3MViYZomlIScIuVOIRFyIZJ46ngRkSL
	NQUtCV3UCLwj1bUf/HmjQTCKibpE0jQKQG+09RrLiTu4gHCJ0M+sgUjNGrbd34tJIKAabcI0Hnp
	9bImQcQ==
X-Google-Smtp-Source: AGHT+IFzc5fJx3iARQ8up/ouMLSTHLgHfuFoYepAgqOopOfeUM/50KEXWyClxZLUzhVg2ZRNel7VH9IHzDjz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a05:6902:292:b0:e25:2491:d005 with SMTP id
 3f1490d57ef6-e252491d211mr2442276.8.1727285417021; Wed, 25 Sep 2024 10:30:17
 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:30:13 -0700
Message-Id: <20240925173013.12789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1] perf test: Ignore security failures in all PMU test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor code to have some more error diagnosis on traps, etc. and to
do less work on each line. Add an ignore situation for security failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_pmu.sh | 52 ++++++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index d2a3506e0d19..42456d89c5da 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -1,23 +1,51 @@
-#!/bin/sh
+#!/bin/bash
 # perf all PMU test
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
+err=0
+result=""
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  echo "$result"
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
 # Test all PMU events; however exclude parameterized ones (name contains '?')
-for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
+for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
+do
   echo "Testing $p"
   result=$(perf stat -e "$p" true 2>&1)
-  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
-    # We failed to see the event and it is supported. Possibly the workload was
-    # too small so retry with something longer.
-    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
-    if ! echo "$result" | grep -q "$p" ; then
-      echo "Event '$p' not printed in:"
-      echo "$result"
-      exit 1
-    fi
+  if echo "$result" | grep -q "$p"
+  then
+    # Event seen in output.
+    continue
+  fi
+  if echo "$result" | grep -q "<not supported>"
+  then
+    # Event not supported, so ignore.
+    continue
+  fi
+  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited."
+  then
+    # Access is limited, so ignore.
+    continue
+  fi
+
+  # We failed to see the event and it is supported. Possibly the workload was
+  # too small so retry with something longer.
+  result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
+  if echo "$result" | grep -q "$p"
+  then
+    # Event seen in output.
+    continue
   fi
+  echo "Error: event '$p' not printed in:"
+  echo "$result"
+  err=1
 done
 
-exit 0
+trap - EXIT TERM INT
+exit $err
-- 
2.46.0.792.g87dc391469-goog


