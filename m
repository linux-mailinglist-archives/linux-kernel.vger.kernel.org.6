Return-Path: <linux-kernel+bounces-317814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A238296E405
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61562287FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0CA1B984D;
	Thu,  5 Sep 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny2MK3o2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AD1B6552;
	Thu,  5 Sep 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567876; cv=none; b=eyygs96cww0jFkRHyIrqik9XOiUzMJqRj9i07L21EcGzaOR687PT4Dwlst7V4F7lw+zycWoOctJV0tyHmrN3/QNZ68pvR57FUuyYCGNTQ5XmwnL0O4s7SBug8pOxifCIyDQKP04edhQODZwubRyeXEEDqPAYDPXKHGng5fNWJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567876; c=relaxed/simple;
	bh=357L4htyQZgC3GnbOdl4w0QF9QxWOkOrNAzwRiz9rSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Orj7av7RW15/HyRA5whZV2c1rkdoqVKMe0+o157xG6EFtlu9aKn6EJio92kV+yVK3X4nDoDI2S1LFMPhQL1yTTh6RrVWzaRMnGdfnDFmtOkT6MI5Y1SABaclJvR55s+hC86bmp33owQSRYLAhsQM5YHZSadlkkidmOw+VPPMqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny2MK3o2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4798FC4CEC7;
	Thu,  5 Sep 2024 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567875;
	bh=357L4htyQZgC3GnbOdl4w0QF9QxWOkOrNAzwRiz9rSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny2MK3o21J3gK1zGAJWYQ+5c3yVBaKmkgaAc0XtZmrrYPQtZU02D/aKGOD23HP2N8
	 S2YJOUkiJbBpNvUAIxE+N8XdJR/+0fL8dYSZGY9uySrROs6Q3MXHDF8x65FaeU+zyu
	 4fLB+emEK5k7CV7hhkjY5luYeKjH7NjFr5ZUA9qEsSJ3EkT2b/TgiBaL9Aq/XvkgNl
	 fgUj9oU4Y7LhcktRjbJw+HBjmkndbiiWeIjUUXvov4wYLhBDasRm6xENp4cTmirPRB
	 asdiLRubu8YJw+/irf3WbXQAUFNxkwrdGPMzbVHx11qcvhXAiDIEQ0kR7fPpHP0Qzr
	 G6l1jBP7D1ifg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 10/10] perf record: Just use "cycles:P" as the default event
Date: Thu,  5 Sep 2024 13:24:26 -0700
Message-ID: <20240905202426.2690105-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905202426.2690105-1-namhyung@kernel.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fallback logic can add ":u" modifier if needed.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c1f4c..f8325247292112d7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4157,9 +4157,7 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-
-		err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		err = parse_event(rec->evlist, "cycles:P");
 		if (err)
 			goto out;
 	}
-- 
2.46.0.469.g59c65b2a67-goog


