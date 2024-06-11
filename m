Return-Path: <linux-kernel+bounces-209260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE3902FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8909D284EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA57170843;
	Tue, 11 Jun 2024 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2F3NPmW3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762316F839
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718082394; cv=none; b=sSgGHZq/h31iXBqRlByIwgug5uDNi0pR+d3sVpFHO/Pl4/yjXuF3DDLXjeCgPBxlbgXxOXdN3xQjNP4jGpatx3EYEwx+NujnXasxlbQO+yuyS4VriEvu0KBMTpdb28zyvsVox3mQxnOILu6j7Qs1DHVaVPJ0FPyRLiUtOyhoyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718082394; c=relaxed/simple;
	bh=wfNuKcpCIlJrJwk/H9c5ECx+DB/Jmr1J+PH6oJRL3D8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=pwzusY1abkCK9WPWh+cXtvU0mRz/jTgeoolA0mQdD+H+MEG0TX1WjJNv7tgH2Ez1C/sz0cdR101koEVshRUvT545kP/0v0KME5/z2+nqqn934O1NaRvTDHzEsdE8p9h9IWSz8BVoEs+Gn6m5HWo55CbaVhRWBPGMCdmM04jrpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2F3NPmW3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa5743655eso1113822276.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718082391; x=1718687191; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3a15i1kZLc+SlZ1Pt4nlLZoYgpbJp0ryg7Wc92RcD0=;
        b=2F3NPmW3ZmyZrjm4bHPMHH7mOM8vIHsa82heL4MG6HcQaZ5z+zCZzIvcZxToQdEBFK
         g6QyoDYeSrRoeibiKpcaiDxIJRUUaysI3WT/jH4qF3zRmClp1zSK9j3Jj0/1IBY7qXai
         M+TyBZ7gsqoMLT4D8yWWv3NFgSV+Mp+EsN53bRurvfwtJqM1KUL28rpn7o8dCoslSUni
         2MHEKuyQVz0HBnL5vhCoi7FUcAdJ0insN8NegGUhTlEESyyMVmPQJQoue0xNzxKhl9do
         gRbrMIakieJGiuNA5qjGWKWzjhIApppRo0DVNArLIC6Ejn9qX05b6CwDUa23SJ8z/039
         7pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718082391; x=1718687191;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3a15i1kZLc+SlZ1Pt4nlLZoYgpbJp0ryg7Wc92RcD0=;
        b=m8RPZVhX3hmy/IiO18wbITRJMWulxKnFiucdCpYcosMMOaWGE3SL7YB+MoeUZtirQh
         SN/ATBINKpVoERXE/WYr39cwv2nsXaW76z1XLFKbiTr2BkflHP4nfHYHMU7gjxCBEIy/
         pmYkzgDFuxICecBatwWFYrypG/u2r3tJ0b6CxDEZhQiKkgMqYp1+3ku6IXsS0FjVS7rV
         ACWj3pv/PFokrwB8KqV73xuA4fm0Ein5F4CH2JCG6BuzRUD3aEAFDnIjSAFGUmri0e8i
         awdBG9+9u8xyPcMizYx/dIZdCQicroD3xNQZ3iptIdhmVuzAIO0iE9+Wmsb8hB8W9o1g
         tH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXdNzLbjV4hgofLeVrjsWhj5sD40ivcerzyji75Iywv3uipO2ZREdXTuPHNy5b956tov1+J6bEnbDo76Un91DKgHfRR3Ernis2UYaj
X-Gm-Message-State: AOJu0Yx13LiB7siBwHquKjo6uLxiLEnp2VS0qq7PLc40KihaTD4578hU
	+6gbY46I4wq/T0AgfhVP0mcLON1zxnt5FcvGwf28K+NBHr78nF6cEq+0x0+Lz3xsFdID9YI5dpz
	YRzUHRQ==
X-Google-Smtp-Source: AGHT+IGXg6MLzJVlTMjDjK4qpsPZQJg7FjWAtts19sPLfAtFffF1hcAi5jMMDMTnaeXo/9ICiKULSK9UZPeY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b1e:6a57:2401:1e9b])
 (user=irogers job=sendgmr) by 2002:a05:6902:20c5:b0:df7:9ac4:f1b2 with SMTP
 id 3f1490d57ef6-dfaf64ec25cmr3405059276.5.1718082391082; Mon, 10 Jun 2024
 22:06:31 -0700 (PDT)
Date: Mon, 10 Jun 2024 22:06:26 -0700
Message-Id: <20240611050626.1223155-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v2] perf record: Ensure space for lost samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>
Content-Type: text/plain; charset="UTF-8"

Previous allocation didn't account for sample ID written after the
lost samples event. Switch from malloc/free to a stack allocation.

Reported-by: Milian Wolff <milian.wolff@kdab.com>
Closes: https://lore.kernel.org/linux-perf-users/23879991.0LEYPuXRzz@milian-workstation/
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Switch from union to struct and place struct in header to clearly
    tie it to the MAX_ID_HDR_ENTRIES.
---
 tools/lib/perf/include/perf/event.h |  6 +++++
 tools/perf/builtin-record.c         | 34 ++++++++---------------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ae64090184d3..37bb7771d914 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -77,6 +77,12 @@ struct perf_record_lost_samples {
 	__u64			 lost;
 };
 
+#define MAX_ID_HDR_ENTRIES  6
+struct perf_record_lost_samples_and_ids {
+	struct perf_record_lost_samples lost;
+	__u64 sample_ids[MAX_ID_HDR_ENTRIES];
+};
+
 /*
  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_LOST
  */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..019305b94e5f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1926,7 +1926,7 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 static void record__read_lost_samples(struct record *rec)
 {
 	struct perf_session *session = rec->session;
-	struct perf_record_lost_samples *lost = NULL;
+	struct perf_record_lost_samples_and_ids lost;
 	struct evsel *evsel;
 
 	/* there was an error during record__open */
@@ -1951,20 +1951,13 @@ static void record__read_lost_samples(struct record *rec)
 
 				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
 					pr_debug("read LOST count failed\n");
-					goto out;
+					return;
 				}
 
 				if (count.lost) {
-					if (!lost) {
-						lost = zalloc(sizeof(*lost) +
-							      session->machines.host.id_hdr_size);
-						if (!lost) {
-							pr_debug("Memory allocation failed\n");
-							return;
-						}
-						lost->header.type = PERF_RECORD_LOST_SAMPLES;
-					}
-					__record__save_lost_samples(rec, evsel, lost,
+					memset(&lost.lost, 0, sizeof(lost));
+					lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
+					__record__save_lost_samples(rec, evsel, &lost.lost,
 								    x, y, count.lost, 0);
 				}
 			}
@@ -1972,21 +1965,12 @@ static void record__read_lost_samples(struct record *rec)
 
 		lost_count = perf_bpf_filter__lost_count(evsel);
 		if (lost_count) {
-			if (!lost) {
-				lost = zalloc(sizeof(*lost) +
-					      session->machines.host.id_hdr_size);
-				if (!lost) {
-					pr_debug("Memory allocation failed\n");
-					return;
-				}
-				lost->header.type = PERF_RECORD_LOST_SAMPLES;
-			}
-			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
+			memset(&lost.lost, 0, sizeof(lost));
+			lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
+			__record__save_lost_samples(rec, evsel, &lost.lost, 0, 0, lost_count,
 						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
 		}
 	}
-out:
-	free(lost);
 }
 
 static volatile sig_atomic_t workload_exec_errno;
@@ -3198,7 +3182,7 @@ static int switch_output_setup(struct record *rec)
 	unsigned long val;
 
 	/*
-	 * If we're using --switch-output-events, then we imply its 
+	 * If we're using --switch-output-events, then we imply its
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
-- 
2.45.2.505.gda0bf45e8d-goog


