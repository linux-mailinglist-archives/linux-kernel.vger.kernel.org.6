Return-Path: <linux-kernel+bounces-275522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030A9486D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD482B22A83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC7B676;
	Tue,  6 Aug 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5xeQqYn"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4F79FE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906099; cv=none; b=XCvOinZlIKX7iKrBRtBQCUdkIXkQVPhlZyGuSwAEvcyAThNjIJlsw7AtVTX0yqs81Z0n9w6dE+C29nil00ZfWOlWaM4BMNnExxsAFnRXkoX/t3tu/CAT+bnitSmwCWA8Slb7WHgJAjn+Cyd1s9lkRaIarGPzS/EiJgZ/Nzjq4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906099; c=relaxed/simple;
	bh=lEREMC8nwP8bMnwwRi/0BYTwDxD2mNtJ6dPerEYrHpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RRFj48bT3wG9Pg9DnZMy4TPKXiRB5TcTlcD821YhomDZyOrNcdhtrvRNwPDNzbEZZ772gDc0WASqh8MwfpVE6dEK5XKiB9/hSi3gvgBtRvOBe3jnfvYHevcXBJe4Tg7A3qeaLupBiomrzG/Lp+3FE6SZv3Gb7Wih1HNgbDaDqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5xeQqYn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb6b642c49so6285047a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722906097; x=1723510897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=REuCo1faqXAX+8qIFuyehGQRyeUKRlEhQVu0+BMNAnU=;
        b=G5xeQqYnMlx5gFgRCPJSwdgc7CzX8tjKq81CzUX0lXBDysqwznEuD8kf/IA03OjtYc
         MadN+jJnwWGVHfw4zZ9h8/U2VGZ5/lcWVKlB7NmoM0+3D0JsaqIv0Ua234UeMUN68XKl
         jM6lkWy8syjWVuvqiZv0PCvDrTkqcasI+ZpNAEQurE1rZ6nU5HTpVN7hmuMCPgt61Fj6
         mwk2wnSbO8uyrOzaseQHCKt/GjK3dFfqB9VIkbxP8p3JoE/p6zUOOK9PSa2W1zsRWq+y
         86hK/IHzL7t8SAlNRylFqrPJ2bSu1BG5bSC9o3w/FLzPBpsyebfNsoXBaCxz3noBEOXk
         j5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906097; x=1723510897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REuCo1faqXAX+8qIFuyehGQRyeUKRlEhQVu0+BMNAnU=;
        b=ptl64rZvjkXBzJDxjv68k9KUjZ2psKCTl8o7zrTIB/4bnd6tpy2BHATk1CWz6e+qf8
         PFY08uafNG04IsRdYc3KeNVDrFW92iaYopJMSH62PZBX1HPjsbhI5Vsn7KEC3o2H+eCX
         kBBX7bNhPgKEZxgrc7qjamBEKf3nwvyCMWposaq8S02GXVTPWo2fbrYWgFYl2Dh5gICf
         5lUAxxTQHMIR8oUxXhULdIu5ELg5wFGwduzVua7SzQiXpYVzDY3tUA5T/W64d9PrnhW5
         sH9XOcCZF2ELBTJoZEJ5TY/oiCiujTNrDpt7d4e0xd0W+z8NEZl5C06+/Wd3Jn0o2vKa
         CVaA==
X-Gm-Message-State: AOJu0Yy9IUt3jyJPlZFDGs6TDaWjuSHL5hBvn7SnaUF+bhtu59kM8+zj
	IJql0xUpx+loiYmmwFvh7p1VZupM6fiAYIZk63JiGiCHFugwc3NBzgPCInpKqWKvMQ9hLW/681G
	WrMSAzUcx1w==
X-Google-Smtp-Source: AGHT+IFmjCbQdd3T2JsDntUYDK5xEnBc8mVdC7metrm8H5PNsi/BrvxTz2dEN9ZEl7QAURhMlPxWajje6RFB8Q==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:ca96:b0:2ca:f1a0:8e74 with SMTP
 id 98e67ed59e1d1-2cffa253021mr116330a91.2.1722906096969; Mon, 05 Aug 2024
 18:01:36 -0700 (PDT)
Date: Tue,  6 Aug 2024 01:01:24 +0000
In-Reply-To: <20240806010128.402852-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806010128.402852-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806010128.402852-2-cmllamas@google.com>
Subject: [PATCH 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
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


