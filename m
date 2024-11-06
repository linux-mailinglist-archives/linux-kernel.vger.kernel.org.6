Return-Path: <linux-kernel+bounces-399063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89229BFA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68216B228F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340A209668;
	Wed,  6 Nov 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="cckbOpYn"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB020E03A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936733; cv=none; b=AX9ViJOFigZtEtoUi5yS65IHDF36+EuUo+g3r3zZ1N/Czn/PgIUcqqKjkDmtn6b03hgEtZsD8mnFS/Mc8A9PK/0mbCLDDTWFDjlkILLJECT9eXN1fGvrppXHVLhe8QR9vohkIrR2p6QybzFsx44koJJTZoZuE6ycVXRAxA5MZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936733; c=relaxed/simple;
	bh=ZOWhK+4FMI3u8kTrJVCbQYNFvYByCnIoKRmRtgo7V1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqo8Sp6CvCF10ShZAeRHGoyrmIRLAAq2TBJv3r9EYQKsQjWVK8DoPZcMUo0+H8Sq8Un+D1gaa1qgfn/0sS6axjxVtFR5BvRfO++boNPn/VD3hdYYe8k0cAX+zatfgmUERyCOlSfa7hZFq7ZeLfSPViHRutf99mnxoqHoXQlDu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=cckbOpYn; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a4e5e574b6so1554395ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730936731; x=1731541531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aTdya3FSNT+0ZGcXS8KwIL+PwWEHkGWusGXOIiN+Vo=;
        b=cckbOpYnEDJDg5WSfKv141vjYCBb7NeG+HaWaCV5BCVjx59ygFvX0ErONEkjHRT9IB
         vMu8cvLUGEJVgwOGSX2ASTn6Y+SanXF2uOr6zd/L+GaM6azxCR/vIEl2/ZSFdHFKcdxL
         TTE5RUCjRvljD9Elzxt+9dgtxjooylaSS/xIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730936731; x=1731541531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aTdya3FSNT+0ZGcXS8KwIL+PwWEHkGWusGXOIiN+Vo=;
        b=slXGoKvTdb9JW7VXpJLYSCxIkPXcWUy3/gutZSkiY3xAGRw6ZQ0H8inPmz7U7bS3/9
         KGpnTK4u7lDuBStg5yvhtGCVKdYDgIId7hRIsvQGcrTDoftiDXlJqTGU5R6NWQ1naFG7
         a1Vfu0lBgDdRFCkv74ovbXDDRjxlFOdYAEmPkPCNu0kkg94zOrRtm8SIhKGIm8XTi7FI
         PvMTJAvdYEHxgLy1DvizQZDY+9LQ0VxwW+6b4nnjBJvbeovxu6JEN7/IBVVbEscolkw5
         h6xQuC3QEK1TuOm1dNd6eJbyg+GfVNP+D9wtRnGlFC/fEu49aMvNbowesr+fs/lKmZ8r
         mujw==
X-Forwarded-Encrypted: i=1; AJvYcCVErZGiXEuWMgwdT2ZfmkkLAYOdqinjN2PBcM3H5bwqangtelqCCsdSAYX4pKQHw7vxCVa9XTPdyddo/3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRNpqUSgyz/MiiVlDAtpUxOcj65i7W/0tHVun2GeBrisXqbnn
	l+LOtUPg1VejUosv1loifnopxD2KZGQ+lrtkgRXGtCHanTdbxaJUCKPGB9v0VQE=
X-Google-Smtp-Source: AGHT+IHgRE23IQm/EXjNfnAxF1WmAkWQNLtX+eCiETf1zcGq27cCCVBuEGmtAkhkOC31+mBCuZG+6Q==
X-Received: by 2002:a05:6e02:152d:b0:3a6:ad8c:9173 with SMTP id e9e14a558f8ab-3a6e895f367mr11247445ab.10.1730936731092;
        Wed, 06 Nov 2024 15:45:31 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-b.c.engflow-remote-execution.internal (209.179.154.104.bc.googleusercontent.com. [104.154.179.209])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eac8c5c0sm127745ab.6.2024.11.06.15.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 15:45:30 -0800 (PST)
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
Subject: [PATCH 2/2] perf tests: add test for trace output loss
Date: Wed,  6 Nov 2024 23:45:18 +0000
Message-Id: <20241106234518.115234-2-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106234518.115234-1-benjamin@engflow.com>
References: <20241106234518.115234-1-benjamin@engflow.com>
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

Conveniently, this test also serves as a regression test for 5fb8e56542a3 ("perf
trace: avoid garbage when not printing a trace event's arguments") because
exit_group triggers the previously buggy printing behavior.

Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_exit_race.sh

diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
new file mode 100755
index 000000000000..8b70324bc5b4
--- /dev/null
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# perf trace exit race
+# SPDX-License-Identifier: GPL-2.0
+
+# Check that the last events of a perf trace'd subprocess are not
+# lost. Specifically, trace the exiting syscall of "true" 100 times and ensure
+# the output contains 100 correct lines.
+
+# shellcheck source=lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_trace || exit 2
+
+trace_shutdown_race() {
+	for i in $(seq 100); do
+		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
+	done
+	[ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "100" ]
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


