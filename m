Return-Path: <linux-kernel+bounces-307168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1D96495E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE381F2133B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEDA1B4C3B;
	Thu, 29 Aug 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQsyUIEa"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3261B3F1C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943751; cv=none; b=HrEN3Zj9yiXFkq4Jq0rwKaquQvezhC0QhlpxmGLIOCdRje7zuZcr+wQcWtYPKnJMjZIj4jle7Zx8qJIqi1HCLfGO0SUJDFD4inOm+cyKMSFtKQddDyMeoT1OmHYqn4e09+5Fm0gt2B8Nrxrx1HOo5SoeAGdRG7mvAEdfU1o1yLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943751; c=relaxed/simple;
	bh=6JtjT923jGc/V3FlUSejai1b0EYlPO9Lq7KBqzesy7A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aHQEyqANwZXhCfMSlHVAQibdwfpq+Og1oi0hij/ad93uRKuiiJOGkgy178nEIFEwIFv+l5MDHhumGpVdvlj8rCoPusKBkZ/1j+ZXJI+2Oao0EChfVK5z88xE0W3AA4NAKM+joLcECyD7wODJ3/QhnVWFn0f+xrMjnkU38U4s0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQsyUIEa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so1742293276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943749; x=1725548549; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Av0NGxXt1nyH9OnYaW8cLl1uNekiq9nEwkTz2fTJczM=;
        b=WQsyUIEadsJZNsHIriKVcJWmcDgeCjycIXmi7h2/XNl108Dm3DWiKJGEUSmHHpJOUh
         4YUxF4eXRYkeqx86vQsX98XZ+v34Ace03Hgdhu4AXhiRAxZ5Uv595zePrnU208msWsDc
         UMRlc9Bp2k/L75OU5NlRwfp5c/vokH542CyF6BKqzDsF9YZorCMupg9Cv2QsP7tU1opF
         sV8Hi/jmloBzVFdGHw+PNw4bl3PrH1sUkaXFGSdmaQDx+CcaH+n+Ro9qE/4qG5RMDwuC
         ZUV/u8epjr2EyxBGMfxJ9ENZ0PCBmfYNKqDdkeihkFf6ugYwvXcTC0Y9sctSDktiMLCd
         hr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943749; x=1725548549;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Av0NGxXt1nyH9OnYaW8cLl1uNekiq9nEwkTz2fTJczM=;
        b=aW/LQcAPjRxQ1RDO5Krvh2g6rAKCXoP2FrAm90+0ts1NTaEC9mTT2VmdJblO68FC1v
         Wypf8X/OOjEvT18//G3KbXCoQlOYlIEUgglg5dQndQnUINxQuu5Rfjow9Uqhc/oCUyt0
         W+gTU38Ft39zSX26vVsweAf3ADp16535N9mefAVmEkqQ5UtKBqxee06rHIg5kGIcK++F
         jxbEzywKEOY98/0bO/fOZgrl0cF3KHP4I/wSYeRRDH1K1HpE/PNRxuVEDhPcIIvbHkxH
         1eqBBXTOXWStQFSCMpUNGb89rTx6zHkdgrXQGp3pHF+lyxIwZEvPsT0jrFeW/m5bdhEX
         3p1g==
X-Forwarded-Encrypted: i=1; AJvYcCW1c95yH18uGCW0zdLWNgrGRnsmjXp3OOibNFFyASvUMPJ8qB+nvjMg5MXVy06yI9lhh12xIGAH1jFuZXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRaXWhSoGlbF/m2jaoDjBnTAytGfI3p5nBDi4XD71x6/iHFzo
	pLoZnkBBaFjpGmf+3h8ZEPPzKCRtwec/6brgkckinMLd/ZubfsFZQAGnGxGxSJLBcWkeS8ZlZOX
	LoYb/qg==
X-Google-Smtp-Source: AGHT+IFJieNy9A3Uv3j3AZR9Z45ANYmI2LGJZlQ+SwIrR3g7cbpr9Y1OJRykDxOd+oXunJ3IU0lxYLvJDeLt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a25:6b0b:0:b0:e0b:acc7:b1fd with SMTP id
 3f1490d57ef6-e1a5c6b65bbmr54154276.4.1724943749450; Thu, 29 Aug 2024 08:02:29
 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:54 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 8/8] perf test: Additional pipe tests with pipe output
 written to a file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional pipe tests where piped files are written to disk. This
means that spotting a file name of "-" isn't a sufficient "is pipe?"
test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/pipe_test.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index ad10012fdc29..a3c94b4182c2 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -11,6 +11,7 @@ sym="noploop"
 skip_test_missing_symbol ${sym}
 
 data=$(mktemp /tmp/perf.data.XXXXXX)
+data2=$(mktemp /tmp/perf.data2.XXXXXX)
 prog="perf test -w noploop"
 err=0
 
@@ -19,6 +20,8 @@ set -e
 cleanup() {
   rm -rf "${data}"
   rm -rf "${data}".old
+  rm -rf "${data2}"
+  rm -rf "${data2}".old
 
   trap - EXIT TERM INT
 }
@@ -49,6 +52,14 @@ test_record_report() {
     return
   fi
 
+  perf record -g -e task-clock:u -o - ${prog} > ${data}
+  if ! perf report -i ${data} --task | grep -q ${task}
+  then
+    echo "Record+report pipe test [Failed - cannot find the test file in the perf report #3]"
+    err=1
+    return
+  fi
+
   echo "Record+report pipe test [Success]"
 }
 
@@ -86,6 +97,21 @@ test_inject_bids() {
     return
   fi
 
+  perf record -e task-clock:u -o - ${prog} > ${data}
+  if ! perf inject ${inject_opt} -i ${data} | perf report -i - | grep -q ${sym}; then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #5]"
+    err=1
+    return
+  fi
+
+  perf record -e task-clock:u -o - ${prog} > ${data}
+  perf inject ${inject_opt} -i ${data} -o ${data2}
+  if ! perf report -i ${data2} | grep -q ${sym}; then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #6]"
+    err=1
+    return
+  fi
+
   echo "Inject ${inject_opt} build-ids test [Success]"
 }
 
-- 
2.46.0.295.g3b9ea8a38a-goog


