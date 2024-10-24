Return-Path: <linux-kernel+bounces-380508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5389AEFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C8128434A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A98200CAD;
	Thu, 24 Oct 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzApEMKR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16631FC7D9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794999; cv=none; b=HRpex9qMr8hZHszcZCJUgG2gxohf1ziGxNMFpeRpAQovLSKtN700x1uzMrFSuVMLhaSJM7XMpc/XfJwcDOU4Cfcy1icmaOHfxVFchNXWoDYEAV1vVQ4e7fgWR+B5WI9y9OFAXfL9r8mUPI2kQzAiSahD/3ISNZM0PXZKBXnnGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794999; c=relaxed/simple;
	bh=PNTMHRt6ByKcjKIJl2jtbIlsRynQyb3CB/m9cIDWCq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oNh6Sr2t6BHcxTBP5bjZ0d5nnOQQKqw9ZqnGPsqBrD0eRRhVYz/FlUS4jZ/TyWKG3ljKdur1eO8sJiGk5oXd+A/glXtSvBbhHLzfu3yKf7mYYL0sXewWYo0BnpJ4NcpPTusMlJtGP79j7AMi1X6lf/V7wu0wqipnJdJJIEQzGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzApEMKR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2bb354e91so1220663a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729794997; x=1730399797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdbkpJvAL1p2GEPxPaAzYqCJ87IuKyW29MlAkszxMbs=;
        b=JzApEMKRYhPA5jB3gOctUs4k+1BYiSmmlN6TJweD+f1yHB3zuiM+05fgGDBnzXhQeC
         86h89DeimH7tTN96cevh9Vu+nm4HN2STg4YKW3rko24KXSqwJHV8zbKUO2smJo52Xy/z
         FTzeDkUKVMsmKuFtjyzD5gYswBq+WBrFfkpxtIW0nD+9VqeSA+ydGZ/A9EdG/Q0MfHDK
         173kHilXFh5e1GkDmCfVnfhoji0EAPRqzC+vu9vWd39taL/Aq9lJvln96EVzQG0ND4vP
         1Ytz8Wx1dsgXni4mrjRxHdF9DaURokyBEUXezVivpJlSDBWAeLeRl7fREe16WWW4s/bs
         523g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794997; x=1730399797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdbkpJvAL1p2GEPxPaAzYqCJ87IuKyW29MlAkszxMbs=;
        b=Y2zIB2WyWZgo6Qp4c10TgFWCTM2+NXkRyArHZgeI9pC//uyMO0GmbuOmm6zTZ1pa6B
         OhtOj0AFcHGezVgqspOc/tTjVi83Q/WjpbJ4cG3j7r8+w5w1c027r/9ag2nN5Oev395W
         nmZOqZpgmBjC6L78bvS6WCVrJQSu9lJH7TUbwpLwVzFe33Fb0V8/rNlgbGGzppOlw8Fn
         wxUVP70z9u24GU4O4OrzNaUIlV9LiVUj41V2yUpw08TMTpZwRJdwtgII1wp4gA/VfBy+
         5IUhOIPsQYGB+GE3I/H4AvRLubZLCPEcuc7gfLwN4vT8WilFRdBJp/4+ONnKdRxHU0oG
         k7og==
X-Gm-Message-State: AOJu0YwWXJa0Uv5CqGtNAUVH2FiDvCwnWBHferorfRKEivvueVRwZHjV
	iyjroeFVHxjDMTtQAWGP6V6nebxfEeYff1xu3K1O9aDbuRd55NAw16C295xcTUCWWQElKCSVbzj
	D1BsOFs66zg==
X-Google-Smtp-Source: AGHT+IGIsAttalNdDXgr6ZXXOhsJq8ofymYMLw0IYhDa4tt6JeDi2EnLEW3K9zvwL/sEhDRO6/3Uo6f+C/qBqw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:560c:b0:2d8:8f24:bd8c with SMTP
 id 98e67ed59e1d1-2e77ecbd9e6mr6269a91.0.1729794996781; Thu, 24 Oct 2024
 11:36:36 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:36:26 +0000
In-Reply-To: <20241024183631.643450-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024183631.643450-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241024183631.643450-2-cmllamas@google.com>
Subject: [PATCH v3 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
From: Carlos Llamas <cmllamas@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, "J. R. Okajima" <hooanon05g@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Lockdep has a set of configs used to determine the size of the static
arrays that it uses. However, the upper limit that was initially setup
for these configs is too high (30 bit shift). This equates to several
GiB of static memory for individual symbols. Using such high values
leads to linker errors:

  $ make defconfig
  $ ./scripts/config -e PROVE_LOCKING --set-val LOCKDEP_BITS 30
  $ make olddefconfig all
  [...]
  ld: kernel image bigger than KERNEL_IMAGE_SIZE
  ld: section .bss VMA wraps around address space

Adjust the upper limits to the maximum values that avoid these issues.
The need for anything more, likely points to a problem elsewhere. Note
that LOCKDEP_CHAINS_BITS was intentionally left out as its upper limit
had a different symptom and has already been fixed [1].

Reported-by: J. R. Okajima <hooanon05g@gmail.com>
Closes: https://lore.kernel.org/all/30795.1620913191@jrobl/ [1]
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 lib/Kconfig.debug | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..c8b1db37abe6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1524,7 +1524,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Bitsize for MAX_LOCKDEP_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 24
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
@@ -1540,7 +1540,7 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 19
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
@@ -1548,7 +1548,7 @@ config LOCKDEP_STACK_TRACE_BITS
 config LOCKDEP_STACK_TRACE_HASH_BITS
 	int "Bitsize for STACK_TRACE_HASH_SIZE"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 14
 	help
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
@@ -1556,7 +1556,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 config LOCKDEP_CIRCULAR_QUEUE_BITS
 	int "Bitsize for elements in circular_queue struct"
 	depends on LOCKDEP
-	range 10 30
+	range 10 26
 	default 12
 	help
 	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
-- 
2.47.0.163.g1226f6d8fa-goog


