Return-Path: <linux-kernel+bounces-552128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7602BA57608
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29DA1794D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8925BAB2;
	Fri,  7 Mar 2025 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X88GEPtS"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97425A2CA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390146; cv=none; b=hDjnRjLEJ+0mHKz4F4g8kfoxcBM6mB+I1xXwdKKfFdZBdxZeDMZAfq7/Nyd6FPFwlPitaSXTcuFuBzIVz8DL4V5a9COYMjvWdhTk7OwnhcGEbcn3ztvn348cQsHjtahwqvSUoG5FEHZKmctajNvh2u8P3I3DiADemJKEGrLtTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390146; c=relaxed/simple;
	bh=lz9kuFeOneoNnBLyFoR/bYunAUSseRNqLWZa9SZl0Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7yrvDvpGZ07hJFnhrNK3777KbgwFK8KHl8jtkOMe/8+UUlHdfWI5tLFBJ0Tmrcm7mBCen44Lbs0Im7FpB/TDJEWqlXC4NVL0ahVlCAX5O39/kZB4x6TLXFJOTw2y3GcZKQQHlGfBfD3jeZaHibf9AkX1W8LzuO+BCngvFzDKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X88GEPtS; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f6970326so17843286d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390144; x=1741994944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fEKUUBWKonq+SljYML2UXgAOZGt6uRAsGBJ5aZUIg9Y=;
        b=X88GEPtSQTRNHa6Xi7jWyimI/lrBu45xAftEhus06SrO5UJo9E4vE0oyzXX4rvtOyA
         OIc2DbuAx6WH4q5QJPqYrT4lUIrzcaEmBXOTaP6/SRefBrpQn2GoINRfYQ7tIlgHxmug
         8tAj7j+IH6sPnunWkHDJI5TiVwl2u/Z6UCBfFFai35s7hWCwmaV6FTQqBq4atsyzZVjx
         XSp8ii0Wf4+PGBw/30zHmw/uzx1KSRrxQ37aGCa/LJ+JAZPVX4ILkhgQ+nlXAjWHPJKF
         mDXtZVSTLMGa8LTFobhgYj3V+bk78Y5Rqqtk7Fk1EWTi6o8+e9dH3KLQWgJwbc4gBmXO
         Yf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390144; x=1741994944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEKUUBWKonq+SljYML2UXgAOZGt6uRAsGBJ5aZUIg9Y=;
        b=H+bm5kOg9gNJTIEvE2VKKrrFB1xPkJ6LSlte5qv4jMhTAVTpiyp+yZCrQBycjCjotD
         OsBgMH0gqjsu3xvYQDcrPspP6r2GgJGtfCuhE4C6Zcq251p8Y5A3wT1CvjA15U7oMyTX
         sg21N72fMoQ/K9QDirGU8aa7pese5dY3nLmHlPNzxk0XzS6ETyMhAfCSw2MqtBTD3VR/
         xZpFgHiR8yMrnHfND3KNvEDPIqBoyqxS62PfudNox+klqYr4q9gb2UgSEjX5w3VYGl2z
         e9naceCsWCv9w9GPTz6NKFkJEj2YCONENtT5+uJssepjtK1L47BcScCwqV52T6GGSoV5
         yCCA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+45cmEM9YksDIfmoEG+j8UPgQu3P7AoeOqhB9jQsRVAGCkfuYjNcMFzXTv+PO8N1Hmh623a3XxhUjOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYJu/7bur7UtzN5kitbOy/LPSx2elVLMKU1tZFkNBMEzU7Fma
	ug0w5MezbfHpVtHWN/65sMSqjQQTMyGmJ5QWp38x5x/xWz8U7Phv
X-Gm-Gg: ASbGncuOHONXwd9ZZ0ZtAIpMbbUMvDPcNDbd03zbSQdfdGFI3UVIQY3yqcdzE0wY6ZR
	ty/ox7MIKp35f8HzE6vPulzwYPmHls7wECsCMq+5ndHq7fpMgxoX/EdunV6+Z4lz71cALi4syv4
	wTeVp/zrpmyhqIE2QnXvVGBvkPsxExJyyzpWmkQ+JfzQ9ul+FZX502g5qJq7Us3C4d7lJb7Mlhn
	9dkTvYzS4puseQcMP69ZO+jn2UZhF+x5/hxljx7gvY6NpQV6YcPOYDhWHnWFVUaA444qy6gy7zf
	6P5v7RwLxxCInv1qsOsF5No4R5frmSEbSVNGAfA9yKimwebGzqH0qzkrqSeZtGFoyzQTsazlcr5
	Sg1GKDhwM8qMijHlYaTJMakgBODaTGNEKrT4=
X-Google-Smtp-Source: AGHT+IFM216j7EhXIuk+4I+vq2cMw4p8ydmdv3/X+4fxjfl8b1BfnnaMq894v1Yu/hI5FSmydzNBJA==
X-Received: by 2002:ad4:5cae:0:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6e9005bc7e4mr66798286d6.9.1741390143644;
        Fri, 07 Mar 2025 15:29:03 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b60fsm24564746d6.92.2025.03.07.15.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:03 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id B8DBF120006A;
	Fri,  7 Mar 2025 18:29:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 18:29:02 -0500
X-ME-Sender: <xms:PoHLZ8rBuVVCKFEuoz2oQE5ehBpSLLywF41qThajTcleWDep1VtMWg>
    <xme:PoHLZyobYX5M3fDFMpBPi0W0EMHm0zSBPKKOb4lQY1yoUIKnC71RSaktnHNKKig_7
    oT3LCDPuNjKD6CGLg>
X-ME-Received: <xmr:PoHLZxOl2HvncdwqMPvkNKoyefTir-0cK5CyscQwMXT1k59g0WFGeNQlu8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gvlhhvvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhgurhgvhihknhhvlhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:PoHLZz7H9EttM6fvQNm-ZPZdaft9N1ZOwABMrfv4DKMw-L9RNvbc9g>
    <xmx:PoHLZ75Npu9mur02mgMDW1qHgt8lgSMbmjY2tGQbkWJH9qA-MaRwfw>
    <xmx:PoHLZzhqtmMjo8LiOqCeLzpX_TD6ie5gwaH9qPUqRNyGpEoyuOV9xw>
    <xmx:PoHLZ14bV0bHX_LKUC18NdCurJJiKVsG3EnozxaMYiClCqg7yTT6oA>
    <xmx:PoHLZ-LnBf3BZruChQh178dzaPwuTmobAZgpjV1v7DcV3NrYgmoQJ3Wg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:02 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [PATCH locking 05/11] locking/lockdep: Disable KASAN instrumentation of lockdep.c
Date: Fri,  7 Mar 2025 15:26:55 -0800
Message-ID: <20250307232717.1759087-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

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
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250213200228.1993588-4-longman@redhat.com
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
2.47.1


