Return-Path: <linux-kernel+bounces-168824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F838BBE35
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E006728156F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2585262;
	Sat,  4 May 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxBl2fax"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325984E1F
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858698; cv=none; b=Tkibur/24Xy9gmJL2tYGkN2IJ9njtGfGykE6LDaanHgBwhnGb0XHz7vqAD4MRextceVdMVvzbb2NqkT2xhbuBeVRn3xGsamrGjV6XVBW7VvG3isYHm9XonZY7wk37Lz6X5yr/51KT21JubsRqqxAG7YOaSrKaiangKHdSX0OAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858698; c=relaxed/simple;
	bh=kEt5oxBRpAPMe2rNcv+ApHJyjJ2pzv3PLigiBoklsvA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JvayFkwmPp7rLMWPVPPT/b9vzeRYCb4dDuIt/HpvMBp68MKLVeu0ipeNwPuEaCi1quBFcsG698Bp0MhZtN0AJ1XIelqjmrxDzk9NiVgPkz3Brp2jGTz9TlPqXp7RS7cYq0FUXu5UIECIQ/KDoIYxCO97E1BF/ylYvYjkfbqY8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxBl2fax; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60321ce6cso1700002276.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714858695; x=1715463495; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tK8l9jOqWly8fdPJtG1rCuSTlU8WtxPA1AjehKR4OQ=;
        b=FxBl2faxllsKb9EItONwHHXKx9xGnoj+p+iAni/ds6tjjm0b4Tll2qCA8h09ZfYW3C
         8+SJlaJAT3bi8766fB9NYyZCtjkXkRmywNBu1XSKo1N1hPCbt6PLZI+5eyiPkjasgUoV
         9sdIqOi2j2/6UdhA21pxqk20RCTcUmYv48fLR7NDznm8G67jbmBh+wSvqQ08Xo8r4kV2
         BUrAx/w1u1cZlOm8Y6ZfzgRlMHUi7iRTYaDCIzkekP+U6AJkaHX/PU2YHLdaoJliHxIC
         kXjB1SAPzGXePaKd7ggQDbX0UW/2fdKh1R1k/eTNnFJmXFkUOcXY3sk3aEjX2X5xy0Do
         YS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714858695; x=1715463495;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tK8l9jOqWly8fdPJtG1rCuSTlU8WtxPA1AjehKR4OQ=;
        b=hVITURrM+f48Qth3NoUd7sZaupVPeb4jI3TVJyNBQYStKaBYjist6FeUh13QRviUg4
         pdmYs1d9mD6+m8ADE+D/KtwRL6Rc7j+cMqMpx8AzmZ2xRMTULihwLI4PndhFly8TLpT7
         mhC3xpJZp3g5nOEHpH22qlRAqrLz0LRYaKUPTfRHKkL5/+WC2qqEb7hgS9rdgWq1CS96
         5upHQYmfp4JkO/JPDEetAbwqwx6j9KCqZIgizpcQwDdvlTV6UYe/pEyWk62muWp0wSCP
         AXW4zGtnDIz9OxhoKK8A0B4Fv+fs/buSo6+2j80aB58JWuCmoOyC5S+waQ3Ivcz00wJ8
         97WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX6UMjuPhnjGq2omDumzSHtjGCQlWkfzJtV6oRgheYEj1YpLc4Zfo8tO93n+blW3HGsqNWLXNP8nfFnsNNnLAVI9WeMvJd1Ka5/kHe
X-Gm-Message-State: AOJu0YzusbF9+m5U0s9ZkXaKjHID0zzsMmWHSlThRIoOaFILcFLk4m7X
	fCd+PFmsleMMygF5iwEzE2HvopGZfLyzekOjGO9yIIcI4q4sgnIaGl9SqtMogWZ0t3qihPTsW/m
	koO9g/g==
X-Google-Smtp-Source: AGHT+IHguqBfViHx+DGOzbrxrwhbaxsbSFbbf5Ky4WfI2OBFiXGA7GKbgwbJqraCb6DhlxfYyMUZHr9fWj6c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:d233:ffdd with SMTP
 id w7-20020a056902100700b00dc6d233ffddmr2150340ybt.0.1714858695657; Sat, 04
 May 2024 14:38:15 -0700 (PDT)
Date: Sat,  4 May 2024 14:37:59 -0700
In-Reply-To: <20240504213803.218974-1-irogers@google.com>
Message-Id: <20240504213803.218974-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504213803.218974-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 3/7] perf dsos: Remove __dsos__findnew_link_by_longname_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function was only called in dsos.c with the dso parameter as
NULL. Remove the function and specialize for the dso being NULL case
removing other unused functions along the way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 51 +++++++++---------------------------------
 tools/perf/util/dsos.h |  6 -----
 2 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 89f87a197a44..e2ccceac7619 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -119,11 +119,6 @@ static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, stru
 	return rc ?: dso_id__cmp(id, &b->id);
 }
 
-static int dso__cmp_short_name(struct dso *a, struct dso *b)
-{
-	return __dso__cmp_short_name(a->short_name, &a->id, b);
-}
-
 static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 {
 	const struct dso *a = *((const struct dso **)va);
@@ -143,20 +138,21 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
  * Either one of the dso or name parameter must be non-NULL or the
  * function will not work.
  */
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked)
+static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
+					       const char *name,
+					       struct dso_id *id,
+					       bool write_locked)
 {
 	int low = 0, high = dsos->cnt - 1;
 
 	if (!dsos->sorted) {
 		if (!write_locked) {
+			struct dso *dso;
+
 			up_read(&dsos->lock);
 			down_write(&dsos->lock);
-			dso = __dsos__findnew_link_by_longname_id(dsos, dso, name, id,
-								  /*write_locked=*/true);
+			dso = __dsos__find_by_longname_id(dsos, name, id,
+							  /*write_locked=*/true);
 			up_write(&dsos->lock);
 			down_read(&dsos->lock);
 			return dso;
@@ -166,9 +162,6 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		dsos->sorted = true;
 	}
 
-	if (!name)
-		name = dso->long_name;
-
 	/*
 	 * Find node with the matching name
 	 */
@@ -178,31 +171,13 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		int rc = __dso__cmp_long_name(name, id, this);
 
 		if (rc == 0) {
-			/*
-			 * In case the new DSO is a duplicate of an existing
-			 * one, print a one-time warning & put the new entry
-			 * at the end of the list of duplicates.
-			 */
-			if (!dso || (dso == this))
-				return dso__get(this);	/* Find matching dso */
-			/*
-			 * The core kernel DSOs may have duplicated long name.
-			 * In this case, the short name should be different.
-			 * Comparing the short names to differentiate the DSOs.
-			 */
-			rc = dso__cmp_short_name(dso, this);
-			if (rc == 0) {
-				pr_err("Duplicated dso name: %s\n", name);
-				return NULL;
-			}
+			return dso__get(this);	/* Find matching dso */
 		}
 		if (rc < 0)
 			high = mid - 1;
 		else
 			low = mid + 1;
 	}
-	if (dso)
-		__dsos__add(dsos, dso);
 	return NULL;
 }
 
@@ -240,12 +215,6 @@ int dsos__add(struct dsos *dsos, struct dso *dso)
 	return ret;
 }
 
-static struct dso *__dsos__findnew_by_longname_id(struct dsos *dsos, const char *name,
-						struct dso_id *id, bool write_locked)
-{
-	return __dsos__findnew_link_by_longname_id(dsos, NULL, name, id, write_locked);
-}
-
 struct dsos__find_id_cb_args {
 	const char *name;
 	struct dso_id *id;
@@ -279,7 +248,7 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
 		return args.res;
 	}
-	res = __dsos__findnew_by_longname_id(dsos, name, id, write_locked);
+	res = __dsos__find_by_longname_id(dsos, name, id, write_locked);
 	return res;
 }
 
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index d1497b11d64c..6c13b65648bc 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -36,12 +36,6 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked);
-
 size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
 size_t dsos__fprintf(struct dsos *dsos, FILE *fp);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


