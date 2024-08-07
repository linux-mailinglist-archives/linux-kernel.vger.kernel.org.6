Return-Path: <linux-kernel+bounces-278067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B61494AA73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54B8281F92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BE823C8;
	Wed,  7 Aug 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZ+qrvqs"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013480043
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041573; cv=none; b=ZQynEJnWg3FPD70TJFfww+1Zqj+4riegusmkAoVwTNLZIGs6VzVhI6gspLmDpkrLvD0ASRoicHl6oykZ31n0W0HWwJndC2fq+WOfTnbmHvD65MaaRvtaikwtIicV/saKKbL3FKMJbmTZ8GQu9o8hQADCr3N6rvpzkompcXZhMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041573; c=relaxed/simple;
	bh=f3YOeVmxmojhXi3gaufnzSIKLoBAKaoOMdbVywA/UMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fAeGPhyWB9PohQ+uCSqJKgxlyelO9JnvnlxHoIatEo9MCHHBsi7zSO9GZHFwoL9UUthPuH7cfeiZAnCi6IxJDQNfYIMZSqsryD42NzWl8xVcE0GuDVTuBcvp8YXnwjzv9OS0+7yaFbpzbQ9g62pELjAKO4czqu2mOyrzm7NSoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZ+qrvqs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so2188925a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723041571; x=1723646371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqtXuueqmWOdgyIxvoAq+O/7Hys8ZO2brsimTty10X8=;
        b=QZ+qrvqsyUcJTH8w5mwGxliNxWyPBAnYRKJzWi0FQ9j4o44len4xmH00bYRrEpI8Vv
         rYidRvfx5PitHk80+Ug8V4XGLjY5NqrupBteXLCTLzQZeHjOF2+WRwigCZLMjAClhbtD
         PGMz7twtpKuXDDxNC1tBsytvmzH191v0NURgy5zkmlmOvznO2Ylqi2yi2xb83fe6U8wn
         r+ntcVgQKtKKg86gDNsZfgmlYiOGwtBFoE2LnQYnT6pB8ZwS/ckpdAB0vzYVtay9SB68
         GMH8dTc/KYoQrhtsf/kf/24+LwGRviLPSeMfURhyY7sULCKfVBY4vjNmNhIPMzZRATOW
         s3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041571; x=1723646371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqtXuueqmWOdgyIxvoAq+O/7Hys8ZO2brsimTty10X8=;
        b=Isv0EH4fYl38aa/eAsXhMhNxJwwDE67zypnvrcSTjwtTHYBhO+gebvc9VDe4LvGVq8
         okNG4FIKvQKwPCuKur0B3WkIvYvu5J7hCbGCKNYYBinK0sc4foHOjQDieK7hOBUlwf0A
         dM7AO9DoE/5JKVCSg9Blr2HGAAcDiU1WhANE73+2PamBK/DvsUSS1FIlj3tCdpG+4OrR
         G9M2YD7NUtr7IO6r1LJlmooTJP5DT2zKSkLiT8BO9oY/QcYDPmnqwzCdyR+M3PR9AWr5
         fMbkgoSC4FSF6m0cNcTTeDUxMdN5zG2ZRdwj8O2cZYrxYR/5yM6Qq9Xc0JNMWDOkIfRo
         5WCg==
X-Gm-Message-State: AOJu0Yy97IRvS70WoCo0I31L+l9LCNTER4pPJ/TntOfkaNg6CgLM6ZQk
	YTV87NLsXd/0B/tzuYQzj4U5EwYeZuCscHtGJhgnETPIrxGwJR9+guXfOTpStheAvUpAsxhFYiy
	8WhG41dVP1Q==
X-Google-Smtp-Source: AGHT+IEOXGTlXZUMfM/Oky/YCvQ5K59jM1O4UQk5Vdj19MQR/IOiSWeGD71TeekmhZk7fpbxOZ03zU6g1XO8BQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:e314:0:b0:719:3562:2da3 with SMTP id
 41be03b00d2f7-7b74883d071mr37201a12.7.1723041570785; Wed, 07 Aug 2024
 07:39:30 -0700 (PDT)
Date: Wed,  7 Aug 2024 14:39:17 +0000
In-Reply-To: <20240807143922.919604-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240807143922.919604-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240807143922.919604-2-cmllamas@google.com>
Subject: [PATCH v2 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, "J. R. Okajima" <hooanon05g@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
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
index a81d452941ce..baaaedfde0cb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1507,7 +1507,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Bitsize for MAX_LOCKDEP_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 24
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
@@ -1523,7 +1523,7 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 19
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
@@ -1531,7 +1531,7 @@ config LOCKDEP_STACK_TRACE_BITS
 config LOCKDEP_STACK_TRACE_HASH_BITS
 	int "Bitsize for STACK_TRACE_HASH_SIZE"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 14
 	help
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
@@ -1539,7 +1539,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 config LOCKDEP_CIRCULAR_QUEUE_BITS
 	int "Bitsize for elements in circular_queue struct"
 	depends on LOCKDEP
-	range 10 30
+	range 10 26
 	default 12
 	help
 	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
-- 
2.46.0.rc2.264.g509ed76dc8-goog


