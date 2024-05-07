Return-Path: <linux-kernel+bounces-171988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE88BEB89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00A22849FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CD16EC01;
	Tue,  7 May 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kB+S1fFg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46B16D9A3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106978; cv=none; b=aDc8oYfL4qWLz4Cu9Rq6sX7eFA3SImOGUUfFnOcJBa0xrsoc70mmUU8ZBBjgDLEm0uztrmPxxOHUO/+FS6sg66EAzr2eWNU7jPdF3uSae5Gxedzm3qKZvC8jlu94yn6M+R78e3in0fCN9y69uj2qHYBPYSRO6Ap5sMMR1WIz258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106978; c=relaxed/simple;
	bh=GdnXBlmAE/ntKP2kVuNH3THPlufy55dC+LYYiErZWGg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ajKuAATdCX74XTwfInbPj8y682TQZApLfGNfqIoG2EhLd7J6uOpN96vEwEKGggOymJTv8PwWNUTN390NxzOJ830IhxGJNHrRO0FIu7aDSkrep/0mwzWHlclin/Upt6YOzwUBKfWpzgXS0GrQ0E0gZBleQJH06VXRfKxx1hVqQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kB+S1fFg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bef0accddso83574027b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106975; x=1715711775; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ms66x72omLOauhEObyEV3CdvhbmbYUxAmhVXEPvxa8o=;
        b=kB+S1fFgjdrjl4vw4Hyydz9HgMpq3SO7w0Qc8kduok9XfcT6WLwrtMh8TyS3Du9PG8
         eue9dgOAgHYmsMMr5S/QD5ndQ6652DAfq8A6LsRXJ0BHSAKdfFXHRPYTHhXXfwWhiJCp
         itAqIQIjsCHWqIhXiFtkCtPbMXmd923St8Zhcn11BHNUdcv+gKH93cKYf6YDaO6KRneH
         sTJ3XEXdEK1ag94zGx9V+NTLi2Nfn8DLWZm4Yg4r3ix2SKZwLZN135KlzTWs8t2foQW7
         HsmccQWZEfJz1PkhWKh8wX6ag6oYPhaDrG8iVcjw2/pkRp0CvJbBrT8VD+PIRTaOU1Fb
         k8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106975; x=1715711775;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms66x72omLOauhEObyEV3CdvhbmbYUxAmhVXEPvxa8o=;
        b=aMd3tkL709c3loyCGQwqnjZYRG8IUST2sVh4OSp4twtOmEJTatXOC8jbran7d5V19K
         Hp2z5aaI3FL0dC2ndjMI18YjCyot8oLZ4wX3KXI79GkYo7v3cFj9nOG7fBVbksxyB+ye
         Q+P8xz9aB+vpEPlGQfpNFTh2wFS8rnd/rutKSSUx81LXKc4zKRvPNjTj2GXJo3NhuLQ6
         Ogt5iE/GHlG0y093rodqaecjcmc4fz9McbPoM0NMvVu3typmDx/x2CEKK7sQSLg7uJvz
         Np3fwS7H9BywPuZ2u9O0Y3maxsM60ViDqY0L07DvBX6n0NMMC1YCj3j5avd97XftX7SD
         D+fg==
X-Forwarded-Encrypted: i=1; AJvYcCXHzLOSlhBuAjNo9jXC2vChS0i+vRjeFyhX4yY8rpmtgNHhyDO72vf0aAixwLv+tE2PLfs+ZDRrqTF88CPxpGWK/2wIL3Pn40G9yDA8
X-Gm-Message-State: AOJu0YxXS2xTm3Xsg1NlswqBGLYUGMEcSd1qY0Ytigwh3URmz1isfsEu
	4+7AyqnTaA5JY+abuBIQephx5pN9II0Njd0AXLkOTbUdcRQixdaR6gMOuoKYNcDWVgeY6w9SExi
	f9DVM5g==
X-Google-Smtp-Source: AGHT+IH16GvFxGhrwVw9WdoofjsLZKY8qncsXUGb7ANehn5um8r0T3AOxjJ0h61G3bkWW9n6wgEUdS4unUVM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a81:6d92:0:b0:61b:e2eb:f05 with SMTP id
 00721157ae682-62085a414ebmr1542497b3.2.1715106975262; Tue, 07 May 2024
 11:36:15 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:42 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 5/8] perf comm: Add reference count checking to comm_str
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reference count checking of an rbtree is troublesome as each pointer
should have a reference, switch to using a sorted array. Remove an
indirection by embedding the reference count with the string. Use
pthread_once to safely initialize the comm_strs and reader writer
mutex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 196 ++++++++++++++++++++++++++---------------
 1 file changed, 126 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index afb8d4fd2644..1aa9a08e5b03 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -1,108 +1,164 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "comm.h"
 #include <errno.h>
-#include <stdlib.h>
-#include <stdio.h>
 #include <string.h>
+#include <internal/rc_check.h>
 #include <linux/refcount.h>
-#include <linux/rbtree.h>
 #include <linux/zalloc.h>
 #include "rwsem.h"
 
-struct comm_str {
-	char *str;
-	struct rb_node rb_node;
+DECLARE_RC_STRUCT(comm_str) {
 	refcount_t refcnt;
+	char str[];
 };
 
-/* Should perhaps be moved to struct machine */
-static struct rb_root comm_str_root;
-static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
+static struct comm_strs {
+	struct rw_semaphore lock;
+	struct comm_str **strs;
+	int num_strs;
+	int capacity;
+} _comm_strs;
+
+static void comm_strs__init(void)
+{
+	init_rwsem(&_comm_strs.lock);
+	_comm_strs.capacity = 16;
+	_comm_strs.num_strs = 0;
+	_comm_strs.strs = calloc(16, sizeof(*_comm_strs.strs));
+}
+
+static struct comm_strs *comm_strs__get(void)
+{
+	static pthread_once_t comm_strs_type_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&comm_strs_type_once, comm_strs__init);
+
+	return &_comm_strs;
+}
+
+static refcount_t *comm_str__refcnt(struct comm_str *cs)
+{
+	return &RC_CHK_ACCESS(cs)->refcnt;
+}
+
+static const char *comm_str__str(const struct comm_str *cs)
+{
+	return &RC_CHK_ACCESS(cs)->str[0];
+}
 
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
-	if (cs && refcount_inc_not_zero(&cs->refcnt))
-		return cs;
+	struct comm_str *result;
+
+	if (RC_CHK_GET(result, cs))
+		refcount_inc_not_zero(comm_str__refcnt(cs));
 
-	return NULL;
+	return result;
 }
 
 static void comm_str__put(struct comm_str *cs)
 {
-	if (cs && refcount_dec_and_test(&cs->refcnt)) {
-		down_write(&comm_str_lock);
-		rb_erase(&cs->rb_node, &comm_str_root);
-		up_write(&comm_str_lock);
-		zfree(&cs->str);
-		free(cs);
+	if (cs && refcount_dec_and_test(comm_str__refcnt(cs))) {
+		struct comm_strs *comm_strs = comm_strs__get();
+		int i;
+
+		down_write(&comm_strs->lock);
+		for (i = 0; i < comm_strs->num_strs; i++) {
+			if (comm_strs->strs[i] == cs)
+				break;
+		}
+		for (; i < comm_strs->num_strs - 1; i++)
+			comm_strs->strs[i] = comm_strs->strs[i + 1];
+
+		comm_strs->num_strs--;
+		up_write(&comm_strs->lock);
+		RC_CHK_FREE(cs);
+	} else {
+		RC_CHK_PUT(cs);
 	}
 }
 
-static struct comm_str *comm_str__alloc(const char *str)
+static struct comm_str *comm_str__new(const char *str)
 {
-	struct comm_str *cs;
+	struct comm_str *result = NULL;
+	RC_STRUCT(comm_str) *cs;
 
-	cs = zalloc(sizeof(*cs));
-	if (!cs)
-		return NULL;
-
-	cs->str = strdup(str);
-	if (!cs->str) {
-		free(cs);
-		return NULL;
+	cs = malloc(sizeof(*cs) + strlen(str) + 1);
+	if (ADD_RC_CHK(result, cs)) {
+		refcount_set(comm_str__refcnt(result), 1);
+		strcpy(&cs->str[0], str);
 	}
+	return result;
+}
 
-	refcount_set(&cs->refcnt, 1);
+static int comm_str__cmp(const void *_lhs, const void *_rhs)
+{
+	const struct comm_str *lhs = *(const struct comm_str * const *)_lhs;
+	const struct comm_str *rhs = *(const struct comm_str * const *)_rhs;
 
-	return cs;
+	return strcmp(comm_str__str(lhs), comm_str__str(rhs));
 }
 
-static
-struct comm_str *__comm_str__findnew(const char *str, struct rb_root *root)
+static int comm_str__search(const void *_key, const void *_member)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent = NULL;
-	struct comm_str *iter, *new;
-	int cmp;
-
-	while (*p != NULL) {
-		parent = *p;
-		iter = rb_entry(parent, struct comm_str, rb_node);
-
-		/*
-		 * If we race with comm_str__put, iter->refcnt is 0
-		 * and it will be removed within comm_str__put call
-		 * shortly, ignore it in this search.
-		 */
-		cmp = strcmp(str, iter->str);
-		if (!cmp && comm_str__get(iter))
-			return iter;
-
-		if (cmp < 0)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
+	const char *key = _key;
+	const struct comm_str *member = *(const struct comm_str * const *)_member;
 
-	new = comm_str__alloc(str);
-	if (!new)
-		return NULL;
+	return strcmp(key, comm_str__str(member));
+}
+
+static struct comm_str *__comm_strs__find(struct comm_strs *comm_strs, const char *str)
+{
+	struct comm_str **result;
 
-	rb_link_node(&new->rb_node, parent, p);
-	rb_insert_color(&new->rb_node, root);
+	result = bsearch(str, comm_strs->strs, comm_strs->num_strs, sizeof(struct comm_str *),
+			 comm_str__search);
 
-	return new;
+	if (!result)
+		return NULL;
+
+	return comm_str__get(*result);
 }
 
-static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
+static struct comm_str *comm_strs__findnew(const char *str)
 {
-	struct comm_str *cs;
+	struct comm_strs *comm_strs = comm_strs__get();
+	struct comm_str *result;
 
-	down_write(&comm_str_lock);
-	cs = __comm_str__findnew(str, root);
-	up_write(&comm_str_lock);
+	if (!comm_strs)
+		return NULL;
 
-	return cs;
+	down_read(&comm_strs->lock);
+	result = __comm_strs__find(comm_strs, str);
+	up_read(&comm_strs->lock);
+	if (result)
+		return result;
+
+	down_write(&comm_strs->lock);
+	result = __comm_strs__find(comm_strs, str);
+	if (!result) {
+		if (comm_strs->num_strs == comm_strs->capacity) {
+			struct comm_str **tmp;
+
+			tmp = reallocarray(comm_strs->strs,
+					   comm_strs->capacity + 16,
+					   sizeof(*comm_strs->strs));
+			if (!tmp) {
+				up_write(&comm_strs->lock);
+				return NULL;
+			}
+			comm_strs->strs = tmp;
+			comm_strs->capacity += 16;
+		}
+		result = comm_str__new(str);
+		if (result) {
+			comm_strs->strs[comm_strs->num_strs++] = result;
+			qsort(comm_strs->strs, comm_strs->num_strs, sizeof(struct comm_str *),
+			      comm_str__cmp);
+		}
+	}
+	up_write(&comm_strs->lock);
+	return result;
 }
 
 struct comm *comm__new(const char *str, u64 timestamp, bool exec)
@@ -115,7 +171,7 @@ struct comm *comm__new(const char *str, u64 timestamp, bool exec)
 	comm->start = timestamp;
 	comm->exec = exec;
 
-	comm->comm_str = comm_str__findnew(str, &comm_str_root);
+	comm->comm_str = comm_strs__findnew(str);
 	if (!comm->comm_str) {
 		free(comm);
 		return NULL;
@@ -128,7 +184,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 {
 	struct comm_str *new, *old = comm->comm_str;
 
-	new = comm_str__findnew(str, &comm_str_root);
+	new = comm_strs__findnew(str);
 	if (!new)
 		return -ENOMEM;
 
@@ -149,5 +205,5 @@ void comm__free(struct comm *comm)
 
 const char *comm__str(const struct comm *comm)
 {
-	return comm->comm_str->str;
+	return comm_str__str(comm->comm_str);
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


