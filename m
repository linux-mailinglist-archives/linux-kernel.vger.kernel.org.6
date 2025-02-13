Return-Path: <linux-kernel+bounces-513813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606BA34EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4457A7A4248
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E55266B4C;
	Thu, 13 Feb 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar/EPyQS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83442661B1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476976; cv=none; b=QzUabh1ljb4EJFptcKe3i0Klm4E0V76GPaO9LHF3p5D07Xp8lI/kpEWAK+iei5yvsIwFtgWVnpMHWcQwKlKg4KiTG/w6CpjcY5hrVW+zh5FXPrl214v93L0/kOGxDe9eUOIgC2dpxZ0+7KplTKe1bvyN89FApU19bnQwo0UMtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476976; c=relaxed/simple;
	bh=5+sV00c/Wm6fs0te4L4OWioK04YWyzdbWrzVVZVv2Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBG4uNJr/+lfAZ4sINN9tov6i4kXK58ShNeZvBuqyQiS2uI0W/5XtSsnNgL6VFrPgoB0uqwKNSlXiVwBBhP1NHUJO4eRl/X2VPbjB6G7plisO74MescbA44nbnjF+XkvU46lO3zG1qewXjPLMINXVtTPjEc5qd5HdbAG2aZW8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ar/EPyQS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739476974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz+7MpT+Dx78HRfBDvJLdqx8byUVr6Veo3C9NU8MZLY=;
	b=Ar/EPyQSux5vkM+JT6zuOZiYNSQaNNAefNpsGOB2YizjDsqwMSVSeEFilYpRgLmlGTpXAQ
	2Nx2LMb0Pt53WPhDM3Moky8A2nrKW5MS8esWO1BnddiaMVc0HcpdsP2VD6jlxZBZYpzUZu
	5a4i0PzyL8IpMAiCUL0UxohgsWw5NqQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609--0t1wsnLOGKBHz3JatwlMA-1; Thu,
 13 Feb 2025 15:02:50 -0500
X-MC-Unique: -0t1wsnLOGKBHz3JatwlMA-1
X-Mimecast-MFC-AGG-ID: -0t1wsnLOGKBHz3JatwlMA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AB25180087D;
	Thu, 13 Feb 2025 20:02:48 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.174])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00E791800358;
	Thu, 13 Feb 2025 20:02:45 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/4] locking/lockdep: Disable KASAN instrumentation of lockdep.c
Date: Thu, 13 Feb 2025 15:02:27 -0500
Message-ID: <20250213200228.1993588-4-longman@redhat.com>
In-Reply-To: <20250213200228.1993588-1-longman@redhat.com>
References: <20250213200228.1993588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Both KASAN and LOCKDEP are commonly enabled in building a debug kernel.
Each of them can significantly slow down the speed of a debug kernel.
Enabling KASAN instrumentation of the LOCKDEP code will further slow
thing down.

Since LOCKDEP is a high overhead debugging tool, it will never get
enabled in a production kernel. The LOCKDEP code is also pretty mature
and is unlikely to get major changes. There is also a possibility of
recursion similar to KCSAN.

To evaluate the performance impact of disabling KASAN instrumentation
of lockdep.c, the time to do a parallel build of the Linux defconfig
kernel was used as the benchmark. Two x86-64 systems (Skylake & Zen 2)
and an arm64 system were used as test beds. Two sets of non-RT and RT
kernels with similar configurations except mainly CONFIG_PREEMPT_RT
were used for evaulation.

For the Skylake system:

  Kernel			Run time	    Sys time
  ------			--------	    --------
  Non-debug kernel (baseline)	0m47.642s	      4m19.811s

  [CONFIG_KASAN_INLINE=y]
  Debug kernel			2m11.108s (x2.8)     38m20.467s (x8.9)
  Debug kernel (patched)	1m49.602s (x2.3)     31m28.501s (x7.3)
  Debug kernel
  (patched + mitigations=off) 	1m30.988s (x1.9)     26m41.993s (x6.2)

  RT kernel (baseline)		0m54.871s	      7m15.340s

  [CONFIG_KASAN_INLINE=n]
  RT debug kernel		6m07.151s (x6.7)    135m47.428s (x18.7)
  RT debug kernel (patched)	3m42.434s (x4.1)     74m51.636s (x10.3)
  RT debug kernel
  (patched + mitigations=off) 	2m40.383s (x2.9)     57m54.369s (x8.0)

  [CONFIG_KASAN_INLINE=y]
  RT debug kernel		3m22.155s (x3.7)     77m53.018s (x10.7)
  RT debug kernel (patched)	2m36.700s (x2.9)     54m31.195s (x7.5)
  RT debug kernel
  (patched + mitigations=off) 	2m06.110s (x2.3)     45m49.493s (x6.3)

For the Zen 2 system:

  Kernel			Run time	    Sys time
  ------			--------	    --------
  Non-debug kernel (baseline)	1m42.806s	     39m48.714s

  [CONFIG_KASAN_INLINE=y]
  Debug kernel			4m04.524s (x2.4)    125m35.904s (x3.2)
  Debug kernel (patched)	3m56.241s (x2.3)    127m22.378s (x3.2)
  Debug kernel
  (patched + mitigations=off) 	2m38.157s (x1.5)     92m35.680s (x2.3)

  RT kernel (baseline)		 1m51.500s	     14m56.322s

  [CONFIG_KASAN_INLINE=n]
  RT debug kernel		16m04.962s (x8.7)   244m36.463s (x16.4)
  RT debug kernel (patched)	 9m09.073s (x4.9)   129m28.439s (x8.7)
  RT debug kernel
  (patched + mitigations=off) 	 3m31.662s (x1.9)    51m01.391s (x3.4)

For the arm64 system:

  Kernel			Run time	    Sys time
  ------			--------	    --------
  Non-debug kernel (baseline)	1m56.844s	      8m47.150s
  Debug kernel			3m54.774s (x2.0)     92m30.098s (x10.5)
  Debug kernel (patched)	3m32.429s (x1.8)     77m40.779s (x8.8)

  RT kernel (baseline)		 4m01.641s	     18m16.777s

  [CONFIG_KASAN_INLINE=n]
  RT debug kernel		19m32.977s (x4.9)   304m23.965s (x16.7)
  RT debug kernel (patched)	16m28.354s (x4.1)   234m18.149s (x12.8)

Turning the mitigations off doesn't seems to have any noticeable impact
on the performance of the arm64 system. So the mitigation=off entries
aren't included.

For the x86 CPUs, cpu mitigations has a much bigger
impact on performance, especially the RT debug kernel with
CONFIG_KASAN_INLINE=n. The SRSO mitigation in Zen 2 has an especially
big impact on the debug kernel. It is also the majority of the slowdown
with mitigations on. It is because the patched ret instruction slows
down function returns. A lot of helper functions that are normally
compiled out or inlined may become real function calls in the debug
kernel.

With CONFIG_KASAN_INLINE=n, the KASAN instrumentation inserts a
lot of __asan_loadX*() and __kasan_check_read() function calls to memory
access portion of the code. The lockdep's __lock_acquire() function,
for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
added with KASAN instrumentation. Of course, the actual numbers may vary
depending on the compiler used and the exact version of the lockdep code.

With the Skylake test system, the parallel kernel build times reduction
of the RT debug kernel with this patch are:

 CONFIG_KASAN_INLINE=n: -37%
 CONFIG_KASAN_INLINE=y: -22%

The time reduction is less with CONFIG_KASAN_INLINE=y, but it is still
significant.

Setting CONFIG_KASAN_INLINE=y can result in a significant performance
improvement. The major drawback is a significant increase in the size
of kernel text. In the case of vmlinux, its text size increases from
45997948 to 67606807. That is a 47% size increase (about 21 Mbytes). The
size increase of other kernel modules should be similar.

With the newly added rtmutex and lockdep lock events, the relevant
event counts for the test runs with the Skylake system were:

  Event type		Debug kernel	RT debug kernel
  ----------		------------	---------------
  lockdep_acquire	1,968,663,277	5,425,313,953
  rtlock_slowlock	     -		  401,701,156
  rtmutex_slowlock	     -		      139,672

The __lock_acquire() calls in the RT debug kernel are x2.8 times of the
non-RT debug kernel with the same workload. Since the __lock_acquire()
function is a big hitter in term of performance slowdown, this makes
the RT debug kernel much slower than the non-RT one. The average lock
nesting depth is likely to be higher in the RT debug kernel too leading
to longer execution time in the __lock_acquire() function.

As the small advantage of enabling KASAN instrumentation to catch
potential memory access error in the lockdep debugging tool is probably
not worth the drawback of further slowing down a debug kernel, disable
KASAN instrumentation in the lockdep code to allow the debug kernels
to regain some performance back, especially for the RT debug kernels.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17b8..a114949eeed5 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -5,7 +5,8 @@ KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
-# Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
+# Avoid recursion lockdep -> sanitizer -> ... -> lockdep & improve performance.
+KASAN_SANITIZE_lockdep.o := n
 KCSAN_SANITIZE_lockdep.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
-- 
2.48.1


