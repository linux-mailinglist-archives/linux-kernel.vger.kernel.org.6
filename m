Return-Path: <linux-kernel+bounces-172667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00718BF513
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB0EB22996
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BB179AF;
	Wed,  8 May 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmjAkqhL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C228168CC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140397; cv=none; b=PUt6EOLMTE9YnDW/LI0G+mxXXcaGy56KOW8Olatnq/GvSWCJ+YNgrVCRhLYNis/hXMVfeu2JMh2xx39PhJnadoSQhDZy+wgu7oJHHzvIASn96LA7jV5P/g66qt1TOBDX6NkvDT/YalVRFx62RIhwMnHHlqy8AZsscJFTs5i6FjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140397; c=relaxed/simple;
	bh=aHIl5ajtOsRuKOTphrUaDEcdr7Mjo44/1jnkIBWAkmM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DgMTZ/QrXyXktdkIaLNoNz/ezPppcWtvnFJooXKZMsUmS2llNm4kGtdB/9lOZzJoYta0L2fi7hzu1qXattT0/s4jaXBxCYRcjjMWRgemF1GVvbaQvYq4u+oh7XKyOfOR+FPA3AuoxPsMNc95QcNfWEVKVywR2m/MqstQLEP8fjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmjAkqhL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6204c4f4240so52664857b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140395; x=1715745195; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLpi7z8CqpYtGhQQH+K3dVX1FIdgCT+wy4o4hM2y81A=;
        b=TmjAkqhLjNKDM3sVTrlR85Lv6Ui7Mipe3Gka6io25vKuy0XVjPO7O+eo6q7S8u6ccw
         8/CwHqgpmUIrN1AIcuFHqZBPAKVlIgeIUHGygvsDhc76vWcWcxmLPqJTkqncSyn9Qhsm
         JoQTfAGY1NEEy41NES9rWvQKnWPZ2BjXWzMibd7KtIO0BIi+SvOtwqOtNy4UJP2Va8iL
         oaRTI0GxCsytrrIFFeL1RmAW4hfFTZMMVXyG/No8OBKQNhXawhA1/H0ekKzfF6Usxdwt
         +4ZuLmJ8+gpfzzaqsHt+YYAIfO/1pGCgSOgZhXP1MA54RUloCnrpM2WVg+49AfK2zSYu
         3dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140395; x=1715745195;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLpi7z8CqpYtGhQQH+K3dVX1FIdgCT+wy4o4hM2y81A=;
        b=BrWg0DOQ3eXNQcy09w5LnKSF1hrtgGPpC6AbDWj27ZMzuLQvH5oLSiu81bioMLStOQ
         QaHFsYg/9X1NEStnOkgDyQgURrv7MkGFK+CNaDOyOtstQJCbVUP0JhAHYDI5WsJVp0x6
         Nz+xn5kjxgv/pzKN7m9pAeqL3aU1umEJjs8UM7LqSB9rj1fAr2vyHQY7B4LpcIJnCzeX
         I69jd4s5vMFM/NNEUa584RwU/PQZe/0VjQ995wC28Vbv/clPL/HoIDDuhnZmTDykkY3i
         lP9WZe1qrw9I8hG953orylv6MctJTL5Pi/gTWgzlFGP0DzMCZueRy5J7mk2zx211RBOD
         owvw==
X-Forwarded-Encrypted: i=1; AJvYcCWPFz5bAtgira+h5uA8KZJdO4JfLTcrh0Au3rmSHFQpx4f/06wh7OqlA95CjOe3sM1Bjf7ZtKByaDUQNgd1Z3bdHlRoFge+nUCVq5+G
X-Gm-Message-State: AOJu0YxKZny1fIlE+VcJX4DtNPlQA7TJh8dsP18ZTzEcYjsw2MI9ThPx
	ySwo/jZ881kYks9A1H0lPgrSZu20EMaGw1xUN+nl+/oWRx7GlzKxnvtxHeCp2AH5cfQwKRffU+4
	NGVUy7w==
X-Google-Smtp-Source: AGHT+IFrOkRLRqDS7GqMlrxDcpHsAvJyI+R0IRXLkCqe5dHNCgLGD/WBcjQn8SmUgyEm27PVlV5ZhjoZc6rT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a81:52cc:0:b0:618:8e4b:f4b0 with SMTP id
 00721157ae682-62085c3ff7dmr3595067b3.9.1715140395469; Tue, 07 May 2024
 20:53:15 -0700 (PDT)
Date: Tue,  7 May 2024 20:52:59 -0700
In-Reply-To: <20240508035301.1554434-1-irogers@google.com>
Message-Id: <20240508035301.1554434-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/4] perf comm: Fix comm_str__put for reference count checking
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Searching for the entry in the array needs to avoid the intermediate
pointer with reference count checking. Refactor the array removal to
binary search for the entry. Change the array to hold an entry with a
reference count (so the intermediate pointer can work) and remove from
the array when the reference count on a comm_str falls to 1.

Fixes: 13ca628716c6 ("perf comm: Add reference count checking to 'struct comm_str'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 45 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 1aa9a08e5b03..233f2b6edf52 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -19,6 +19,8 @@ static struct comm_strs {
 	int capacity;
 } _comm_strs;
 
+static void comm_strs__remove_if_last(struct comm_str *cs);
+
 static void comm_strs__init(void)
 {
 	init_rwsem(&_comm_strs.lock);
@@ -58,22 +60,15 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
 
 static void comm_str__put(struct comm_str *cs)
 {
-	if (cs && refcount_dec_and_test(comm_str__refcnt(cs))) {
-		struct comm_strs *comm_strs = comm_strs__get();
-		int i;
+	if (!cs)
+		return;
 
-		down_write(&comm_strs->lock);
-		for (i = 0; i < comm_strs->num_strs; i++) {
-			if (comm_strs->strs[i] == cs)
-				break;
-		}
-		for (; i < comm_strs->num_strs - 1; i++)
-			comm_strs->strs[i] = comm_strs->strs[i + 1];
-
-		comm_strs->num_strs--;
-		up_write(&comm_strs->lock);
+	if (refcount_dec_and_test(comm_str__refcnt(cs))) {
 		RC_CHK_FREE(cs);
 	} else {
+		if (refcount_read(comm_str__refcnt(cs)) == 1)
+			comm_strs__remove_if_last(cs);
+
 		RC_CHK_PUT(cs);
 	}
 }
@@ -107,6 +102,28 @@ static int comm_str__search(const void *_key, const void *_member)
 	return strcmp(key, comm_str__str(member));
 }
 
+static void comm_strs__remove_if_last(struct comm_str *cs)
+{
+	struct comm_strs *comm_strs = comm_strs__get();
+
+	down_write(&comm_strs->lock);
+	/*
+	 * Are there only references from the array, if so remove the array
+	 * reference under the write lock so that we don't race with findnew.
+	 */
+	if (refcount_read(comm_str__refcnt(cs)) == 1) {
+		struct comm_str **entry;
+
+		entry = bsearch(comm_str__str(cs), comm_strs->strs, comm_strs->num_strs,
+				sizeof(struct comm_str *), comm_str__search);
+		comm_str__put(*entry);
+		for (int i = entry - comm_strs->strs; i < comm_strs->num_strs - 1; i++)
+			comm_strs->strs[i] = comm_strs->strs[i + 1];
+		comm_strs->num_strs--;
+	}
+	up_write(&comm_strs->lock);
+}
+
 static struct comm_str *__comm_strs__find(struct comm_strs *comm_strs, const char *str)
 {
 	struct comm_str **result;
@@ -158,7 +175,7 @@ static struct comm_str *comm_strs__findnew(const char *str)
 		}
 	}
 	up_write(&comm_strs->lock);
-	return result;
+	return comm_str__get(result);
 }
 
 struct comm *comm__new(const char *str, u64 timestamp, bool exec)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


