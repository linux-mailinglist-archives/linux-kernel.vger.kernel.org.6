Return-Path: <linux-kernel+bounces-400780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F349C124B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288732848B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95621A4CD;
	Thu,  7 Nov 2024 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="UUzlyPbV"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE121A4C3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021712; cv=none; b=kNuKFVhC4ICzTeeexMrW/UUtMfr5YdEDEQ0FAPWSclHfgMYYS9arMNPmtqPhlUAQX/IPSQI5taF7dkqvlGuGpCNpAwJ58qqyRzq4IZCQLKxFZ9Q7ZlS8AY7uIOYE1BdTqpIZotsWOiIrmCK1cRyjC0OY9fhpRG7CMgQSAZF7v1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021712; c=relaxed/simple;
	bh=ajTnG6Q7byyjECqEyCgacr8k/6C+th/DgduDEADABGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8fWRtX+XVDuEIJlJNyEjWijOgWGKS5N44fJ832kA/o+AjVSki6lxaNtFN0oXsnv0c74tIwEzBOU3V3t4Of14Lnyxu1WYWSRe7vCkPnS4tXPwN5pA5g8j6QvFLTbKZSC8o6dLOoGJDr003PhzlYqDhwM5XcSO5w3BMVdGbvLzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=UUzlyPbV; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83aa3ced341so62842639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731021710; x=1731626510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aeskaT6zkLjjpuoEwx+3cH3yJ2vmgNjTv/hFcPPqA4=;
        b=UUzlyPbVYcgPelhV6mwATmiFQBKa/PW7sBIwJ2RWKwZqV+I4rWasHAGmL7x9potEDT
         l3+9EE2oliCRhWCnvtkdFXFjumVDOLRMcfR0IXW4HjkwjyBj3f6gcMuPY2rehJkU5NKD
         dOfDkdb+XgPQzYsAe9xNGEKNK9fZXxpRiNcTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021710; x=1731626510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aeskaT6zkLjjpuoEwx+3cH3yJ2vmgNjTv/hFcPPqA4=;
        b=pB1pGuuKDiXzNseVLf+FVssVw/glopZRhq0Uynud3G7/mNeknWIo4cxUa23YfbG56f
         EDalP6eFomHG5bGBdmh+7WrmfNZwoeqaFy1ZLLzIx5QAPTkgvKw4VJcm0fdqLuB+Vumk
         zv2Cs3c7dMf0FkgYUJJrA5chf0LoBnUAljEPUel00TPameZnmOBJjQjm4JdraUCBFmdG
         Tx8KHmMw1kkUVVZj9dzRP8Tudc1kOhKiD87H/k1U8zGzcN07hcWkJvUKSk0EP0CO8boa
         p7BB11WdhwYelTCPfboPdezkeqaMoxxNnf2Uk4y6LCr9ZVH5BSdDQA5/gkt2grASV/M+
         5x0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1TXpSMMo8L0IUbIuPB21D9Bxl6FLF8lWPzZdB01QU9+bCuHnLbqFrYVttQoXtmZ+svlyDy9eSQirgV88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwcTLgk+AycR9vk7eymqYtlMdu6T6YxDQ/maL5EWXEZkeYfrpF
	Pc+UkVJRzAXuPi7XLNMHpy5hOBKPS1j6Q2SvKf/mBUDTCOBFReE6MhZbMaaRezI=
X-Google-Smtp-Source: AGHT+IEz999ziNrkDZ8HCMHUgj6ghL8MBc8L/YlSroKbciLffQgCmkOe8TuOAfHulsCKw7584GQM7w==
X-Received: by 2002:a05:6602:160e:b0:832:40d0:902a with SMTP id ca18e2360f4ac-83e032a1a31mr84060239f.6.1731021710282;
        Thu, 07 Nov 2024 15:21:50 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-b.c.engflow-remote-execution.internal (93.126.232.35.bc.googleusercontent.com. [35.232.126.93])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f82e773sm533023173.68.2024.11.07.15.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:21:49 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2 3/3] perf tests: add test for trace output loss
Date: Thu,  7 Nov 2024 23:21:28 +0000
Message-Id: <20241107232128.108981-3-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107232128.108981-1-benjamin@engflow.com>
References: <20241107232128.108981-1-benjamin@engflow.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that checks that trace output is not lost to races. This is
accomplished by tracing the exit_group syscall of "true" multiple times and
checking for correct output.

Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_exit_race.sh

diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
new file mode 100755
index 000000000000..f9cfe44bce86
--- /dev/null
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# perf trace exit race
+# SPDX-License-Identifier: GPL-2.0
+
+# Check that the last events of a perf trace'd subprocess are not
+# lost. Specifically, trace the exiting syscall of "true" 10 times and ensure
+# the output contains 10 correct lines.
+
+# shellcheck source=lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_trace || exit 2
+
+trace_shutdown_race() {
+	for i in $(seq 10); do
+		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
+	done
+	[ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "10" ]
+}
+
+
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+# Do not use whatever ~/.perfconfig file, it may change the output
+# via trace.{show_timestamp,show_prefix,etc}
+export PERF_CONFIG=/dev/null
+
+trace_shutdown_race
+err=$?
+rm -f ${file}
+exit $err
-- 
2.39.5


