Return-Path: <linux-kernel+bounces-273377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F362946891
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 09:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A181F21BC0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250DC14D432;
	Sat,  3 Aug 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJyhNl8v"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828A1ABEAF
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722671225; cv=none; b=i71WeIL4GNB1fSVHFGut0oo0gsqjguii3+ZWBdYiPKSKjeADWj/xdNIpPUx9M2wYyLACCnd9KMX5RPPRrRhJShN+lwJQbrr/lbikHPRF5wHhWAjGSWxcTl1cYSkmXP20xO1fs/v1K074s1ro/rrpCPa4IrvHWzDvI/QL6m/e43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722671225; c=relaxed/simple;
	bh=h+Tu3fjZvF5oNG4yfhrmqJN1U8o5ak9xDG969pbYbpc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nad/LXZ/qtplj4+LvcUg7VWVZCtQQ5BTE4zNrGlf7/jw0Sq0l9MzjSlf/eWxI/8vRa9UMMxBCTWBe57WBQG2OJMxqm8+kK4gPxgERoqvyuKzRolaC601P0A+RO47OB/x8jMEz9yEmcccB8lCIceO0hTY9cDdKjERMRJOotvPVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJyhNl8v; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19c63so198969347b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722671223; x=1723276023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W+8zGdX+0w0z65lZvEos03h3yEnQFMCquba341r2hLM=;
        b=oJyhNl8vaqfrPOlF1QRzcGXNScypLvc9b9pwsp6sBBVFAo6DZEYEBMv38Htdp76wSe
         ZrRDJNqdmUxKjcpP1PQKpW45GQxxrxg86XUPZJyKcEobhfMVn1Qg35ln0/HjwWmunvmC
         GxmCw9H10tUf8g168QSIkirFIX+V2D+vYZFd5YmQ7Qjim7TyfqURlw3M/RMsS8aS1EyY
         +w5UADQE8wDmi+Alp4nhwbv2q2HKjLD3UxMVlIDBRjoJv8kZs5Wz7MnFNR0FMnt0+q5e
         EhDfBaUMm3ho8perb/XMOw7XX4MA54sbs0rCOoz13/NQ8/KHsdqz0u7Ys9nC26NeNu6m
         4viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722671223; x=1723276023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+8zGdX+0w0z65lZvEos03h3yEnQFMCquba341r2hLM=;
        b=OZNxAcw8l0ZRNst7ELh/Gfuld9OTh8uzgzEsUVYvMVN4MGgBY6qTGu4zPWORmFm9i2
         9bKdEld2MOH9VBZUlcNFPV2QUIreeN30Ywaed4Rt7VV6QI8beBoZgk1ilAcQg90WrPHX
         eUcdDOca9BHS4czvke8YJEvj5AhZBoKyZgC2/GJHGp0zptg1Ld9BpEWpI2e5149l0Yny
         GMXbN7Y1zBm7BdSYfPDMvZ4VOSJQdpyesisxsaJ69RTeARa/J0e3ChJ6YCWxpiPO5PGY
         99Zjm7vET1K51m9mDTkDEP4njarehH0/2tI+b2HlZ1aqlp2ZiLVhhfLKWs0OHILp/xvo
         xNcA==
X-Forwarded-Encrypted: i=1; AJvYcCW/6ERTMcXgg5pCeN8SfWodJ8/8+HBWINrsO2wWviRCoqoyQh9twUcxWoSkEH+eEGRhB7Z+EtXnOiCsPwIG1dHsPHYg5FJ5OGVNCoB7
X-Gm-Message-State: AOJu0YzevOlSX5xn+wb28K41bek8Jo5cpdZeOhNOr9tL7sYdjzJdXfp7
	8KEiY4E7XYGCE0VUq19HHHk/TMgLHN2gLLn8T03zrvfmKzXJ2enAaViHB0STRQHseLndytYLQQN
	uM8LzYM4QfA==
X-Google-Smtp-Source: AGHT+IEFvJMwtbC2qA1hrhSyqEbBOlj9S/WB0A5Ne9EveISmD2Fy+ngxQ6PuxWVSb3UKNzYz23fd8E5vGR776w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:84:b0:646:3ef4:6ad2 with SMTP id
 00721157ae682-68964d49c8bmr3342287b3.9.1722671222680; Sat, 03 Aug 2024
 00:47:02 -0700 (PDT)
Date: Sat,  3 Aug 2024 15:46:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240803074642.1849623-2-davidgow@google.com>
Subject: [PATCH] mm: Only enforce minimum stack gap size if it's sensible
From: David Gow <davidgow@google.com>
To: Alexandre Ghiti <alex@ghiti.fr>, Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: David Gow <davidgow@google.com>, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The generic mmap_base code tries to leave a gap between the top
of the stack and the mmap base address, but enforces a minimum
gap size (MIN_GAP) of 128MB, which is too large on some setups. In
particular, on arm tasks without ADDR_LIMIT_32BIT, the STACK_TOP
value is less than 128MB, so it's impossible to fit such a gap in.

Only enforce this minimum if MIN_GAP < MAX_GAP, as we'd prefer to honour
MAX_GAP, which is defined proportionally, so scales better and always
leaves us with both _some_ stack space and some room for mmap.

This fixes the usercopy KUnit test suite on 32-bit arm, as it doesn't
set any personality flags so gets the default (in this case 26-bit)
task size. This test can be run with:
./tools/testing/kunit/kunit.py run --arch arm usercopy --make_options LLVM=1

Fixes: dba79c3df4a2 ("arm: use generic mmap top-down layout and brk randomization")
Signed-off-by: David Gow <davidgow@google.com>
---

This is one possible fix for an issue with the usercopy_kunit suite
(and, indeed, the KUnit user_alloc features) on 32-bit arm. The other
options are to:
- hack the KUnit allocation to force ADDR_LIMIT_32BIT or
  ADDR_COMPAT_LAYOUT; or
- similarly, use an unlimited stack, which forces the legacy layout
  behind the scenes; or
- adjust MIN_GAP based on either STACK_TOP or architecture.

Of them, I made the arbitrary call that this was least hacky, but am
happy to go with something else if someone who actually knows what's
going on suggests it.

(Also, does this issue actually mean some strange legacy binaries have
been broken with an rlimit-ed stack for ages? Or am I missing something?)

Cheers,
-- David

---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index bd283e2132e0..baca6cafc9f1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -463,7 +463,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 	if (gap + pad > gap)
 		gap += pad;
 
-	if (gap < MIN_GAP)
+	if (gap < MIN_GAP && MIN_GAP < MAX_GAP)
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


