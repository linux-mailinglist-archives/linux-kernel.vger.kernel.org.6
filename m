Return-Path: <linux-kernel+bounces-393964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169F9BA805
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAFDB21075
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49B18BBB7;
	Sun,  3 Nov 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="lt7iLfuH"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9013B791
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730666924; cv=none; b=SUIEqOrV8LdNdJ+jh5k5cnKkoS3yNWAMNmtYgQ2KRM97X4EgcxlUYmv6TNMLCtXLKUCvUCxRCUtdX8k+ZtPKPkNyPloJiDB7aVAuDIVapkoq51dkg/hN3F5IE72C460rmFGXSWJ5/CqsUdoRsQcQ8vMEY80M/jSP8zPTIL/DQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730666924; c=relaxed/simple;
	bh=SaPPFw0i2Jm6LqIInQrwnloT+7hSRv+2il3t25SfqpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvFNiC/jJDjWkwTjuX9sKBP67JRT4a2DoA5qukjSvcHzlehuVHc9jYcC7t4V76vrlcFswxOniDS374QKLrpR9NfUlbbNsasgoocBXwqTFHtpf+r+ATwb+Xd10LE7Y4eYSY6toqgia7buExi2tX+q03aezI+0CCktHYD+2vNmjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=lt7iLfuH; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83ac817aac3so145058639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 12:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730666920; x=1731271720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlm2PLrARUKeIopTjkk7MtdiLDlLWS0aLomBZawMdaI=;
        b=lt7iLfuHm19mw4aHvOHsIfChsyPN4Gw3zj0/g2sFIOrSrCe6n5604A/ku3c3fmO184
         nxt6kWqPlWOl5i3Ocn5J1OILLA7FvmbM8HoE6uoT9foM5kf95IlaYUrTQ0JCo7DtrEbr
         RNQVRzjfpOngNHRFr1+4ehiE+/DO8h707N0Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730666920; x=1731271720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlm2PLrARUKeIopTjkk7MtdiLDlLWS0aLomBZawMdaI=;
        b=ACYY7bIQrlJw0R9Ws5UURRFgz8Z5qk/Ne7LcM7CAUUXJlh/6qvC8FFxKkxg7Q/Ykho
         GGogI2LTQCew/k1WZ6rgbCAFy0HbGIEu2lSXPwJKyXTqvgIcx6Q023xMjER9wTJ3QlQf
         JvJlZFuPr5WXzmlTdmqCMcOBlvGbx0bICiDYB0g9vz4mE6HXjtSFcS1icJ88uoPqYPXf
         armz2r722enrMIxx+5Y78mcVbKFV44IxPTNgVzL62U4ACzo+LKMrgZi2+NJk7FwK6enl
         ycwQiIPKampSkDhV0OQcFZ5ejh36J8UHYDO8DQvuttNDyOQtNXLOs2+/xxxlbrH3CQeD
         aluQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5cOzSiASYAil15+xRVmHRkbkqKCEC16wjT6Nkk3eeaqXipYcqijFRTjaoxY8fG0kNka9Ze85pBu+VLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvd4iCWmv8bSN9mFptMTKWgwSayY8oaWg5SaPU4IrcGB3wOPmg
	qEy1/k6K6/2Y2XHqvnmBUzyqiYXyuRxbQHtnzMAjFnKTgFxyK1yyY38qEPbESdk=
X-Google-Smtp-Source: AGHT+IFmKEKqEcCrPchJyXh14BuWWrnIOqGLmqLcDn3M5t5a7ymNpnzwMlZRzh4NhnPRabIqTcXQcw==
X-Received: by 2002:a05:6e02:3992:b0:3a6:c97e:75cb with SMTP id e9e14a558f8ab-3a6c97e76b5mr25594865ab.23.1730666920050;
        Sun, 03 Nov 2024 12:48:40 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-a.c.engflow-remote-execution.internal (132.155.121.34.bc.googleusercontent.com. [34.121.155.132])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a491csm1661468173.155.2024.11.03.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:48:38 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	benjamin@engflow.com,
	howardchu95@gmail.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org
Subject: [PATCH v3] perf trace: avoid garbage when not printing a trace event's arguments
Date: Sun,  3 Nov 2024 20:48:16 +0000
Message-Id: <20241103204816.7834-1-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ZyV0a6e_46R9pmQw@x1>
References: <ZyV0a6e_46R9pmQw@x1>
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

Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
Tested-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3f11b90d025..5af55f4192b5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%s", bf);
+	return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,
-- 
2.39.5


