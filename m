Return-Path: <linux-kernel+bounces-373149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A09A52FD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FD81F22034
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9625771;
	Sun, 20 Oct 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5PuEzOr"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69232BA2D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729408693; cv=none; b=sg185QIiP+OZIPpWPOYhs7EG5F6xC8pJA0vr3K8P6gKwIQeIicx6ppoKp9yP+jMPEv3fGFHYQpTCxTTh+fL3cK6bcQiE207Ku/v7JEjAwU/E0P4rffkP2xEvA0xE8yNIRl9E3cq1irf0UQp5er1PBEn7PiojLIyjS4EDd84PYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729408693; c=relaxed/simple;
	bh=DuhaVIt579iaePGxbS7CxuYNp5VFZnfhsFnPQJN+Q34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MHPfsql6rTCpKC4qhUoMS8e9f3RK26WjgGct3bGtjspftbu2IsbkUuiqUq8XDhVEP8z6DI23z5yIE6x+iu1jJhNi8lCmGanZxrxHRjWTlLci9OfoJHHE118DscbrRSDbP6awmktJfOMY6DAKMcSuvu1iQK9S69fspTUFbDRO42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5PuEzOr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso2782129b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729408690; x=1730013490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKNNo6ORCMbRFNJ5dKq8wkAXppSzm4Ntz4bE2iMLwtI=;
        b=d5PuEzOrlmAEhE/aC9WizkiLVYp0sdiVxxGX4oNrDV+nyCz1zsbcSR5mBi8agvd6Fc
         uINnwOyz/4txpKHvUv6/MCZh1bgUwuP3J5JnkPPAETuok1xplfUXlxXkwq0N1uBUV2Xw
         cp71pLWpfugFSBueLhEnEngv3LKH+WlHFCt+En+PAkiWv9lYuqQZyUWIrq+05EFfpXRV
         hiszYfCfKhcWJUywpAXT/yJ36The2amhUJR06hgve27+wMF0ph7/k0H38hDG5MoPDOIO
         LpuCldJG1Gg+slFSTeWsJwCaCeG702xnI/BJaMbLHgECjY1W3mdTwj719waxyzfN49PW
         AXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729408690; x=1730013490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKNNo6ORCMbRFNJ5dKq8wkAXppSzm4Ntz4bE2iMLwtI=;
        b=NG84WTagOe4wqRSulnK3fz8pNqBrl4zlEt/nSbJC6+pSj8pBLZeffVm5pXvk547oM8
         rs+drnOmUhYDuclQvWPyHlOXPvsCrXT4GhJGyMOFUsvTA5mBS5L2El6rJWtNc7S46C3K
         tH+nYmnjb3Zx2tWLZKjVGo3B843ncgSP/O+ZVhGmG7jnuLfqX3FzrWtTIBqXaSFZ0B9i
         N7MPEecNqDvkdCXqkpj+coaNgFBkW6NeawNUhxeWxrSISsPprEXUrFtt8tk2Mqz4+IxT
         1stbvB6BwuzNOUYuiyIj8EQDI400A57cqP/dT9vQpYhQCpB+8vMqPU9+nCaHYs5DcuW6
         nUGg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/jRYnqobjmwv2nLpcyg4iZ5PElCtG9PQi5/O9/DL2AjoF1xKFKR8OLzywf71K7wMWJXdh9ziyuT93VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9IURmF1LjIp++rKIAEKZbaT50w29GeTu63p2Jk1uwFdu7RYC
	xR4wL24B/p7/ES1Uy4SHPeYOWkQvNPox1lv59NqysvghCn1bWZwN
X-Google-Smtp-Source: AGHT+IHLIEPVve3Ub+lLLowcnXy+dfiLi1sT+/U8BkiDnif9wKxlz1RJhQxh/LVPqCXSZaUmTLdNKQ==
X-Received: by 2002:a05:6a00:3d15:b0:71e:79a9:ec47 with SMTP id d2e1a72fcca58-71ea3118addmr11926875b3a.6.1729408690471;
        Sun, 20 Oct 2024 00:18:10 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec140781fsm709022b3a.185.2024.10.20.00.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 00:18:10 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	sourabhjain@linux.ibm.com,
	hbathini@linux.ibm.com,
	leobras.c@gmail.com,
	pmladek@suse.com,
	john.ogness@linutronix.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] powerpc/crash: Allow direct printing on kexec
Date: Sun, 20 Oct 2024 16:17:55 +0900
Message-Id: <20241020071755.328706-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit af2876b501e4 ("powerpc/crash: Use NMI context for printk
when starting to crash"), printing has been deferred before shutting down
non-panicked CPU on kexec to avoid deadlock on logbuf_lock. It is deferred
until the shutdown of the first kernel and starts booting into the second
kernel. As a result, there is no messages printed for legacy consoles,
including crash_kexec_post_notifiers messages which is after the
syncing of legacy console at printk_legacy_allow_panic_sync().

Let legacy consoles print directly so that we can see messages on kexec, as
the commit b6cf8b3f3312 ("printk: add lockless ringbuffer") turned printk
ring buffer lockless and there should be no worries panicked CPU 
deadlocking writing into ringbuffer after shutting down non-panicked CPU.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---

Hi!

My understanding is that deferred printing can also be safely removed 
in terms of console lock as the commit d51507098ff9 ("printk: disable 
optimistic spin during panic") prevented from spinning in case of panic.

Sincerely,
Ryo Takakura

---
 arch/powerpc/kexec/crash.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 9ac3266e4965..5e5260e0d964 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -269,9 +269,6 @@ static inline void crash_kexec_wait_realmode(int cpu) {}
 
 void crash_kexec_prepare(void)
 {
-	/* Avoid hardlocking with irresponsive CPU holding logbuf_lock */
-	printk_deferred_enter();
-
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
-- 
2.34.1


