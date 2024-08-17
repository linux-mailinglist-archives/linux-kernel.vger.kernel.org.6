Return-Path: <linux-kernel+bounces-290571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9139555D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A307B1F2480E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0001474A9;
	Sat, 17 Aug 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnhwGqYx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17084146A76
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877124; cv=none; b=bJhIXjuhfThtIKiwzu4N44AE9bve+Ai5bWqcOMtmYU1GB7UvLak0qXFSZxF15Fu9j1Plbc70EBiowyoE21QbF0lyNoLA2XJVnC2hAltdg+jwBkcndURm8qt4YyI3pVIP7WDiWQY4dSwdLl5lXBMk+0OpPHljMhuaZXe3EqCmS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877124; c=relaxed/simple;
	bh=cjMuPQXu9IACAGVGoPDWUv1/bqr9YjWSdf2bVeZ3IZE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LF67eftHUeadKpETwXZaynzo6p2iZdGdMtRcp7s2unYbjGn004aDKTWMBni9nOZZYzOyWtjeSHdQPNxQNwJv7ZyaCrEggSoUb6Zeu14xFmnWUFUjEv9frZQrk4SoQmZ4ksEAhgwjZORJC012unOw96TzHmG2qthrUW2uRYcNx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnhwGqYx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso5057934276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877122; x=1724481922; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lk32N9pvvuO1iq6Lb13ZpGlJ9Q0Am70MOwkGMMj+lus=;
        b=SnhwGqYxAgJeqgBs2u0D396C4z4VWTOGg54LmfCqihW/dd7j+I2X7M7nc7AuBFWL31
         aZ/FHxC4PM4lyyg8+n6JYCUeyQTrwzvVjEEcXYLgrJHH94uGV/Toj/s6tOFvkadEcZjf
         2M0ulcaAmuSA+CClJWFHXZGpw8Q7JpRhSxyJ96G86lbmYMpo6SgKvQpe5W4jSg/fsXiX
         +HglOG6Bo2/SNZUVTwJFPdqZju28fHjZL399XkGaWRxrJj8mKU8+uxhbVHs5laXhlkjo
         etGXXpT6MJ58jjUX3oRaG30Q6zSRX8YtwZ34dxOofyFfRve5YDN2vNgsv9y8DdAqqVYt
         X4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877122; x=1724481922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lk32N9pvvuO1iq6Lb13ZpGlJ9Q0Am70MOwkGMMj+lus=;
        b=ZH/2gHwelwJinp6MBmI9nScrZ+lmAHI63TkDYTfj7CfjzqaoXAcVcTuIZ+FGBVr+vu
         NWT/9ZuW+Ct6F4FWck2XsPztTN3ih/Am0pD8dUmsRcayM0Tm15yeXAoh1pooe+KI5Is7
         HdMkIMwuu7Htl12CbyWjHwG9oM+1rl5ymJlH1SxiwH3tnCJB0Levp8Nju3JGWSp+kQiw
         iNAtow2tFXhyzMK3A6iuCbCMG/AMrCfJCHMVJgWI9ODkYgiF4/GpGoAZfaOVe/xo6JDL
         DXEl4PdMLIVssSoCydJt31LWDUF7yU87AsCA3czWmIRC8fN5vjwfW8lzOPL5pgdwl0Zh
         mnFA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcp9s3tFRBrle/ObbhURYh7A3zc92uYUoEJZyVpCUtwazk+xq2SIgZQnN5WHydF7PBByXRtM7tnSypx0Dh7AHVmLFPWKPnSVDHmeH
X-Gm-Message-State: AOJu0YyacLhF/yzs5gKhjz42sdxJgZuAXxSnM2a5cxPOqGtSrhcwuUan
	/rDtj26PDceWTP09Q2Z5HIfCOgiBGJ/3Vd4RTh8mPIXa13SP/84SGJdRXNG6MnjJAYELM2BcaI3
	xnIwqbQ==
X-Google-Smtp-Source: AGHT+IFvfA7vAmjPNZy7qGhrh2RYYfzoR7Jxn8U6eVGXjUE8Vjbs6B8sZflti14WgVmg+rH5R96N86Y6/l68
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a25:26c9:0:b0:e08:5ee3:7a18 with SMTP id
 3f1490d57ef6-e1180e9d382mr253251276.5.1723877122126; Fri, 16 Aug 2024
 23:45:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:38 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 09/13] perf inject: Combine mmap and mmap2 handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The handling of mmap and mmap2 events is near identical. Add a common
helper function and call that by the two event handling functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 118 +++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 62 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d99868953ff2..a7c859db2e15 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -422,55 +422,21 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	return dso;
 }
 
-static int perf_event__repipe_mmap(const struct perf_tool *tool,
-				   union perf_event *event,
-				   struct perf_sample *sample,
-				   struct machine *machine)
-{
-	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-
-#ifdef HAVE_JITDUMP
-	if (inject->jit_mode) {
-		u64 n = 0;
-		int ret;
-
-		/* If jit marker, then inject jit mmaps and generate ELF images. */
-		ret = jit_process(inject->session, &inject->output, machine,
-				  event->mmap.filename, event->mmap.pid, event->mmap.tid, &n);
-		if (ret < 0)
-			return ret;
-		if (ret) {
-			inject->bytes_written += n;
-			return 0;
-		}
-	}
-#endif
-	if (inject->build_id_style == BID_RWS__INJECT_HEADER_ALL) {
-		struct dso *dso = findnew_dso(event->mmap.pid, event->mmap.tid,
-					      event->mmap.filename, NULL, machine);
-
-		if (dso && !dso__hit(dso)) {
-			dso__set_hit(dso);
-			dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
-		}
-		dso__put(dso);
-	} else {
-		/* Create the thread, map, etc. Not done for the unordered inject all case. */
-		int err = perf_event__process_mmap(tool, event, sample, machine);
-
-		if (err)
-			return err;
-	}
-	return perf_event__repipe(tool, event, sample, machine);
-}
-
-static int perf_event__repipe_mmap2(const struct perf_tool *tool,
-				   union perf_event *event,
-				   struct perf_sample *sample,
-				   struct machine *machine)
+static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
+					  union perf_event *event,
+					  struct perf_sample *sample,
+					  struct machine *machine,
+					  __u32 pid, __u32 tid, __u32 flags,
+					  const char *filename,
+					  const struct dso_id *dso_id,
+					  int (*perf_event_process)(const struct perf_tool *tool,
+								    union perf_event *event,
+								    struct perf_sample *sample,
+								    struct machine *machine))
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct dso *dso = NULL;
+	bool dso_sought = false;
 
 #ifdef HAVE_JITDUMP
 	if (inject->jit_mode) {
@@ -479,7 +445,7 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 
 		/* If jit marker, then inject jit mmaps and generate ELF images. */
 		ret = jit_process(inject->session, &inject->output, machine,
-				event->mmap2.filename, event->mmap2.pid, event->mmap2.tid, &n);
+				  filename, pid, tid, &n);
 		if (ret < 0)
 			return ret;
 		if (ret) {
@@ -489,33 +455,26 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 	}
 #endif
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
-				  event->mmap2.filename, NULL, machine);
+		dso = findnew_dso(pid, tid, filename, dso_id, machine);
+		dso_sought = true;
 		if (dso) {
 			/* mark it not to inject build-id */
 			dso__set_hit(dso);
 		}
 	}
 	if (inject->build_id_style == BID_RWS__INJECT_HEADER_ALL) {
-		if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
-			struct dso_id dso_id = {
-				.maj = event->mmap2.maj,
-				.min = event->mmap2.min,
-				.ino = event->mmap2.ino,
-				.ino_generation = event->mmap2.ino_generation,
-			};
-
-			dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
-					  event->mmap2.filename, &dso_id, machine);
+		if (!dso_sought) {
+			dso = findnew_dso(pid, tid, filename, dso_id, machine);
+			dso_sought = true;
 		}
+
 		if (dso && !dso__hit(dso)) {
 			dso__set_hit(dso);
-			dso__inject_build_id(dso, tool, machine, sample->cpumode,
-					event->mmap2.flags);
+			dso__inject_build_id(dso, tool, machine, sample->cpumode, flags);
 		}
 	} else {
 		/* Create the thread, map, etc. Not done for the unordered inject all case. */
-		int err = perf_event__process_mmap(tool, event, sample, machine);
+		int err = perf_event_process(tool, event, sample, machine);
 
 		if (err) {
 			dso__put(dso);
@@ -526,6 +485,41 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 	return perf_event__repipe(tool, event, sample, machine);
 }
 
+static int perf_event__repipe_mmap(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	return perf_event__repipe_common_mmap(
+		tool, event, sample, machine,
+		event->mmap.pid, event->mmap.tid, /*flags=*/0,
+		event->mmap.filename, /*dso_id=*/NULL,
+		perf_event__process_mmap);
+}
+
+static int perf_event__repipe_mmap2(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct dso_id id;
+	struct dso_id *dso_id = NULL;
+
+	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
+		id.maj = event->mmap2.maj;
+		id.min = event->mmap2.min;
+		id.ino = event->mmap2.ino;
+		id.ino_generation = event->mmap2.ino_generation;
+		dso_id = &id;
+	}
+
+	return perf_event__repipe_common_mmap(
+		tool, event, sample, machine,
+		event->mmap2.pid, event->mmap2.tid, event->mmap2.flags,
+		event->mmap2.filename, dso_id,
+		perf_event__process_mmap2);
+}
+
 static int perf_event__repipe_fork(const struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
-- 
2.46.0.184.g6999bdac58-goog


