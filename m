Return-Path: <linux-kernel+bounces-550310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1AA55DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC8F3B1C57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1E190482;
	Fri,  7 Mar 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2A+4PaDv"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DD18DB3A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315161; cv=none; b=Y8xb4QX6a0Js6KNGukdmenxWTvmaz1U29pxNKAquqBnYwt7Txhd5WtqRJ8FZ5zbO5Eo+NMd2F5u8mXLZhxDMpEpm7kWhtzX/6EDA+dh5tlPJclPwSGmOirgl0nS3cdJO1U1rvr0h809xVAyuc7y8/NM4kphzR9vptD2hD4nbbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315161; c=relaxed/simple;
	bh=moyH7ngutvI28A8PW36UdjVAW7IUQjv1VshIvFSOH9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hgTdA7CCDr6q8B9ifuFn1ljH1NBxMy5VoziC9si4jktBPi0XaUW7z0F/R0wlUoVVYZD7AA4m+QtyV7wUH1GUp6xQHi6pJMLXio8Py04z6ERFdGa3F0JBGiyptGBNH1Y6neLbtIvhPt9dqMe+YAPQOAoP5N19KnUWj9gg5qz3GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2A+4PaDv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so2554652a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 18:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741315159; x=1741919959; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OrnONqIHmdQK0sEBinAUX8Um88M0UBcNTM3o5mqNKY=;
        b=2A+4PaDvf8yGcoY+VgPUH6emxj6cosPyk7tEIjbTHXYMgne41nl3YoKwm0EE+oxUBB
         9hOcIkw5eODO8/ouIOajiwRjZ23D3jE2WCNf6SzpMqdlHWlUSQljLLvpybAz4duf/fF6
         7OS207bp22HrdQDHzZfUxGtArPw6hGe9Hun6XEuG27PXwnLUNq7acgAhi7l6X1R3dtLD
         8GaxFgTYI/QlyOUrcBgTsT9D/3yZYaLjDpmI6lBeQgJtC1QwD4IQqrzCk7LrzZk5z3Mp
         Nsisx/H7qqwi2nvBPhMVtiN7vMjQiIPKrpKRx1kr5qnWnTlU8HGIQV8FvSqBPcVPYx19
         EsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315159; x=1741919959;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OrnONqIHmdQK0sEBinAUX8Um88M0UBcNTM3o5mqNKY=;
        b=CkJX69HxNAlYsV9oh5OP1vUTpp3ZV6NWyLe6LU5+YjcSON8B66Q6Ncg41l0Fb43oy0
         aVDe2r17TEesyar8INAqT8NGB1/rtO+tJ/HyM/pMzG0nlsseTvQTkL5AYJJV/wJ/xfP7
         4lCHJba4rKi8NxGSj2Q4sN1C4mKdd3W0Ya4ai/SZzbKrIIG9gx92DfOFVytdPKooXNJf
         0WKll1IU0eVyjlBV21F4gMzU3aiP8a4kzGtM4Pt3O6JynlKnfyrgXVUwkRyAWMyhUIq7
         z8rxEI9ADGRBWXfdmCiu8AY6X8MYeeUH9YZle4XWKgVS5bsN2fgP1ZjSTyM56VdguOLE
         V8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmwM/eucl788NxRsnTeHNflj6tFMZUX5aQW4+aaGxyNqqMVmrzUwv4fWs8zMhpACDbAqbKZsk7uLI6Trw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwDvjA034DkhyYoNOTOLubZ25gJQZJVaS68K1Gu2Fireqe0+W
	zOxob6yBh8Kkf2+vJi2vS/lCShYYOoLqr3aJhFRx4FMK/yDhstjgEqrH3FH8q0E0I7RIWgvbNb/
	j3XsGGg==
X-Google-Smtp-Source: AGHT+IGpKFW3TRJDv127bUtQQfrc+gkgABkcfIUBjfPLAIwuYuyTBMkqGIUvfMdPI2lKVeuL+RI4BKT/kgF3
X-Received: from pji13.prod.google.com ([2002:a17:90b:3fcd:b0:2ff:4ba2:f3a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d605:b0:2f9:cf97:56ac
 with SMTP id 98e67ed59e1d1-2ff7cd3ebcfmr3198108a91.0.1741315159127; Thu, 06
 Mar 2025 18:39:19 -0800 (PST)
Date: Thu,  6 Mar 2025 18:39:06 -0800
In-Reply-To: <20250307023906.1135613-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307023906.1135613-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307023906.1135613-5-irogers@google.com>
Subject: [PATCH v2 5/5] perf test stat: Additional topdown grouping tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a loop and helper function to avoid repetition, the loop uses
arrays so switch the shell to bash. Add additional topdown group tests
where a topdown event needs to be moved beyond others and the slots
event isn't first in the target group. This replicates issues that
occur on hybrid systems where the other events are for the cpu_atom
PMU. Test with both PMU and software events. Place the slots event
later in the event list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 83 +++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 68323d636fb7..8a100a7f2dc1 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf stat tests
 # SPDX-License-Identifier: GPL-2.0
 
@@ -67,43 +67,54 @@ test_topdown_groups() {
     echo "Topdown event group test [Skipped event parsing failed]"
     return
   fi
-  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | grep -E -q "<not supported>"
-  then
-    echo "Topdown event group test [Failed events not supported]"
-    err=1
-    return
-  fi
-  if perf stat -e 'instructions,topdown-retiring,slots' true 2>&1 | grep -E -q "<not supported>"
-  then
-    echo "Topdown event group test [Failed slots not reordered first in no-group case]"
-    err=1
-    return
-  fi
-  if perf stat -e '{instructions,topdown-retiring,slots}' true 2>&1 | grep -E -q "<not supported>"
-  then
-    echo "Topdown event group test [Failed slots not reordered first in single group case]"
-    err=1
-    return
-  fi
-  if perf stat -e '{instructions,slots},topdown-retiring' true 2>&1 | grep -E -q "<not supported>"
-  then
-    echo "Topdown event group test [Failed topdown metrics event not move into slots group]"
-    err=1
-    return
-  fi
-  if perf stat -e '{instructions,slots},{topdown-retiring}' true 2>&1 | grep -E -q "<not supported>"
-  then
-    echo "Topdown event group test [Failed topdown metrics group not merge into slots group]"
-    err=1
-    return
-  fi
-  if perf stat -e '{instructions,r400,r8000}' true 2>&1 | grep -E -q "<not supported>"
+  td_err=0
+  do_topdown_group_test() {
+    events=$1
+    failure=$2
+    if perf stat -e "$events" true 2>&1 | grep -E -q "<not supported>"
+    then
+      echo "Topdown event group test [Failed $failure for '$events']"
+      td_err=1
+      return
+    fi
+  }
+  do_topdown_group_test "{slots,topdown-retiring}" "events not supported"
+  do_topdown_group_test "{instructions,r400,r8000}" "raw format slots not reordered first"
+  filler_events=("instructions" "cycles"
+                 "context-switches" "faults")
+  for ((i = 0; i < ${#filler_events[@]}; i+=2))
+  do
+    filler1=${filler_events[i]}
+    filler2=${filler_events[i+1]}
+    do_topdown_group_test "$filler1,topdown-retiring,slots" \
+      "slots not reordered first in no-group case"
+    do_topdown_group_test "slots,$filler1,topdown-retiring" \
+      "topdown metrics event not reordered in no-group case"
+    do_topdown_group_test "{$filler1,topdown-retiring,slots}" \
+      "slots not reordered first in single group case"
+    do_topdown_group_test "{$filler1,slots},topdown-retiring" \
+      "topdown metrics event not move into slots group"
+    do_topdown_group_test "topdown-retiring,{$filler1,slots}" \
+      "topdown metrics event not move into slots group last"
+    do_topdown_group_test "{$filler1,slots},{topdown-retiring}" \
+      "topdown metrics group not merge into slots group"
+    do_topdown_group_test "{topdown-retiring},{$filler1,slots}" \
+      "topdown metrics group not merge into slots group last"
+    do_topdown_group_test "{$filler1,slots},$filler2,topdown-retiring" \
+      "non-adjacent topdown metrics group not move into slots group"
+    do_topdown_group_test "$filler2,topdown-retiring,{$filler1,slots}" \
+      "non-adjacent topdown metrics group not move into slots group last"
+    do_topdown_group_test "{$filler1,slots},{$filler2,topdown-retiring}" \
+      "metrics group not merge into slots group"
+    do_topdown_group_test "{$filler1,topdown-retiring},{$filler2,slots}" \
+      "metrics group not merge into slots group last"
+  done
+  if test "$td_err" -eq 0
   then
-    echo "Topdown event group test [Failed raw format slots not reordered first]"
-    err=1
-    return
+    echo "Topdown event group test [Success]"
+  else
+    err="$td_err"
   fi
-  echo "Topdown event group test [Success]"
 }
 
 test_topdown_weak_groups() {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


