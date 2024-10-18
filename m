Return-Path: <linux-kernel+bounces-372102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9C9A4477
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90541F22F28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E9204012;
	Fri, 18 Oct 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7rCSTF6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1225204009
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271887; cv=none; b=VStiXTPurOStx+oMMmv+8unXKwEBM5B7okxKIg8pf/bl+JMNWBHuWoGoV5uiVRUwZ7XGXYunhcEc3XMDCm2ZyN3fFZNqaGda9KtP52XppnsSCuXMIVq5trXvHaoJ5sqJ2PKXkj0abHTNXbW5wRPBUPZIQq4Smgs171GWF80Zop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271887; c=relaxed/simple;
	bh=+ENvV6jp4xly72yGU6pYCi2Z9gHRmWJGCF79OSN5WJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dv/90qF0HjIakT7ViVHmM7BA8lI8OHFzVl6TBWzeeesptcAFVb4fIU9sBAQrbIwQKnltPhTqs/SURpTLBkovoxE5CC2h7jnI0gCXqjtART/4DBSsVf8gFSLmXUtvpoa1onJ6ubTk5fS2gGvVUoD3yxmo3FqwOmJugfNFGlfcBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7rCSTF6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e29facda92so2646393a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271885; x=1729876685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=09rqkYzv1mj2i541CG3quDs2Oto4Z5t/2Gr1EPh2MJY=;
        b=j7rCSTF6uath0EDHr79tpDSZrVXkdSv6A1vgi3o3+Lrcx/qH230Dvj7iAsCwBgbi2U
         iD5/C79JM+dFeadoKVP1bablz6eVhgYStpYi3caz45dV1PyI1f3vSvNrBZ+KHNYkPH7H
         QWSOnQlNYttYkTdNcrQ80OD5259LKq8Ndl1CRz+nGT2esTmJVjSYXLYOKLqPuY9cj0lW
         eI3tr3P/3HVEAcBKnPq9yg6E6PnmflP5iARc2iju4a5Ihfnng00I5TcbuYZ8CCAxv/eG
         eU0ampj4EAVoqGakmWoxEOcxCHBM5MvFHS7QiCQFYoJzbC4mmB6XXWij5+ih6VN/yZJ8
         LlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271885; x=1729876685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09rqkYzv1mj2i541CG3quDs2Oto4Z5t/2Gr1EPh2MJY=;
        b=JXe5Bap4oE+jqkkfeDx2d7DNBhovbaUSXLQwDc1VqWZx9PoDsTKkkNuL7prgE3tXlT
         LqrPwdLqQavVDz9zcEwxJ1R2i+hj2aK7DPMHZkt7X27yXcR5JB5w732VSw8ANemsvNxz
         KlWaY7k+T4O4N+TdKmXzYgR+6UTq2dN/F4NA+F4t5jUxOQ0Sm/eMjMszPq4Ju8oeEdEP
         lzdG5d4JgoKc0uknL9RyDJcOL8oF0n4WdlRf6qsOcWhoByH39gJOse6QqBt0IFXoOk4v
         guDwlChFXuDCUnsgmZnHAzWbG45BOKDHDO2uIAZC/s3ywhXr96/Usxc9WJyOaIzyxzIG
         owwQ==
X-Gm-Message-State: AOJu0YzH5lG4N2GccEqWlu2YvSTkq+3tDDbC94PrGaCZDd3JG+NzU9Tb
	wHyQTiJfaDrLOMl8AT5AyNAq0pm2P4GcdOKxFuOMnTNLQyXYvioa+ocKIHJrSeahH/gpiWbjNPa
	tHg==
X-Google-Smtp-Source: AGHT+IFCzoFKtcQsGl5HORvI+qdsZRNBp3NS1MD2ovvhIYOdGqZKLlvaQri87EIXebpvo+p31wOY+8NUM+A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:dc02:b0:2e0:72ab:98e9 with SMTP id
 98e67ed59e1d1-2e561511115mr9463a91.0.1729271884764; Fri, 18 Oct 2024 10:18:04
 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:22 +0000
In-Reply-To: <20241018171734.2315053-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018171734.2315053-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241018171734.2315053-2-edliaw@google.com>
Subject: [PATCH 1/3] Revert "selftests/mm: fix deadlock for fork after
 pthread_create on ARM"
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit e142cc87ac4ec618f2ccf5f68aedcd6e28a59d9d.

fork_event_consumer may be called by other tests that do not initialize
the pthread_barrier, so this approach is not correct.  The subsequent
patch will revert to using atomic_bool instead.

Fixes: e142cc87ac4e ("fix deadlock for fork after pthread_create on ARM")
CC: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index c8a3b1c7edff..3db2296ac631 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -241,9 +241,6 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
-	/* Ready for parent thread to fork */
-	pthread_barrier_wait(&ready_for_fork);
-
 	/* Read until a full msg received */
 	while (uffd_read_msg(args->parent_uffd, &msg));
 
@@ -311,12 +308,8 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
-		pthread_barrier_init(&ready_for_fork, NULL, 2);
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
-		/* Wait for child thread to start before forking */
-		pthread_barrier_wait(&ready_for_fork);
-		pthread_barrier_destroy(&ready_for_fork);
 	}
 
 	child = fork();
-- 
2.47.0.105.g07ac214952-goog


