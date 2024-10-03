Return-Path: <linux-kernel+bounces-349590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0098F8C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3694B283C41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9611BF7E8;
	Thu,  3 Oct 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAiuja3w"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805801A0708
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990253; cv=none; b=SpSUpxM/pIzIQMWPKXqP6h7+X3cajYMM+tyG4peiihqLRQr6KqSXTJHgg5LBcfSyabHiWQKakyOSjtY+HdOuueJA0fpfFLErGIJQroj62RjOhwf+Idb9HA47Uf38WOJRlIMtfIYKgY8qCAW1aDw+hO7WGhv/9WgVEWBmwSQ6OqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990253; c=relaxed/simple;
	bh=EcrxJmJkEY89MEO9l4NQd+g2m2f94zkmGXJcRfAXWCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OujFC7zBtHb8RbymYTmEJ4xRPJmec5fVyMcj++5P8y86ZC5HBYaqx+xyQ0BBgQaEOFBRa1kmqZrK4XmohkQjuaV4KI9zducP/QmLOcttCYrD6ZXiddmBskk5FWCC0D0UlxidJNKooGJLDgP4bxxOy2Z7dkOMR5lLvvPkjqDMD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QAiuja3w; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28694ff555so2485974276.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727990249; x=1728595049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KkHqwn8Bqw7l/s5v7I5SXTM3ejHc+yrhyoRwQ1tPH9Q=;
        b=QAiuja3wtjYlcEuCj9YT6CRp/oOsXhxexGf0y9q3l1OfOB4UzHydXoF6Dl1soBBLw7
         1RviT5LUm9N87EXwPltJW9dtALXfTmxudhj2pSNUKGyCf0eS2SQP/H22NDx3aMjo4l2T
         LbPtD/GgnH0PoagejBelcc510ouPmauyawgR2mYD2KXM8TEpJ2SSH7lUCEex1GU0n6l8
         RzgJNYIdjpJbVlBZcSdlTh6nmh8Q38Pu39Rk1d51/28UFw1xn2DOgNdeNtzdyuiD6Xwy
         qrcnW4DyaLjU8B0u2NBKQP8wsfR2jyPeGqlNcigNrdgoxXWQQ6dia6MtImDJulrUGeGx
         XtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990249; x=1728595049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkHqwn8Bqw7l/s5v7I5SXTM3ejHc+yrhyoRwQ1tPH9Q=;
        b=M4QrwvgyohYrMSTuc6qK4iwPqBuzArM6daWUm9hRsZZ+YQg8SMcjwYAQb/1KddHQuJ
         PkTVAcYdZaDx38WHSZ2xGcmc/9ObF2/+0savfo8LiUTvN+oFLfubPWwZbTaKAOA3plkV
         xG+EFuhz/tgojOEFKXrh4jN0WEvPv3Sm3+XIpSLQpdikwnoFxv41IcfhdUW/huUzsMoh
         ItdPfwzHt8vYy1GmT/47fdi24M0a/jJ/rc20Z5misGmxRrsg3MIpcl6N1t5uin/lVdJl
         AQ2UiFQrFcF9CJlfNJZTHTlTICFZZOjFecAKsu5fqiJjwd+1rF8KsQliHAQmg72R2iNF
         KOPg==
X-Gm-Message-State: AOJu0YxNhUW0YX7C18OKpxkCBG4OFoxCS7XHo4v3lBDTeQXd9RZecyBo
	U0vZwdbCqQQA8J9V3NQFNKv7mdWkmxSC9iDRYjgvYQFblTkkS3IN06tvKgZ/9HEF/FUA90vs/aH
	Y9A==
X-Google-Smtp-Source: AGHT+IGgqrbal18cXmCsiQESftRs1395vmYgGSaXxFs9pt/ua0r8DPUXmkAbrXpoVABneX6qbZ8gjH/Q2zw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:684d:0:b0:e24:a06b:1aed with SMTP id
 3f1490d57ef6-e28936d26b8mr255276.3.1727990249428; Thu, 03 Oct 2024 14:17:29
 -0700 (PDT)
Date: Thu,  3 Oct 2024 21:17:10 +0000
In-Reply-To: <20241003211716.371786-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003211716.371786-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003211716.371786-2-edliaw@google.com>
Subject: [PATCH 1/2] selftests/mm: replace atomic_bool with pthread_barrier_t
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Swaps synchronization primitive with pthread_barrier, so that
stdatomic.h does not need to be included.

The synchronization is needed on Android ARM64; we see a deadlock with
pthread_create when the parent thread races forward before the child has
a chance to start doing work.

Fixes: 8c864371b2a1 ("selftests/mm: fix ARM related issue with fork after
pthread_create")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  5 +++--
 tools/testing/selftests/mm/uffd-common.h     |  3 +--
 tools/testing/selftests/mm/uffd-unit-tests.c | 14 ++++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf98..852e7281026e 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -18,7 +18,7 @@ bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
-atomic_bool ready_for_fork;
+pthread_barrier_t ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -519,7 +519,8 @@ void *uffd_poll_thread(void *arg)
 	pollfd[1].fd = pipefd[cpu*2];
 	pollfd[1].events = POLLIN;
 
-	ready_for_fork = true;
+	/* Ready for parent thread to fork */
+	pthread_barrier_wait(&ready_for_fork);
 
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index a70ae10b5f62..3e6228d8e0dc 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -33,7 +33,6 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
-#include <stdatomic.h>
 
 #include "../kselftest.h"
 #include "vm_util.h"
@@ -105,7 +104,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
-extern atomic_bool ready_for_fork;
+extern pthread_barrier_t ready_for_fork;
 
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index b3d21eed203d..3db2296ac631 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -774,7 +774,7 @@ static void uffd_sigbus_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
-	ready_for_fork = false;
+	pthread_barrier_init(&ready_for_fork, NULL, 2);
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -791,8 +791,9 @@ static void uffd_sigbus_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	while (!ready_for_fork)
-		; /* Wait for the poll_thread to start executing before forking */
+	/* Wait for child thread to start before forking */
+	pthread_barrier_wait(&ready_for_fork);
+	pthread_barrier_destroy(&ready_for_fork);
 
 	pid = fork();
 	if (pid < 0)
@@ -833,7 +834,7 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
-	ready_for_fork = false;
+	pthread_barrier_init(&ready_for_fork, NULL, 2);
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -844,8 +845,9 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	while (!ready_for_fork)
-		; /* Wait for the poll_thread to start executing before forking */
+	/* Wait for child thread to start before forking */
+	pthread_barrier_wait(&ready_for_fork);
+	pthread_barrier_destroy(&ready_for_fork);
 
 	pid = fork();
 	if (pid < 0)
-- 
2.46.1.824.gd892dcdcdd-goog


