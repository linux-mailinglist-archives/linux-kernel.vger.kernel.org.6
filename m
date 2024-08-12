Return-Path: <linux-kernel+bounces-283133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FC194ED9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7981F21263
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40417BB24;
	Mon, 12 Aug 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK5dYyI9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA917A92E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467814; cv=none; b=XE/XmZs3TfagwLBhL4HKQGEZ0VJK80RYHskAJ21nuGp3MUO2EttZ116q/4jIpAL8QhOAulMWDUw9Qgb6XvCOt8gGfbR6Qq40lJ5O1FYOs8VbDrvjCahxzXL6GgHemABzMw9uJ3Eu78CRxwpD2/M8FJPet4fqgS3RQ4wV8ulQ3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467814; c=relaxed/simple;
	bh=qwQziir18Yd/n1T1BKzvvtD5w6WMoxGdTA0IkQ4rfis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GPonNcyu1O5AUBnkH2yebePya/Wjz6IFFbnQHXuUUJC0BFYoxiYrCP9WfZ4GQEfo7AOaeHxjo/BsCm6H0ZHb8xwSmfCCzn0JhQ8KqHD77N5oYMtk4hMaSsyLtoskLJR+wucI9KA3BfejrQX97JSLr2JfTEgw7PnEv2vK2cbJGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK5dYyI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B361DC32782;
	Mon, 12 Aug 2024 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723467813;
	bh=qwQziir18Yd/n1T1BKzvvtD5w6WMoxGdTA0IkQ4rfis=;
	h=Date:From:To:Cc:Subject:From;
	b=DK5dYyI9Pqo/2uvVG1GBYyLj+fsDxWyK9lIHNEgus6oVch2wyD0T9ur0x8QCTwgEk
	 z/u+fW7kxDI5ukA3tGk/VBB9MU76HSMS6O8pih6rxblF3bTaWLn0w+GP+NlpoC1t2E
	 qkaSYUjKvVxmOXWU8EpAcHDOMt7ZTQznKjsvfvNv8T6DaLsPdmA4uBYRWPG44FVEQY
	 43AAlE+bGlkK0qihnLC0Bv6+fYfVYUe+w8xSfW6Gf49khKZI1fim+zXN8HVPAz42ke
	 /KfVafTpLfuq9UkGP4bo0X+ok48QhEDNpA2Vxk4ssi769ZiuNOzGjIVP43+sHOAZ/1
	 abQ2IoMM9u82g==
Date: Mon, 12 Aug 2024 10:03:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Radostin Stoyanov <rstoyano@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf tests pmu: Initialize all fields of test_pmu
 variable
Message-ID: <ZroIIXkmErNGZjQO@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Instead of explicitely initializing just the .name and .alias_name,
use struct member named initialization of just the non-null -name field,
the compiler will initialize all the other non-explicitely initialized
fields to NULL.

This makes the code more robust, avoiding the error recently fixed when
the .alias_name was used and contained a random value.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Radostin Stoyanov <rstoyano@redhat.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index a4730b5dc0d9259d..be18506f6a242546 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -458,10 +458,10 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
  */
 static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct perf_pmu test_pmu;
-	test_pmu.alias_name = NULL;
+	struct perf_pmu test_pmu = {
+		.name = "pmuname",
+	};
 
-	test_pmu.name = "pmuname";
 	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
 	TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
 	TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),	     false);
-- 
2.45.2


