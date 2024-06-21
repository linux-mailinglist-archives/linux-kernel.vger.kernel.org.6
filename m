Return-Path: <linux-kernel+bounces-224350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8091212B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1801F22F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3216F907;
	Fri, 21 Jun 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpJlOJGs"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354516F8FF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963356; cv=none; b=ZOo8dRPp/k8c94iDR9ckSnel7jt8lltBNrrmy0xoLIBx2B1PrS4EYm9oT6wrB3IDouYzXkI5MZJJqY2LR7ijuVkPBLUUmJai8XvTSSHfh3uqmysSHIf7T+l9ZaVzqRf1EYEF3aJSVcS5f/9ZJe+mcpzeN9ek8v4HuGQqsnN9na8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963356; c=relaxed/simple;
	bh=v/ldlemxVMMcemayDfndy36Ogn30NjlRxcNZMrlA4BE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z0xUIXofLATryD0Z+TnbTV5alizdyVVKaKpZNBH6DkAAyxjtPUBbe5+GejygBir9EthB/973Gb2l1+nDGyO5dCq7lKHEm8KgM+48IdMSJXx25ybvhcbwKuwxMkGsSWalfunSAUkwXrM4cZiLZ5eyXAF+c0PG5z2PT4S0teKnfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TpJlOJGs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b8c0c2c9so3186498276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718963354; x=1719568154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSCs+VWsj0iopZmQTsJ5EAfOOj9nyp4YpTWWR5DFcsQ=;
        b=TpJlOJGsJ/PDSnFk84xAOGVIxU3pQ/KJ6CuyWf4+iVI/Ko3YqpOaOUiRfAcQi9q2sw
         ExOPwXOcH1TZioNRCOPHlTc/qsT10I32tgym2j7T112rrx47dDMceuKHAvggxYU8RgYB
         f0NfFwzqOdbnJkPn5GgK+kfG6/XFFr4Xj2HcvmnvM7M+f32Y62d+PjIo1OppWJvVrXsV
         WgaCpHRAXFIUmuWTDhTxeOQT4d3BvagnJFm9Ss+QG6EyKBCtnM+fRcTCR8VpMrp4yPpN
         JAC6Rt6rI+iwgFHvrFk/vDQ5Cq3HM+NOUNbeOUaK0iou2gW8+Ti9KCOhmDh8B3O4KDRU
         jq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963354; x=1719568154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSCs+VWsj0iopZmQTsJ5EAfOOj9nyp4YpTWWR5DFcsQ=;
        b=GSFSp0i3Yhba73qxwXKMKTXRtdqOwKRZWAtAxPDRSIxC0Limg9Z3QHwXabKukDW/Qc
         gzrHCvh+jnoglk7aNTFHdHL5iYbrkzTRj1RDN6leWuJQDxNidczmbearVwrzKJAudArT
         mtDW7gTbR1hvC3WsYjwMPji1X4S7ApTutiqRT8JgLsWSxnB3FVk6ilRJf0LBnaS5rALD
         KBGoP9uKbx8msnoUCWrJaIITkNtpy7cHygvH9rvMAS5EjZ42rSrHLMY03AlVJ0nd5ztv
         Z/jbH1DtRRObPO7SEhbdRVMp1ezR0G7wNmzbx+lJ+EtE6KZ5XAPacAWJZjXLxeQDTWRY
         33Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUmVuHxFlFGQFwA1C14+Sbg5JuOnmSua3QXZ77EvyuE2B4tX6oyLWHdOxjQrx/4vGZjTOhNHiZn1yG/LgCVnOE/tKFChsifQYWtuC6x
X-Gm-Message-State: AOJu0Yw9M0OeQ3CbV3n7MvCeA2YYmilOxSH1u7sc+eoIEMOvn68DO1Kn
	8XBMoBlueYVNoYJDG2AXQFcVePyf+8PfsuM5+BR5C6kgX+Pg2xmownqOuWs6Jo7jTb43ToitNDQ
	FCg==
X-Google-Smtp-Source: AGHT+IHteQnPbjwwYdKz1+QmSWpCUDs1cV7hOlX5JjBXIgwgwcuSkMEKT6a+bLAfntWylHISH93pcD2W2Wc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:485e:fb16:173e:13ce])
 (user=glider job=sendgmr) by 2002:a05:6902:2b85:b0:dfa:849d:3a59 with SMTP id
 3f1490d57ef6-e02be215fdfmr2036829276.13.1718963354053; Fri, 21 Jun 2024
 02:49:14 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:49:01 +0200
In-Reply-To: <20240621094901.1360454-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621094901.1360454-1-glider@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621094901.1360454-3-glider@google.com>
Subject: [PATCH 3/3] x86/traps: fix an objtool warning in handle_bug()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Because handle_bug() is a noinstr function, call to
kmsan_unpoison_entry_regs() should be happening within the
instrumentation_begin()/instrumentation_end() region.

Fortunately, the same noinstr annotation lets us dereference @regs
in handle_bug() without unpoisoning them, so we don't have to move the
`is_valid_bugaddr(regs->ip)` check below instrumentation_begin().

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://groups.google.com/g/kasan-dev/c/ZBiGzZL36-I/m/WtNuKqP9EQAJ
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/kernel/traps.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043a..e8f330d9ba5d4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -217,12 +217,6 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
 
-	/*
-	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
-	 * is a rare case that uses @regs without passing them to
-	 * irqentry_enter().
-	 */
-	kmsan_unpoison_entry_regs(regs);
 	if (!is_valid_bugaddr(regs->ip))
 		return handled;
 
@@ -230,6 +224,15 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * All lies, just get the WARN/BUG out.
 	 */
 	instrumentation_begin();
+	/*
+	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
+	 * is a rare case that uses @regs without passing them to
+	 * irqentry_enter().
+	 * Unpoisoning of @regs should be done before the first access to it,
+	 * but because this is a noinstr function it is fine to postpone
+	 * unpoisoning until the call of instrumentation_begin().
+	 */
+	kmsan_unpoison_entry_regs(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
-- 
2.45.2.741.gdbec12cfda-goog


