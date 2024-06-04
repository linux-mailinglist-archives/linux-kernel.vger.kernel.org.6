Return-Path: <linux-kernel+bounces-200742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D878FB43A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D4A28279E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B897127B7A;
	Tue,  4 Jun 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxLIYsfN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEF64CEC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508730; cv=none; b=D80khEP54hnKRg176QPIzf0SP58Z08jsd8HEEw/175fEWtsYv51MtavgZzxSEdLpX8xy/AUcqXzU869R7QKFQXpHkvj0DqhlW4QOZ/uOCLui+qtn1J6cSac3y9aChNCyiUKKHN4CI/T0xoDWN8pc3iOSTocJSM/o6kxaN1HAmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508730; c=relaxed/simple;
	bh=Q/3S4IM0+lkbuvaoBSCVnF9EWsdDHxTYH7q0BMIlaVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z4BCwMk8YcbMJnWScBJP8LIpofsF1WvafRSWT8rGhhxFCzYiSDcqF10UzuyoLI+SZYaQtwaNPGaMxCDebHDbe2uu16mvXbAbAJLNJqXciWKAZlGJtGK+maBFZpAnKI3JaZz/9OJLAtKjobDamtadkzWAG7a7bZJnH6JRDc8n3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxLIYsfN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a50486746so17166397b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717508727; x=1718113527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=npTzBRGDQZLEXKsoPxnrziHXCVeKHkYnd87neXVciCg=;
        b=QxLIYsfNqLZ3VZGP7+E3gudTZQdY2l1dsvCdyhDufd7534IWeShiPxFF4jJzbNksww
         JRCRuBR/CzXbu/bmhAzyXeIOH+InDAwxbZGenSgml3Kj92Gxbm21dheol4At+km3vyOs
         bghX1RlgFJW1SR6/UA5KVRc1YGBOLpaSOgpL/JpNEFwQLQtPJOaBqp4Ie6Dj78g9R50h
         pPJmuhq2tN4bysEsaAnZUsaqxbRV581p1N2Hf32axEefHHcAk4kGkZmNyv1WFb9xTYz4
         AGgLPvN+j6qh4d+f3zo2aZw8tOiW+CGE6mVlz6719U46EZXd2IlR5thtHu7kFwjGf9Vx
         FUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508727; x=1718113527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npTzBRGDQZLEXKsoPxnrziHXCVeKHkYnd87neXVciCg=;
        b=fDlr0cQTBNlPrv06vPbT9wL7/H66uDI3oDlVR8FrnjLYipP9iNGX36dh2eYyHDSD8K
         z8YOoEii7coDQKvxetyM3zy/ewXPprOpRBNZOLVbvvNWl++nkR/owPv5XN9EQyftcMez
         VLK5Xa/PZ2rYinsg9gPjy8CcJx8daXFKZCflJqqUoT3nLWm/J52/Q7YdKywFUqLA+RCO
         8tnd36gTz1x0xcU4QxVd/tu8qqwUZNfZw2sfeOjanO1JBElskvzqwRhhSsXVFyVmhzpA
         Bs5g3cfqqmnOg9wdmCIKgkNeE7UkJVcOpkDtkrIDyVxAVXzFrpUqPhu+oizCpeP0rr7H
         q5cg==
X-Gm-Message-State: AOJu0YykQIchKc9h6/v1hwdx75yl6VydmvvSbsXgkcDWvQbo+PwG9ueN
	Bz/GMn9onYxtoJT+iH2KaBJBns23wn4t9231nyuxMTW+zBGZG20p9tDOIaA/x4KT3FcEgE+sb7M
	KmFCOTA==
X-Google-Smtp-Source: AGHT+IHFfzMSi1l9c8kj8OY+kUAMbW+CfVkib0L7CP7s5UUsfmgL1CTSsORRjdoK21leqxlX+REyI/Y00G6s
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:789f:7f5b:3f40:46c8])
 (user=dvyukov job=sendgmr) by 2002:a25:ac99:0:b0:df4:a393:8769 with SMTP id
 3f1490d57ef6-dfa73da3e11mr556704276.9.1717508727172; Tue, 04 Jun 2024
 06:45:27 -0700 (PDT)
Date: Tue,  4 Jun 2024 15:45:05 +0200
In-Reply-To: <cover.1717507310.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <4c05efefe278bc5b140dba40eb1d195cceb2e6ce.1717507310.git.dvyukov@google.com>
Subject: [PATCH 4/4] x86: Ignore stack unwinding in KCOV
From: Dmitry Vyukov <dvyukov@google.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Stack unwinding produces large amounts of uninteresting coverage.
It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
It's not particularly useful and is not a function of system call args.
Ignore that code.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
---
 arch/x86/kernel/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 20a0dd51700a..cd49ebfae984 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -39,6 +39,14 @@ KMSAN_SANITIZE_sev.o					:= n
 # first second.
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
+# These are called from save_stack_trace() on debug paths,
+# and produce large amounts of uninteresting coverage.
+KCOV_INSTRUMENT_stacktrace.o				:= n
+KCOV_INSTRUMENT_dumpstack.o				:= n
+KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
+KCOV_INSTRUMENT_unwind_orc.o				:= n
+KCOV_INSTRUMENT_unwind_frame.o				:= n
+KCOV_INSTRUMENT_unwind_guess.o				:= n
 
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
-- 
2.45.1.467.gbab1589fc0-goog


