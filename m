Return-Path: <linux-kernel+bounces-368905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFFF9A164D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CFFB2199E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6D1D54EE;
	Wed, 16 Oct 2024 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRElqKO/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90D1D5CC6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122995; cv=none; b=pfAAq0IncoV0NCKJ2Zn/Ed3K/xyOnYU3JDdP4PxHQ85mZGJTl4j56xLntzEL3d2OxWp08KaF+ODeOReGTKnTRKqKnLYDNiA5hl2LtzPhzhryqLVlko0rlRXFvoTRfoTogP8T+EKxV7It/A9QQeOflV3GmEgh1+dpe1pIzlNEq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122995; c=relaxed/simple;
	bh=omcWxiXpXpDDa4ZVpdZVs6jD5U2YVU0SYavMpap6ToY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cUqSUEisaKaq45AeV9nDSNB4+Y5l/XSQoNTasrwNUZVJDDtm2TlQmibTjalv8qyj//wi4QETOTI3PqQODJQgf5yX0F26xeGE5CFNXboztuOhzuaeeAjlg8vyC1Lc/hwHeIB/FK30QWK460tyDhri3veMK1YJZ3pFmL4fW0ZIyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRElqKO/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d660a1afso9564317b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729122993; x=1729727793; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wabyl6vUPXQ1+YQSrgl1FkBvVcBQXCA4B1RUIse2h6U=;
        b=HRElqKO/PUYfs0Xx+DgmaS2QqL/S0iCBZIpFc48TMQ89TN451krrXoMT64HiV/2k1O
         +Rykt8NjRkJ/1teMOrD8xEvPWAl/FY7Cqcp/W5tpN2OlzWBwJr/sTMZ3ifYkOmSn1Tsk
         DT1Rd8rb3ZOby+d6yXUXraUulWFsHhh6uB+RZQNzQ4CruozRUhxz9OBYuAK2vEEkqRD3
         WkZD8IqxYFM8+9yTyKLxTOeQVHjJiVf6kDCkMHDVUIHEQbEGbo15ER+DFuVKKyhSu3qS
         of3CVXJdybbG4D1HgMVY8z5LyIKVrfk7WcA54/7T6OiA9AsQdujAjIazX/70z7JFUP42
         yKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122993; x=1729727793;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wabyl6vUPXQ1+YQSrgl1FkBvVcBQXCA4B1RUIse2h6U=;
        b=RXEQE8AbQdfI01tCjV5fm2wYg4+JtrezAs0BZAjWfMuOaggsaygeozZTDfwkpM5rQY
         RcTVVZ3JLRRQbXvilHb9mmLSpnm2fhdwKucwD6GkVJkAJxmqasNXaWI2d3vmzIi5ady0
         y1DDk5CH1KOMIFPo1z/3hOwfnMhiHtfQ0036TvKXAIUkPIiZzumj7ielXMuDv5coJrPW
         jd8UKYil+0QMKYJodx3AIU3XpDfAlNrvnubfVp1rHUH/rc9hTFWXevzoB/W9sfRCZen9
         bhRJyl6gprh09DYXO1bDigJVM8tO1meHWySsKnGnV4xkvlzv49zjjtsa7l+Z/aUwDxf7
         dziw==
X-Forwarded-Encrypted: i=1; AJvYcCXDETCI4y4ocnoeN9mXrgYDY0IyHmEk1Z5HWMQ+AP6rX+EdGSuT96v4xKGdi/NVkAtV8UjfJUAvQvDqn/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHeWE4WPAhYQtoWS1KHflnuQnsVT7Sps9Mpsen4SSF64bh+31
	SdrHUmctnTrQCXyP6o2EFnadjYfcFceW6dgA48M8bXtF0PieL7+2qs/GPYtrU9eMNRMzElefDfu
	w0KR48Q==
X-Google-Smtp-Source: AGHT+IEc9gz97uCSiFecHFVOHpY1dtbfP8iNOaE7ecAshb1/kQg9gQzEYtMNAJhhFL7iChcFMwUXc0CDZ/mR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:74c7:b0:6e3:39e5:f0e8 with SMTP
 id 00721157ae682-6e3d41c6eacmr1682517b3.6.1729122993551; Wed, 16 Oct 2024
 16:56:33 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:56:22 -0700
In-Reply-To: <20241016235622.52166-1-irogers@google.com>
Message-Id: <20241016235622.52166-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016235622.52166-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v2 2/2] perf probe: Fix libdw memory leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing dwarf_cfi_end to free memory associated with probe_finder
cfi_eh which is allocated and owned via a call to
dwarf_getcfi_elf. Confusingly cfi_dbg shouldn't be freed as its memory
is owned by the passed in debuginfo struct. Add comments to highlight
this.

This addresses leak sanitizer issues seen in:
tools/perf/tests/shell/test_uprobe_from_different_cu.sh

Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_frame sections for probe location")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/probe-finder.c | 4 ++++
 tools/perf/util/probe-finder.h | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 630e16c54ed5..d6b902899940 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1379,6 +1379,10 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	if (ret >= 0 && tf.pf.skip_empty_arg)
 		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
 
+#if _ELFUTILS_PREREQ(0, 142)
+	dwarf_cfi_end(tf.pf.cfi_eh);
+#endif
+
 	if (ret < 0 || tf.ntevs == 0) {
 		for (i = 0; i < tf.ntevs; i++)
 			clear_probe_trace_event(&tf.tevs[i]);
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 3add5ff516e1..724db829b49e 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -64,9 +64,9 @@ struct probe_finder {
 
 	/* For variable searching */
 #if _ELFUTILS_PREREQ(0, 142)
-	/* Call Frame Information from .eh_frame */
+	/* Call Frame Information from .eh_frame. Owned by this struct. */
 	Dwarf_CFI		*cfi_eh;
-	/* Call Frame Information from .debug_frame */
+	/* Call Frame Information from .debug_frame. Not owned. */
 	Dwarf_CFI		*cfi_dbg;
 #endif
 	Dwarf_Op		*fb_ops;	/* Frame base attribute */
-- 
2.47.0.105.g07ac214952-goog


