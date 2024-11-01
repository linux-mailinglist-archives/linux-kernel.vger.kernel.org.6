Return-Path: <linux-kernel+bounces-391505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158F9B87FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333081C2176F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4931BDC3;
	Fri,  1 Nov 2024 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="SjNkMqEy"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8A179A7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422431; cv=none; b=SWLB3s12JPBYhR1UdgO8IybQILcbaVnmQB8ido6ekBGFA3dW8LXfHlCzXHPOY6tzNPm3hf1ZJ0pjLKLFcwFIviG007JThbrmUdc+mlB+k50Qazw5nLSHl6pxxndtYr29aKCCghZDKzLQ98LEJVUtOANXviFMlOMRqHEbz7PfN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422431; c=relaxed/simple;
	bh=Fd53hf4/RzRbOlaIQTaXnXLpx98XHo0+e+k+4mKzGzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQlZEMNU0JLn6Xjz8xMB9RbKhtzXsBZR2n34Hgo+6Y4q6jVmJmBuJ5NvLUMMDri5HPSMf8+GFFhPQTllhJMRfmtIMo+AvZDEO2mN7wLmuDmlCu/nJ/y4VD/fDXfsFIsuycchUZUsOJlWWERUStcWcXmUlrbIpAoZJ7I0P3W5A2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=SjNkMqEy; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83aad99d6bfso54243439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730422425; x=1731027225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PIqo+wi9i5UZ//zk2SA7F2V2ncICcbOru3HSWAU6eM0=;
        b=SjNkMqEyAOzIxGYMpLCGk9aOkq6bT0lv4rsT/JneFQ5/vCtK0jCEsHzhdMKvraRafw
         zfFcZ3lgt+ClXH9QE2jDIHWU2i03ZEC2rPgtdYzpuWXXZGm/aop1YISwNqs3w5FZ4b4N
         c69Oryt5YP11KHqXlEDarzVWXTmuE5U62DLIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422425; x=1731027225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIqo+wi9i5UZ//zk2SA7F2V2ncICcbOru3HSWAU6eM0=;
        b=aE84HQbsaKU+6W64wtqG+RwOkCzSiyXY5crPEBPKp83OVjOjSSIE1SMcR2rgAgQqkR
         QAWscBPZl786HwnKTakfUeikduDJxg/s2cfb+Vwfn0NPz/e56JP6DOJdyHAXA7cnTVWI
         +0yISLTKdp41we2O/d/EHQFNf4PUDvmCWZga3po/3uHMyLCD7UO19dQ+TzLlFoPtVt3u
         MqfRbpC8ItNCFrzQFGoBY0r76/44JwWXPoSqHmNlrO/3Bob59tgvpDvpVSmjzX9k8GCm
         QAJ1lKcl6wQGmGDbdrp5lGvPTVN/MYj7OTYU6I65hgEMRFRSiERkDGSg39XxRDUOmGyq
         uoOA==
X-Forwarded-Encrypted: i=1; AJvYcCVEuV669NvSMVOXjPYuo2P6w91D/V62TqAI1vz4sty0921KdE+aDevdnND4OBQg7ddTpKr+WjaP9+dqSnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qjgLTOgBQS+ib6SfwesxeVJPhdrPuuwnqCuKn5qQCtG13oTi
	gdNTtc/zdhnQaIjOmQiPx41cm0VmIlY1YnsPaSfQZ47kxcMMPBRsQUL5rzeoQDLJGtCMXeN3PFO
	Eob8=
X-Google-Smtp-Source: AGHT+IGLaH5ZkQIPqx3YrpCB9KbvsM5vvwGg8SFqNHbOVbWsBbXePi3eicUjv0FUyngZnJqQ+I7T2A==
X-Received: by 2002:a05:6602:2cd0:b0:83b:2b89:a14e with SMTP id ca18e2360f4ac-83b65057c06mr557876139f.13.1730422424906;
        Thu, 31 Oct 2024 17:53:44 -0700 (PDT)
Received: from benjamin-test-build-vm.us-central1-a.c.engflow-remote-execution.internal (160.244.56.34.bc.googleusercontent.com. [34.56.244.160])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04977934sm523548173.97.2024.10.31.17.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:53:43 -0700 (PDT)
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
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf trace: avoid garbage when not printing an trace event's arguments
Date: Fri,  1 Nov 2024 00:53:37 +0000
Message-Id: <20241101005338.5846-1-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if the
argument values are all zero. Previously, this would result in a totally
uninitialized buffer being passed to fprintf, which could lead to garbage on the
console. Fix the problem by passing the number of initialized bytes fprintf.

Remove the return value of trace__fprintf_tp_fields, since it was meaningless
and ignored.

Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3f11b90d025..e93f795e680f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3021,7 +3021,7 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
-static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
+static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
 	char bf[2048];
@@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%s", bf);
+	fprintf(trace->output, "%.*s", printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,
-- 
2.39.5


