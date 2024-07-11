Return-Path: <linux-kernel+bounces-249181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3692E818
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05571F232FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA9615E5BB;
	Thu, 11 Jul 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LVHadjte"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA615B153
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700230; cv=none; b=eMNEsADndHMiiY5j/PLREpwjC2pXj3LgD+PrKdTKBs8DHMI1KetGyydmoyhFP+8YvUH2PaAnJK4eX9kyYWP6guBh15kRasovS/YxVkwVRoPYSmFi0YMeC0QUexR9eJHczF6IrEcXOik3H7Ymr1Yqil39HGpLHt+dTaBIBkfgliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700230; c=relaxed/simple;
	bh=RcAtOY3BqIjsxZ/EkLx9cbSXMAG2HJ+eMA8VPs9/m08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aEaUlixJZcNfmm62tUxETqsHmmAZKjNK2bpwMfXpFt8jxUh2NdOmG9+1QKM68gpPK7j5IyqlJxkNFhHlY5k4JpZpdzE8tJOaKvCjgeXUm9/khB0ifAv/IbpALeMoNkDul9rfcWWDDOK2qZI/b3P7xfBciiiK8jeEDEG09V2NAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LVHadjte; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso4671445ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720700228; x=1721305028; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMWLbotKK9Kcv+yDqQHrYwDupJwtZdSLIhFGpeisVqk=;
        b=LVHadjte/h7XYlTcwcYI9U+/gzwWtnQc/9wrfJ5esFeOoj/GDcPtmIZSShn8qst4rq
         MIdmt/L5PoQA6qXOfD6NQ0ay7vIr/Y3S0c8FPj1PTSBkEr71aARovXGvY8d/kpjyc28f
         Sar2DaP7hMflHtT2m0TS+rqh48xsbHd5mfqKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700228; x=1721305028;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMWLbotKK9Kcv+yDqQHrYwDupJwtZdSLIhFGpeisVqk=;
        b=wIYwco/iRZVKk9368obmG/iuaGz3ciLwslZoFT7ykOQ4zbl2EK3W3Y4unrFKjA1JKz
         sK77Ow23EjCo73adm4mqiJCVcgb7sVyS0hiok9cJqdrNxALBHE4Hvt7A2fx7s++VMLqZ
         liym4unppVXEuC4FYb9ElYndNie0V0t1rzxODFuvnHXwXyEgbKtPlXKGVnIyaJTOSHCY
         wYEe8N0304CPuiXIXsxa8UCXOsQdQI1jZalyuXvwq0bqo/XrKl1VAC2ZiEi+i9DHnzqr
         bdIsvM1sp3a53kUJqqNwDZ5+sA3/Ezfqixj359oT6+fEZKMI+r0PDYU7yIbNAH/7l/U1
         aSNA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxFnZI4SkzRaJA8POluPMBaK0Z2a4+ufueWTUf3ETlRTdV5rNq30UNsca894OnC84eDw1dCtErefmd0H4rC0dPiXkfzLEXp3HBmCV
X-Gm-Message-State: AOJu0YyhUtPGNTue/FbeFHrymgYRwKPwOPn7+r9ffOT1ecOiRUcOIPpC
	rNxGfgEV+K9MWPxDozdw1q9fMyr9KGKLXb6VW+Pg7If4F8BlLTWdZavc3lxmKg==
X-Google-Smtp-Source: AGHT+IEay4VzDWGc7cNbJqKwvD6xCyKm+QF0n/B7mqHkBPs8hMJ1zCGnny6ZKJS0v/G/jgh4m0FgQw==
X-Received: by 2002:a17:902:e54c:b0:1f7:1b08:dda9 with SMTP id d9443c01a7336-1fbb6cdac37mr68496965ad.8.1720700228186;
        Thu, 11 Jul 2024 05:17:08 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10111sm49211985ad.20.2024.07.11.05.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:17:07 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	rostedt@goodmis.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	asmadeus@codewreck.org,
	siyanteng@loongson.cn,
	sunhaiyong@loongson.cn,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH RFC 2/3] perf/record: add options --off-cpu-kernel
Date: Thu, 11 Jul 2024 17:46:18 +0530
Message-Id: <1720700179-22839-3-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--off-cpu-kernel to collect off cpu samples using on/off cpu time.

Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>

---
 tools/perf/builtin-record.c | 2 ++
 tools/perf/util/evsel.c     | 2 ++
 tools/perf/util/record.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0a8ba1323d64..5be172537330 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3571,6 +3571,8 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_BOOLEAN(0, "off-cpu-kernel", &record.opts.off_cpu_kernel,
+		    "Enable kernel based off-cpu analysis"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f818ab6b662..8ba890a5ac6e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -862,6 +862,8 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		attr->exclude_callchain_user = 1;
 	if (opts->user_callchains)
 		attr->exclude_callchain_kernel = 1;
+	if (opts->off_cpu_kernel)
+		attr->off_cpu = 1;
 	if (param->record_mode == CALLCHAIN_LBR) {
 		if (!opts->branch_stack) {
 			if (attr->exclude_user) {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..cfa5e34b78ad 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -52,6 +52,7 @@ struct record_opts {
 	bool	      kcore;
 	bool	      text_poke;
 	bool	      build_id;
+	bool	      off_cpu_kernel;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
-- 
2.39.0


