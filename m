Return-Path: <linux-kernel+bounces-224349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAC491212A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D54287ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0675816F8EC;
	Fri, 21 Jun 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCsWLhSW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F516F854
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963352; cv=none; b=P/PDdVSQ0tBaK/btqZ1u4YfDRpPVf6CR3tVwKFHKaXSBsN0vsTczuUUdKXcC0LVPi61nyg3Ct9juDyTLRZT/eJYIy3mFrhPYe45DL16bG+Uxt2sjZ9SdXCo7eH6vQs+U0drEz+8IPfxjN6ISwHH6Q1ooEFSMQ/ylyZXvWDUyo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963352; c=relaxed/simple;
	bh=uCO2VSbQodgwGUyM2+IVY0wjKU7VdxPemtcfL5e7cDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tVR81QZvoadozwBe4c9gzfTfzQitsuXCjqsH+N94Yuw3yZd8mNtKjykdCZxArca39L8ng8SU7iKYWcRVVYMl65zmf1b0m+geHL4Nr8hyJhUJdqqV+4FyXSaKdfjlUjFb+sf2hH8UOxyO3XZUCvbD3s8v5IVpCOuZiLZutaoA5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DCsWLhSW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f4a831dd8so31232087b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718963350; x=1719568150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eL/gHuBXiJhQGsaLE8w3CglcJQmq/s11xOk2yS5eag=;
        b=DCsWLhSWTFCjaDmgAi1SSomlv5FGFOc2eCXvulVyq4kjC6jZxaaifsNVYn/JCeUVpX
         iI4slP7P2M/GwUIw0dPehCVe2HQAP3fnKpFoSTZ3o8m72YG/aiD6rnVcKPNnnTBadyQH
         vCUSgE6qDrvNr2YEX6C6CVCSr7qgsM2k/gq4hdwO1k5ye+ACH1wmWqaC4LLrAUOXaZur
         MGDnGXlQHdsVOzcsZ/s49BN3EWZyMwIUPk3tpNK5cMXhKfJgf6GE0EDGc6+ze9jiT0k5
         MrllCIlPDzW+Y5CpMVoHJ+1BR3aep2XPk62rySx9Teo+Twh7VVdoiNzeF60qkOhkmL2W
         M5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963350; x=1719568150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eL/gHuBXiJhQGsaLE8w3CglcJQmq/s11xOk2yS5eag=;
        b=XFVd3lpZx3QhKhWGWZBnXzUq/1G71Ids9X6HSi+VUuQWDQmi9EQHYW4wzmxMNQK7d8
         Cy6I05bCBU1l11GdNVREc9TAijte/ReUmgMYlEQcDYFKtwlPAsonkdBF/zN/nsE5GCRK
         +S97jDNNHbpS7TLwI+6LoC7bVA7y3PhFOXGxJTwqoFfKh6Urrpkcs4C+USaonRCGVzJQ
         Pe9MrqnHp4egrvvD7gJetAzeg0gOdx0VVq4XahFRRAfDMvqUmQ07NnQgbFkwjKPcDUZb
         GX8RVIqhitBjrR2RW4bVqC2pvUCFi1fXr5Z0nyVss8bMz6Q1kMOXcpg8Btw3FPaBVg8I
         BPhw==
X-Forwarded-Encrypted: i=1; AJvYcCUIvHf1jJNjjq6tDcsl6+QVMw2aC7Jx/iSMjsCp5GhCbW0XCCJUX1VjQG0qF32w+zb3A+VbD0xoLBt23w2q292SZW5MKYxHtMR9mR35
X-Gm-Message-State: AOJu0Yz7+nR4CwBxbUCsjjOlS7XvrbLxpVtKieJS72Cy925HfIVfIQky
	u/ibVakB5gBSrKG0dLaJ4UPQMQCAFYIfd4835Oz/iMkuOAKzSsCMEwBezk7VTTNYwRqUqiCj/5O
	aUw==
X-Google-Smtp-Source: AGHT+IH1jAOp6GnsLkvlyvbw5Sxjezoviab+i7lU+WCUD25LuT1a2wwzM7v4IQ5cXOos8aPcUmzgSUhc5F8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:485e:fb16:173e:13ce])
 (user=glider job=sendgmr) by 2002:a05:690c:6a09:b0:62f:1f63:ae4f with SMTP id
 00721157ae682-63a8dd018b6mr14369697b3.1.1718963349823; Fri, 21 Jun 2024
 02:49:09 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:49:00 +0200
In-Reply-To: <20240621094901.1360454-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621094901.1360454-1-glider@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621094901.1360454-2-glider@google.com>
Subject: [PATCH 2/3] lib/Kconfig.debug: disable LOCK_DEBUGGING_SUPPORT under KMSAN
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

At least on x86 KMSAN is seriously slown down by lockdep, as every
pfn_valid() call (which is done on every instrumented memory access
in the kernel) performs several lockdep checks, all of which, in turn,
perform additional memory accesses and call KMSAN instrumentation.

Right now lockdep overflows the stack under KMSAN, but even if we use
reentrancy counters to avoid the recursion on the KMSAN side, the slowdown
from lockdep remains big enough for the kernel to become unusable.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Closes: https://github.com/google/kmsan/issues/94
Link: https://groups.google.com/g/kasan-dev/c/ZBiGzZL36-I/m/WtNuKqP9EQAJ
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8f..036905cf1dbe9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1339,7 +1339,7 @@ menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
 	bool
-	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT && !KMSAN
 	default y
 
 config PROVE_LOCKING
-- 
2.45.2.741.gdbec12cfda-goog


