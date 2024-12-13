Return-Path: <linux-kernel+bounces-444246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514389F034D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA924283D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013E16D4E6;
	Fri, 13 Dec 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="ZK2+XluK"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9511607A4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062190; cv=none; b=doOlh+J1Yz6nt/71xAdwWlhVJcgaWMtBwdXXjMTkjxQqaj+ID5dtviv3ohsyKy7TQ70Sc5u7nZiVvii/H4rYK0+yYcJSlWhf7lYfROGG7dI1Qfy3o/UtBafKfn49vJZjJP1NCRaVZuUrM58yrmW6PuXYaJOKb/yT2VnE8ls7tZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062190; c=relaxed/simple;
	bh=BeHtFePJfyc2ZXX+Pz1KMyierr7nozLLrITrdDd9u70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DEbnuinUC8aX/CxBCbFbhWEUPL6I9TMdTNmqpmDLCutmzGBz72q3U3QsIld2+O9DWsi6XUhofdLLalN8kRXCI3LNaYsYCl7sQXs7habB8b8x4kITHxOf3cOlL3t5K/q0uUwZjsO57sQfNTrULatp3SyD9GGqLJvNWeAkEZ/9bGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=ZK2+XluK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728e3826211so1120756b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1734062185; x=1734666985; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NBoThIqxIKKiwm3GomOJ/WljxVwVkbca9vdkXkgA30=;
        b=ZK2+XluK+j0h+xH4K5H2g4oCuSh7jRpMrQHtPWzd3Cp9gxzntuyAWwGEuHvWdFdXk3
         E3u6airokDt6g/T6oqUFVvlKFW4l8OuVfnlSrFlVP2EcDH9fMr5Q7mx5WQyIiGbC3gM1
         eRo2yGONYdgW8F+ipWfgaKrE+DWKbtbuBfX/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062185; x=1734666985;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NBoThIqxIKKiwm3GomOJ/WljxVwVkbca9vdkXkgA30=;
        b=RFb+xcr0ixr9G9wtDFVCqSp8PdRmlN+sEUAK6PbgkY9NFXErI0xuOuUHOxSjFVdiIf
         uyDm096VwDmNVzDuZMNlO94zN13TMfr/2wZ1thYulDc+Z0eNCTtv0m24PyN76wPm3Xut
         tnNrtJ+ZBduVX2yF15A1RIXOHb+/XYW2F2cWccDk6NO9vF6TXtkelcdNKviO/HuuXrF/
         3PiaSFAHZO4sGH6aoBu2r4CR9sxGkb2LGcVh4gE7fxD/oHCbyrGlNlDVLQSSiKMg133i
         IrUkLSXsPwo0TO9+57HsH8+hcOSH/NeuE6HJfkCbc9/luRqUzv0lyyv3tB0eKeBurcFs
         mKTA==
X-Forwarded-Encrypted: i=1; AJvYcCUIM7n3jUXoQvLQ+hZ/3gLXtnIcj9ubTxHtgwCREjjokbBpmTLHE1/KPZSI8VNEtvQNvDsTVH6UtMyGUZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRGfBZ1QBc49iB6n5LPKqcABY1xIENhXY0fZ4m4lTL0J5yJ1X
	wFNolHOF+oeOj1qhjvgdphzTgjDZb2KsrQ2CcXpnQoEZei81uCVlMn7UKSAS0e0=
X-Gm-Gg: ASbGnctUR6nHJQkZg07KM1mtNDHT9OQgCHBgQp6wnxZTJXOLwhbJkNh1I8DnNJfcl/P
	CHDvHQc6cx2X1cap1d2qzH7e24pQfFgphxnQS8Hp6d4O22tsopoeLEMfZvSkGEde7+nJbvZcDBx
	4j9DVePTbHMS/MlTGqlwxIgPCTSpa6fK2f+Oo0ggstUNxpCEt4NzkK/6Lz6vLYQLTmHc3Pmi1W+
	ykdGhxrExHHgavnkx22t1JBw3DzbozSn3M+JvurRjf6VCExMo6e/yUBvMQ4OBGMrWrBk9ema23R
	xIuRZsEIguzgbf9DPCdaKQ==
X-Google-Smtp-Source: AGHT+IGTKuRX3MygaTiBOJeSJ+G2bErJRuqiMTRj8Zs31TJEgo6o5hS3Dy7Cma0QVKE0e+xy5pD3Sw==
X-Received: by 2002:a17:90b:2708:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f28fb700b4mr2510834a91.12.1734062185080;
        Thu, 12 Dec 2024 19:56:25 -0800 (PST)
Received: from [127.0.1.1] (158-247-70-44.PUBLIC.monkeybrains.net. [158.247.70.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e37cb0sm2137756a91.48.2024.12.12.19.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:56:24 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
Date: Thu, 12 Dec 2024 19:56:22 -0800
Subject: [PATCH] perf trace: Remove return value of
 trace__fprintf_tp_fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
X-B4-Tracking: v=1; b=H4sIAGWwW2cC/x3MQQqAIBBA0avIrBNySIiuEhGSMzUQJhoSSHdPW
 r7F/xUyJaEMk6qQqEiWKzSYTsF2uLCTFt8M2ONg0KAul3jNMUm4eb3jykKnz3p0zhGytWgZWhw
 TsTz/eF7e9wNSlJdbaAAAAA==
X-Change-ID: 20241212-void-fprintf_tp_fields-8aaae2f5525f
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Peterson <benjamin@engflow.com>
X-Mailer: b4 0.14.2

The return value of this function was meaningless and therefore ignored by
the caller. Remove it.

Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
This is a small followup cleanup to my earlier commit 5fb8e56542a3 ("perf
trace: avoid garbage when not printing a trace event's arguments").
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..246be66fd59a4b9d76e4d3c42b68d0a444ca366a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3022,8 +3022,8 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
-static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
-				       struct thread *thread, void *augmented_args, int augmented_args_size)
+static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
+				     struct thread *thread, void *augmented_args, int augmented_args_size)
 {
 	char bf[2048];
 	size_t size = sizeof(bf);
@@ -3088,7 +3088,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
+	fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,

---
base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
change-id: 20241212-void-fprintf_tp_fields-8aaae2f5525f

Best regards,
-- 
Benjamin Peterson <benjamin@engflow.com>


