Return-Path: <linux-kernel+bounces-392634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033709B9683
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267C91C213A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B31CBE85;
	Fri,  1 Nov 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="HOIFhwpC"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937A1465BA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482044; cv=none; b=nGFgstX5d78M9SNgfISCc/uusCxk9xZzYGKjnLaxG08Eo+HXnKAXFW7g5VF0YKaadF5T5EgsfprbfnFtjN/LVhQy2aLZdbLamsZ8gZ/G8aLWiImXLNxgbr6zUrWUME91vn6hKzJXTNQpxmfXty6qgUZQxL+umeNHkjKCFEbQKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482044; c=relaxed/simple;
	bh=KU9rwIN6d95c30EkDh282i5OPjsEk/eTWUcP6OHGtYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8fHudUg3ii0jHyByBmhP+qk0bSABEOnU1mgnBjekJjW0j2IO5fkR85STTIUPp2c0DWtlAtDtRsfZjFEP1yY3aIbyUgEFadBpLqcZYSlL5sh8qU3PabMFfIcmnKVLlg/M/tmQZYag1xwDaJhmaG5IvffI2mBkh4SYPw0mOmt7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=HOIFhwpC; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83ac817aac3so90516239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730482042; x=1731086842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRncpCVsFZrGgtk3qlgEv2y6veWYinM5Xkv8y5SyOvk=;
        b=HOIFhwpCstxH14PQIhfA4c8u6+C4Ca260T2Wm/BfeAA4h/JIlm/F50jhWsyS7uQxvZ
         zn6C4/htHSPEoWyCd+7pyWJt8v2Hp4hSWMpoJxFod2Diuqi5QgdS39uXSnFBKGuwIOLv
         4kZy1mfLixqbbsyAAnkZvo3Ix7Egjgf2r5vEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482042; x=1731086842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRncpCVsFZrGgtk3qlgEv2y6veWYinM5Xkv8y5SyOvk=;
        b=ZG2AxQ/i/DXQkoJURz75+OeUI8clHKgUNBrhgfomuFNwbCfxCDNxfbz/rXb9vrUuGY
         OoajsNclJoVeRZZTRknzltEsEN6Ok/ftUN/QSgKI31kn09pUFdRD6a5Sr8AAUt+Y2JwD
         t/YxYGjqi+RCOCyT0T/Y2RODRoPHqG4V6Y2s8RO0VruoywEX89WNw9WyheK2hnZqCEIV
         8T2O1WdlJqBOYQ11A/k+IsDSTk6COz8ewFDenovpZhKOotCm+vgGJ1KoyzRt1vpQVf6A
         26MbNuWX5tnW5//3VQ7JaD8lhdFwZ2ZIzpX705W6oLADpUb6II4Q+JijeC5GZgbBdl7Y
         Qpqg==
X-Forwarded-Encrypted: i=1; AJvYcCVAud3FQJUpH8kPnlMwDonYB9fm4gJQexEPv4mKiTUX01HPTHzQ+xrChZBaaTa8OLYFNnnAhT15wUokfJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSUh48uozufuPgGrNuHYBaWqwszUUJ0nZF0K+aEiVXp1Si5dx
	az7XmptW8/+L3vU1kETFeX7hLG8+eFCKOWoh9Q7qZd8Wz/d57ksGZW7z0aW8kB8=
X-Google-Smtp-Source: AGHT+IHMIzf1E2Ob3z1d3xzjtPWR3YAEEitFND7Do7HMOKx72yRKrl7lXdSjJQnSSV5wvzIM0sAUjw==
X-Received: by 2002:a05:6602:1354:b0:82d:754:5026 with SMTP id ca18e2360f4ac-83b566edf89mr1580062139f.4.1730482041992;
        Fri, 01 Nov 2024 10:27:21 -0700 (PDT)
Received: from benjamin-test-build-vm.us-central1-a.c.engflow-remote-execution.internal (213.193.56.34.bc.googleusercontent.com. [34.56.193.213])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048b15f8sm812376173.37.2024.11.01.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:27:21 -0700 (PDT)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: howardchu95@gmail.com,
	Benjamin Peterson <benjamin@engflow.com>,
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
Subject: [PATCH v2] perf trace: avoid garbage when not printing a trace event's arguments
Date: Fri,  1 Nov 2024 17:27:14 +0000
Message-Id: <20241101172714.84386-1-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101005338.5846-1-benjamin@engflow.com>
References: <20241101005338.5846-1-benjamin@engflow.com>
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
index d3f11b90d025..4e785ea29df6 100644
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
+	fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,
-- 
2.39.5


