Return-Path: <linux-kernel+bounces-255769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477739344E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6271F223AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36433CC4;
	Wed, 17 Jul 2024 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkZC3Wm/"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4B41C6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256461; cv=none; b=VIgEKDIXhPqgPBOJl3GSTH9x86BZYgF/isDEXQeK1kIEyQDh6lh+BHMt80tCwCfA/kT1mr6rglxVqCa3cpSamxIPNGg4m0AJwzZO4ZbmlDRsPjGPI9+UlEkedu9ObDuVhD/DgIsJzNtlx3QHRZPajCzTWJQiI+YffnfQCGyLf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256461; c=relaxed/simple;
	bh=wsjyhZb/PdOtvGe00zDU9jMHxWauNU8sJZPK/PLxFSE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jtoqxwG302w4bfJf+SJAzkeJ1E5ws/eh4aa6KV6XL8tsibTeS5+4CfewXjNP02J/WRSBObytoMkHU7/rWi15Z53HmEpv45EJDnDco7ZL3d0WVXlOAn77LRbvUKYkMt8xdLVhkFGp4SQJXEoKzLZ11mOSmuIxAzdhbMFiO80LUN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkZC3Wm/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e036440617fso514566276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256458; x=1721861258; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIiZO/q4iRQZ7Xs1eg6KNaj9S7BXW+wk4oVE8PU2qN4=;
        b=mkZC3Wm/ZEGrsFjtlijyHyGoj+jtUPcLrUOG8cTpDWViOO0+/F5nvYlP/kwg305B3d
         fZgWU14bYRbfy1PWNUgVa99mpEWjx8bs1TGBEJajt8w0ukeabq5crPWPVEqjFnBxZ+Jr
         duSPj7udoBCSi1dn9K/2vHFRO1H4t4ppRJMf4giU7fPb42Df+S7fUxLsjEOEdT58lkty
         vLi/EmOKswF3zWOBk41NNmfd3LloS6yHNSneEN3B02mPcaq389/0yfq9RQcl0XBhVOHF
         INv5WEUgWRS3TW+OVsCJirqSuMXjOi3N70rJH/JrpFQPFBTLuE32heIbPrPetQMfIORj
         Ponw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256458; x=1721861258;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIiZO/q4iRQZ7Xs1eg6KNaj9S7BXW+wk4oVE8PU2qN4=;
        b=nDsnEH7MJwhCH/Ep4n4Ow+mY4SnB27TLDdtZktEpjalRf3s5v0OnTafQsoSOsNrIet
         4+VenKPEURMCsyf0jr+RCpuiz2RrBBWsFqscsKnFX78jD+QUihn9dK04Ld5OiFDobTCH
         N02+YVnEyoik3WhTf7X/iNRNxS7Nnp8462FkfHEGm1Lw6t1+uukRtKcctRGq718NtOhi
         ePeAJEKjj6GdeW1Z6hflJmg4eytNxy9d8Wrl0VlCxM8trXjkL3SyNvfiZL+8Gvsnf8az
         PH4gJxO1gk6BseAQwEEMPSys0Mgh+hoJiPmQCyXz/iTxquQNUbktk6R5O+PDCK6l8Che
         asZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRZPpIfbghQm+bEQ1Rg5mZrTpkY2ui2zOdbkz4qZ+DPK1dhR3HOuS1JLI3JCfPVI09kpMVa29b24t2DRMg2LXt9vV1xXDY2ICPs2pY
X-Gm-Message-State: AOJu0Yx6HhtEIP6OXWtcCIh9xBCFJktc14Fb3zgljupZaJVfv/5Qzitm
	NywaDNB514eFcTB+7eSpfLvoyzM9goZd/tlDpCh4cE1UoFunvr3XBM68kUSkSRyQ/Zshy2fbR99
	Gkub1IA==
X-Google-Smtp-Source: AGHT+IFnGIUQ2lhFZ36vDL4qvcmKR2SRBmLdlfHXveMflrvn4LzP54FxAZZnQ/WKEs62+RfsoHjLnbI9BV34
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d86:b0:e03:6405:7428 with SMTP
 id 3f1490d57ef6-e05febedf75mr2558276.12.1721256458202; Wed, 17 Jul 2024
 15:47:38 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:27 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 1/6] perf pmu: Merge boolean sysfs event option parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

Merge perf_pmu__parse_per_pkg and perf_pmu__parse_snapshot that do the
same parsing except for the file suffix used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 47 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 986166bc7c78..5148b6639dd3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -367,8 +367,8 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *ali
 	return -1;
 }
 
-static int
-perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+static bool perf_pmu__parse_event_source_bool(const char *pmu_name, const char *event_name,
+					      const char *suffix)
 {
 	char path[PATH_MAX];
 	size_t len;
@@ -376,37 +376,36 @@ perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.per-pkg", pmu->name, alias->name);
+		return false;
+
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.%s", pmu_name, event_name, suffix);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
-		return -1;
+		return false;
 
-	close(fd);
+#ifndef NDEBUG
+	{
+		char buf[8];
 
-	alias->per_pkg = true;
-	return 0;
+		len = read(fd, buf, sizeof(buf));
+		assert(len == 1 || len == 2);
+		assert(buf[0] == '1');
+	}
+#endif
+
+	close(fd);
+	return true;
 }
 
-static int perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+static void perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
-	char path[PATH_MAX];
-	size_t len;
-	int fd;
-
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.snapshot", pmu->name, alias->name);
-
-	fd = open(path, O_RDONLY);
-	if (fd == -1)
-		return -1;
+	alias->per_pkg = perf_pmu__parse_event_source_bool(pmu->name, alias->name, "per-pkg");
+}
 
-	alias->snapshot = true;
-	close(fd);
-	return 0;
+static void perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+{
+	alias->snapshot = perf_pmu__parse_event_source_bool(pmu->name, alias->name, "snapshot");
 }
 
 /* Delete an alias entry. */
-- 
2.45.2.1089.g2a221341d9-goog


