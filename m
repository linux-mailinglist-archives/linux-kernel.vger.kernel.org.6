Return-Path: <linux-kernel+bounces-372104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5289A447B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DEF1F2388C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8EA2040B8;
	Fri, 18 Oct 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBgT7Qj8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F42040A9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271895; cv=none; b=LK7gL4Nyn3ZY9lAKN6KOxzfksulz+27bP5FBbsXj69D6gzwUdH4opZRHH/xCmziwtaKC4EjuWZJDg27XAgPN5VYsXSFNUlMXlXay4M8JmE6GR5itBp1lFnpa2A22Qk24o4GenSw7HtAxeKDu2zvGgwWZzVYaHHHJblbAd/vLPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271895; c=relaxed/simple;
	bh=hE7oRewSRIwjPXZwf3rEvS9LnJl6BbPZ+AoeFZLef0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fO6cQ0iY9F5FZvGnU8kYIyy3lGWIsjzAfVwM2O/OjXpwjKpWC9nC2z7W1VRF3fiTHWFO+Q3BMGWI4h2hLd31udS1bKJQmR4pRSD+1TL0S66nmEr4iri1s8JDoQf0ZQcps5Vxbw6MWnm5e6SSdUfMMDQnEH/RTatw61sdN9PeAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBgT7Qj8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so3880907276.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271893; x=1729876693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqicHt23y2Txc3ltQfz9r7Ld+Ys6zd7l3ho/WLmRnAI=;
        b=WBgT7Qj8ZsqPbDiwgmq6YgD84bUCH3CGJAQCPU9cdEf/4ALsZTgVvsjVZK0k5fSQZG
         2MKuwjom24kcqrmIBDeNYQo06/lDL20BYyIxk4i1kyZVGTEQqcmU2SSWgJESYQVj4tNG
         kFpAjjIlOLqPpUStXyoVEw460gZ+0CynJt6HtTNbE7ApFtE2SBioj4mRQTmprKRsfzi8
         rf2jYrASH23IKupKaof6NY++2nrlZg8SJiRawtXdQuKK+9m4316zvM2Qah6CANao4wzW
         jmV9WIstskir3W4pez1nXtfLGdsdGsuSzC8SH5WmalQCwwgZk3KnQoX/8EpXRml/CYN+
         018A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271893; x=1729876693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqicHt23y2Txc3ltQfz9r7Ld+Ys6zd7l3ho/WLmRnAI=;
        b=EjtY/0m4//0zeeRwHRs8dWrifdAGPUiMxWmh2GvEzRS66lygusRsjdIuBmSkQBJCRv
         eoYDR4KnHQvMGJh5eiSQ56fbtkBT8wWQig3LevXGMAWXlFu3CmJUvCD9ihMxkeS78+cg
         BLGHX8UV5cJgpsO7P49i358b7lICj/n4JHcuk6xHIG5bMUsk8/+/8NKqaAjL+AiFdKYG
         /7VmTyaXHH7jcsYJSqp4yEYHFm1j99Wdoj4H9577RJ8iIViNxC1s2H1CkVHRdHX6nlYA
         Dan59wfQhxtomjqHD3HdJ/+dBvJ7AANO5AcGfjkd7vdFtoTxjzd3baByhx/Yjeal91x2
         H4Mw==
X-Gm-Message-State: AOJu0YwDlsa2LuobO+mKQ9E+V4USrLHhlBh7x1Lr/wuS4gNtkRJly4Xz
	OERBKBZWDKIIocufbJwdmY0/H3qhN2bcWdWk+CYeeovj/T951nuG6mOB3e7eX6Q7fWYh9aLmmMZ
	VUg==
X-Google-Smtp-Source: AGHT+IETe8cpTBCpQKyA4kbFf3lNf2xFOaZ0iITih7uovjfurWUIEAi/snUf1XNhONUTm2/f6zAtyiP2pUI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:360c:0:b0:e22:3aea:6eb5 with SMTP id
 3f1490d57ef6-e2bb158a8cbmr4986276.7.1729271892276; Fri, 18 Oct 2024 10:18:12
 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:24 +0000
In-Reply-To: <20241018171734.2315053-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018171734.2315053-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241018171734.2315053-4-edliaw@google.com>
Subject: [PATCH 3/3] selftests/mm: fix deadlock for fork after pthread_create
 with atomic_bool
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"

Some additional synchronization is needed on Android ARM64; we see a
deadlock with pthread_create when the parent thread races forward before
the child has a chance to start doing work.

Fixes: cff294582798 ("selftests/mm: extend and rename uffd pagemap test")
CC: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index b3d21eed203d..a2e71b1636e7 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -241,6 +241,8 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
+	ready_for_fork = true;
+
 	/* Read until a full msg received */
 	while (uffd_read_msg(args->parent_uffd, &msg));
 
@@ -308,8 +310,11 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
+		ready_for_fork = false;
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
+		while (!ready_for_fork)
+			; /* Wait for the poll_thread to start executing before forking */
 	}
 
 	child = fork();
-- 
2.47.0.105.g07ac214952-goog


