Return-Path: <linux-kernel+bounces-556962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DEEA5D1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE80B189EA48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78743229B17;
	Tue, 11 Mar 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ccs//ZnO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D41805A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727801; cv=none; b=RCYEZOsdgypJoGS/n6JcHQhVqiEICSSSSraEZ0o6qOiNvpfmnPnCFw8fKCJ9/PqngSHwtJ1osPAsn4+Qrro0fLbeQowYqrB5VMn6aAjd+8xit5UKBjOUhiOVnTWl8DnRlR8zr2g3Jy49LvrOBPk/HBvYECm1NCaW7c/ISWduLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727801; c=relaxed/simple;
	bh=lvscBsVv1/BjSIs7zpT9RlNNOLICQNjFW1jic6bfVUc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Tpe3eSeUIyQJr+8O/iUWKXMqJM9fcwtvtNFB89t+V+Gi2jEeVBW2oaF0MONQ0PnevZEGcUyUlhNxekILOsM54fkyoWrhLBLC3IBN7Y3gZ+eiKA3lK+ACAwmy8NlvNzz1S/0SvKzdDVdyX1r6wNu7mW7mV0R/tFAbpH/4iwkDo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ccs//ZnO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fed889e351so44136377b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741727799; x=1742332599; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vIlk2s33Rrsc/qi+k6noUpBBdxrj900jkSndtjdrPWc=;
        b=Ccs//ZnOLuPo8WnUnXeqdmMvl0pVA0oQqEVbgPYYNctUErZqc45B+RNnUCz5zokzQb
         /L2+G16eUt2uN/vDyYHRPYDGKRsh6fCqlD7rzgSJuMJ1Wbs55ECIG6rnvuA/L1EQQQYX
         mrPrUCIjxYb3DDZjRi3wqR9Dq9a0LrJrPjERqgrPHibkSM1VBtpT08evLCp/38SiYMiX
         FTSAQwNKU6tOYmIjyzlXiwd41tzU/Ti1NDyQu+hYUDFFQqFqIGl2VNL7s8Fg2ihSu8bl
         42R8ljp6lxRNeVc7ad6NX5hhoL45xPJdbdOe+aZjvf+uJ88h1cYeCCtWIqj4vya+0UoH
         V2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741727799; x=1742332599;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIlk2s33Rrsc/qi+k6noUpBBdxrj900jkSndtjdrPWc=;
        b=ktzCd8DPcGPXEt2Sy0d8t/EEKXfZHiVp4FaXiVFPf7sjSYIOFAYJCZQYos4zgMQf+K
         a6IJygCDk3XnaLAPUw85eA/e6gW1MHVafwyj7RDQ1rdqH1Xt4fueU4GOnbJSQkxENEG1
         jR1RF2eS2hjtwEMpjZ+2k6B5jH0u7AEHx5uihdi9Y3bmpwaRWNuNKzYOzSwFreSC3pYz
         q6y9PIxPt/Z5e9d+ej6llMzF9JNSu+6LAy+vjyjKgGD5qB7GBj7TvwTgelvrJA4owRW0
         UG8xdun6aJd5AUEmUo68cFoT4mMG1EnNlq2Jf1YsFqJ5PBjttI/MwNsAMm0OICIq8o1y
         2PMg==
X-Forwarded-Encrypted: i=1; AJvYcCUa1+FEtPrHwG/4CVg6PyL3A+SM/pTGqSe8YT594heP05CU0hO63ozReKy8NK8YlVzUN1z9RPUnixSPoME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzklG8IaJCZ/a9/bnIE0SJvHhk9ZYZzoaskPiUlM5g2KnZJ3C+
	8e9MI80J1a96d8FoROBryXjO7EkK91tVVXme4yTi7rRp09Fdsf/UiRo9oUX6HjtqADXLJ7OCaWl
	RajTB9w==
X-Google-Smtp-Source: AGHT+IGi854aNHtbZQDmiAeH6ZFKPYGEkZuVEj1mFXwtM3qpSHMvC6UHN+F6MLn8UeB8kPCPQvm1yenb94dz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a0c:b0:6f9:8797:a247 with SMTP
 id 00721157ae682-6febf3bd171mr23216897b3.6.1741727799152; Tue, 11 Mar 2025
 14:16:39 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:16:35 -0700
Message-Id: <20250311211635.541090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v1] perf tests annotate: Add pipe output to output testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Parameterize the basic testing to generate directly a perf.data file
or to generate/use one from pipe input or output.  To simplify the
refactor move some of the head/grep logic around. Use "-q" with grep
to make the test output cleaner.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 56 +++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 1590a37363de..16a1ccd06089 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -35,54 +35,78 @@ trap_cleanup() {
 trap trap_cleanup EXIT TERM INT
 
 test_basic() {
-  echo "Basic perf annotate test"
-  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
+  mode=$1
+  echo "${mode} perf annotate test"
+  if [ "x${mode}" == "xBasic" ]
   then
-    echo "Basic annotate [Failed: perf record]"
+    perf record -o "${perfdata}" ${testprog} 2> /dev/null
+  else
+    perf record -o - ${testprog} 2> /dev/null > "${perfdata}"
+  fi
+  if [ "x$?" != "x0" ]
+  then
+    echo "${mode} annotate [Failed: perf record]"
     err=1
     return
   fi
 
   # Generate the annotated output file
-  perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null | head -250 > "${perfout}"
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
+  else
+    perf annotate --no-demangle -i - --stdio 2> /dev/null < "${perfdata}" > "${perfout}"
+  fi
 
   # check if it has the target symbol
-  if ! grep "${testsym}" "${perfout}"
+  if ! head -250 "${perfout}" | grep -q "${testsym}"
   then
-    echo "Basic annotate [Failed: missing target symbol]"
+    echo "${mode} annotate [Failed: missing target symbol]"
     err=1
     return
   fi
 
   # check if it has the disassembly lines
-  if ! grep "${disasm_regex}" "${perfout}"
+  if ! head -250 "${perfout}" | grep -q "${disasm_regex}"
   then
-    echo "Basic annotate [Failed: missing disasm output from default disassembler]"
+    echo "${mode} annotate [Failed: missing disasm output from default disassembler]"
     err=1
     return
   fi
 
   # check again with a target symbol name
-  if ! perf annotate --no-demangle -i "${perfdata}" "${testsym}" 2> /dev/null | \
-	  head -250 | grep -m 3 "${disasm_regex}"
+  if [ "x${mode}" == "xBasic" ]
   then
-    echo "Basic annotate [Failed: missing disasm output when specifying the target symbol]"
+    perf annotate --no-demangle -i "${perfdata}" "${testsym}" 2> /dev/null > "${perfout}"
+  else
+    perf annotate --no-demangle -i - "${testsym}" 2> /dev/null < "${perfdata}" > "${perfout}"
+  fi
+
+  if ! head -250 "${perfout}"| grep -q -m 3 "${disasm_regex}"
+  then
+    echo "${mode} annotate [Failed: missing disasm output when specifying the target symbol]"
     err=1
     return
   fi
 
   # check one more with external objdump tool (forced by --objdump option)
-  if ! perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null | \
-	  head -250 | grep -m 3 "${disasm_regex}"
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null > "${perfout}"
+  else
+    perf annotate --no-demangle -i - "${testsym}" 2> /dev/null < "${perfdata}" > "${perfout}"
+  fi
+  if ! head -250 "${perfout}" | grep -q -m 3 "${disasm_regex}"
   then
-    echo "Basic annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
+    echo "${mode} annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
     err=1
     return
   fi
-  echo "Basic annotate test [Success]"
+  echo "${mode} annotate test [Success]"
 }
 
-test_basic
+test_basic Basic
+test_basic Pipe
 
 cleanup
 exit $err
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


