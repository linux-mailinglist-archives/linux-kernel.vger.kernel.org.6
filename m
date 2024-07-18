Return-Path: <linux-kernel+bounces-255829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5F93458A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790A41C21658
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA36BB4B;
	Thu, 18 Jul 2024 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vz0L8t0V"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2B55C3E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264467; cv=none; b=FCHoOCjAqaZZxdPEDo4U7O/F/OFeCL4ak2zYgS9qIpUmOTncztx7pTca07SpqQklS/MhCwY//Umk4CSVi2Ef7CEBlgouS50H5keVtWg7U3qiQmqSvwIvktOFHxMweGzfKh501n5DpnDSZ+iiqQQEwdYSzzAxvPjmH5UFX5d9lks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264467; c=relaxed/simple;
	bh=cDM6cRy256qPkyV0O1yviJXwK4qj6EXmVYKdi+zJvhA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EsrFBkZ0o/y0rWaZgftSKQsI3w9CxojpCaYJy6SAZx4e3N2UQuki18jLUUdxW+26XRbMnoa67VpjoNGWn8auWEeSV5Kg6YrmgkPcjkVLw1fEXAg7wGeEHUCJ0OOzZMvX40IB7i/DkOU+Tk4MB8ocV3lVxQFt42Z+syYG0DhXjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vz0L8t0V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664b7a67ad4so6037197b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264465; x=1721869265; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ObbEjhFM3S/nqQ2a9JTWztyQVhPi6FIfEEKm2Nh8Ec=;
        b=Vz0L8t0VR+ilYoEvvAC5gVXLWOAXqnNAy10Ci8Qe1fNnZKPYcIfdFSEjwlV8P5SX90
         0t4V5ollOYnh1IC8t7MJU5PeHQrsq+5t0DmHG54NM7+/gPyZ2l2Sne4apunD4LjGhhix
         IdCcHQ+RI9FEYCLHsvONrUWZ/G9Jwhn0o2ryZ0QSxu/zEr+ADt5rYyl9/GzmHnw4JihT
         KuI6VvN9s5CHRlzLsRRW2RpuHWPGR8v4CgjhIHOijffc4ngc/DGJ3kplkHvcUufZrBXN
         ySfE/SNgHaXj7x+tYUG427XqyUOsnm+Ic/nbtB35vFmdeyah3RxdZPiL4Tb34/8ZMdt4
         XtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264465; x=1721869265;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ObbEjhFM3S/nqQ2a9JTWztyQVhPi6FIfEEKm2Nh8Ec=;
        b=XRD+0t85MM4i5Zeox1hoUeZDcIUV/7iDoPdjUMY2opqBJbsgHMHQmCiaiuIjrvVgcc
         Ln0KIw8sA/lxWjGnGBKGQ2+puBCQOz6IgAFcqWmvs/2BY4rsocpTFb7MTt0JM0Aa98w+
         TtQDc3VLSfI395ktrI14KfVcd14pMqzRMcc4ztM1P1ya91Mm/cvTIpE0/MnsaLzq1HMC
         8xxC/4tPFm5vSxXgXm1joweIjLp9+3JZokxeunAUfcyhnoswk4sKaOqQkzR0iLRTQOoi
         1KM78b7yLtcPzgUHxu1bgpxj3Ms9uVvdoH9cXsJYrKryp0NdGICHi8AjFLk5cc1ifMQ0
         oyog==
X-Forwarded-Encrypted: i=1; AJvYcCX6LxPlqgZ9TsUeMsyLCMHnrSbj5piAb6KwoZ6dylTPiYKXUTA14B5so5/oHWitFD6AZtfhv8Z4LCV2kCPLp8CjG9LCrUU+2Ozaaff7
X-Gm-Message-State: AOJu0YwKYjHJfAowBEh5vVa7SYe9hzt0WqigtgKVYss04ik+CZdSYuMW
	FKRl4K/SE1cII7l4tEnZ08B/ZnSF1NukMbQ9aHAj0yLNRZLlV4Ry18jj2PJ739QTFwpsaq5EL3r
	c9tGvYQ==
X-Google-Smtp-Source: AGHT+IFdgOy/X0s/tSjgL8YFyCv2y+t9vrNn3n8rqeB7qn0Nz6DvIZ6Nsl/HvGV8i0mKMunHPP3MdC/NEvT0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:3405:b0:622:cd7d:fec4 with SMTP
 id 00721157ae682-66605444531mr325627b3.9.1721264464720; Wed, 17 Jul 2024
 18:01:04 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:08 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 12/27] perf c2c: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog


