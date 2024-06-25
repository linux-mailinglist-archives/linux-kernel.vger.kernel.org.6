Return-Path: <linux-kernel+bounces-229398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0562916F34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551F4282187
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E87176AC0;
	Tue, 25 Jun 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmhMTzHj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1917D370
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336395; cv=none; b=pc4jerBp7a+VIrqHagWAlw6iRR8ZgZUJuEZVTHcOxxmS9Brz1PrdGCsLXWsG04iAKSuD+gjSQB5vci9UoDD+oWeJ9sq1ufkGz1c3HGe9td42ODpuTqkyDrCQ3QBTuKB+7C/IcQTueKppqyl5n3jZox+ZJ0GUJrpdBgPuWpJvVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336395; c=relaxed/simple;
	bh=xTDdcKAsM0Ri5uMJZogx0bCMWjSncnIkrWNhWgEEO0w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M0NaETSA4RYX2nsA0jj/Z5PLI/L15Hcg8R6IJRRstcCGi9keyV1sMIYTKxFeFgVFUgUQoyGgnsRRuvZ9Dp6GtzuI1pwmD0chARO7KF/5Hg1Xt4z9yYUjX84tShoMH8xaZ6r82LocWw3dz3UhqYgGP3Bh6aiSribstOG1FJreghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmhMTzHj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f43c95de4so132225807b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336392; x=1719941192; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6guPMXmcdW65GtfPCYKyOHBofbB3BqlsDiMCqc1Wqps=;
        b=YmhMTzHjLw5zVWZw3diCPM1b2dlunOJGcuqopETli6VbX/BjEP4Pafz7AUF318/Kb4
         SHAIRXV+x76oa90ZRTQdb4ZCWf9p1zv62RayLEPZAepe2OFxkUrYR74hr/nP0Fnjd2fh
         H45aE48agPQ6noIz2HijaFxjrTU/cNpIFspDNkCvVk9teAfd9hcw4KFQG7MC5fvoRNNQ
         WKXaRjnvio0CEEXZ4KJQDEpm+urwsNwKp3xnOk+Ge2XXbqICwIkHlTrT+qmNAkEVarem
         0GqdTJ3Gs9rJv9iAuWv2tKVoBBCMNeg/TXEtjQvao8ZJjd9eRDbtPuoSRoxdP3ZSz290
         UauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336392; x=1719941192;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6guPMXmcdW65GtfPCYKyOHBofbB3BqlsDiMCqc1Wqps=;
        b=UWI2u3h0XgzYjBln0GmQ75RJLxy5wIR+GvC6UDamg5MVKbv0SUCr7A1LfGrHT6S1ds
         iNSA6CxCqDRI8VQ7XThkQ4462aUQrlVBl6Ih+GL+o8V+F9+t/3YWoyzGI9bUndZpqqS4
         xGgztDEJVuwVpHhLVid0Hlf2dA99UUUgfNbwC4jZLBqvviSwMyUcqrevfYs62XU7yiay
         lYGkcQG42RwbVDYaIacdVwTcR3csWOccgqg0BKnlFMhgDm5HbitdKpUoJKFYgk21ZGzW
         GByF5L+xD1EL18wZl32hXg+BWB7/cm3qTB/dGMU/+thJ716op7XBtjBEP2Lk2pl9pX4g
         YTyA==
X-Forwarded-Encrypted: i=1; AJvYcCUAfo3M0b2Vr84kRskB+gfIpbOYt9/H+bKjAm/DMzWaNwgHXNXN6aos8UaTL6WY2JLl9RB2yXjtYKYO23MMQv9H4B70BgLI5O+w6Z0x
X-Gm-Message-State: AOJu0YzaYDMGDHPrv8juo5Mq4s7vCDid4ipCu1I3wHzb6tjsTkdXYu3I
	Pe54dHqIKlBl4nb7+TYuSC9kAjfOuECjcQqNyXaHfg8XlZPj9ARNsomkZeRYO1FwFmmvR7frcBF
	xXNWxAw==
X-Google-Smtp-Source: AGHT+IFV8nFgbzCmqp5624khLyjgblB+C7PSMAG99rhpEHx97+eQXMZPvyVLcBZvUnoqdEaw5LZAWS/mgVDn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:fcf:b0:627:7563:95b1 with SMTP id
 00721157ae682-6429c6dcf91mr317197b3.5.1719336392078; Tue, 25 Jun 2024
 10:26:32 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:47 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 10/26] perf c2c: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 88c131d05186..cd2bd573bfc3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -385,24 +385,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	goto out;
 }
 
-static struct perf_c2c c2c = {
-	.tool = {
-		.sample		= process_sample_event,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
-		.comm		= perf_event__process_comm,
-		.exit		= perf_event__process_exit,
-		.fork		= perf_event__process_fork,
-		.lost		= perf_event__process_lost,
-		.attr		= perf_event__process_attr,
-		.auxtrace_info  = perf_event__process_auxtrace_info,
-		.auxtrace       = perf_event__process_auxtrace,
-		.auxtrace_error = perf_event__process_auxtrace_error,
-		.ordered_events	= true,
-		.ordering_requires_timestamps = true,
-	},
-};
-
 static const char * const c2c_usage[] = {
 	"perf c2c {record|report}",
 	NULL
@@ -3070,6 +3052,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	perf_tool__init(&c2c.tool, /*ordered_events=*/true);
+	c2c.tool.sample		= process_sample_event;
+	c2c.tool.mmap		= perf_event__process_mmap;
+	c2c.tool.mmap2		= perf_event__process_mmap2;
+	c2c.tool.comm		= perf_event__process_comm;
+	c2c.tool.exit		= perf_event__process_exit;
+	c2c.tool.fork		= perf_event__process_fork;
+	c2c.tool.lost		= perf_event__process_lost;
+	c2c.tool.attr		= perf_event__process_attr;
+	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c2c.tool.auxtrace       = perf_event__process_auxtrace;
+	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;
+	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog


