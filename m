Return-Path: <linux-kernel+bounces-542381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639FA4C90A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EBC1898EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4426036E;
	Mon,  3 Mar 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO6AzX/p"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CA25FA2E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020814; cv=none; b=LEmem+nFwZlJYTyySwSm4EAA69P25uiLu8Aj4z3F/80IKWtUV0PAwPbGPybgAm6Eijf7iqnpeQ/989U7gncYX2Q0sCc/9F23HSXC/rdPaz9QrXsvgLJHGDYrfpSrGsf2ShniqkQlVk/bfO1vWo+3Aq+d6NKHiO3CxTYvztIjvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020814; c=relaxed/simple;
	bh=K0u6jh2WcTcw916LX50fw2JPVkRTiPhzSaSc7Ar5iDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+7GhYJVG6GC9BBWe/1nsWxWasT9H6GDyVqypZpLOVbhgr5+lm006zgXaCgDBgtyPgBv39W6/PNW+am17VYWxH2HDnccGmt4OFSnycKOYNVLiByLO6oP+eO4QyWIQuILZ/G5KLMOho2TqwTWJO6/v4TiusafXNcdSoQ2THoEcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO6AzX/p; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0848d475cso616925585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020809; x=1741625609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS5ROzQVZyeVGElnAwUMjPqqYx53fOprAY8iMrz7sKI=;
        b=lO6AzX/pu0TSlN6V60xxY2XrhOc84/LVP5H54AiVmKXs2sCU2HkD2vMBzHgdvGpMb3
         9pnZn0yl6GzjIo0RKUvTq6/jrGODiMoOCWWjY74LjolJjcWHymk+MEcli4vXFK5uMt93
         cUShwJujH7K40cA73JJ33HhXIgFwpRNZIy3WtVWhuvjbhGHPBbGOHmFN2ue6+rEkTo2n
         bgP1mmMJ9WG1TPhBLoYSzue6/i7OKTdqnmJ17/+XhL7qTZGMK750IhtY8lqT0oowvIc3
         8zIzjfE159si2TxSOV4Nju8R68RcD2hJxDzZRVl741V3Kf4OA/C3Uefb2BRdd0Zk2of/
         Rk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020809; x=1741625609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS5ROzQVZyeVGElnAwUMjPqqYx53fOprAY8iMrz7sKI=;
        b=mUbA1IOKGsC5D3xO9SixuQ6nnhAaOk5HRmszrKSuqtKJriVcZVUg69QstB0rGGA7Ru
         YDk2H/QDSvVUrUV1fLYYi+h/hBXWmTrt3pZObhkGj1+crEkYHBrpSoNzKXeLG7tkqM84
         idHJJEGzcC6ag3l+1jJxry+DJYm/LianY5c0YfyV0x/qm83GhKbSFisZRpoXX0rhlpFp
         EWKzZA/w0exM8153L7tkO7NMNpwWGBypyxWhiw6KQXYIDV0/klM0i7b3AZtn+1W96r/H
         c7HOl+zk/1hS4t80LWUvFhIuzLOswwzXjev4aqEpXHY0HFfpFLrjRPeSwxnaUldvfcLJ
         ClFA==
X-Gm-Message-State: AOJu0Yz2NwyyIKpWvIlethxEXS77l4paqQlI3BKsM6r0l2+07F3pWj7Z
	fvlM5WbD4tNBMm8+cKlZvda+9oNcacAhSJ8tYJz1DnyM8W0VgP4eNc5M
X-Gm-Gg: ASbGnctgodpObeb4rWt3L0zN0FDIUR6w714SQ1dOvhbzPPtN1R6afIUcMIWgjt5p2eZ
	BhTn4kURk9P4J3glTd3xGVk3ywpPPfrCEvmLKX1dXknSidwjos8K/6SzC8TH48Jt9k4bagNiDou
	8oVB1SNMvqUEjW1I2xVPK8hj0872JT+c0k+/nj/Idm5x8aEw0HH5zMRR2AmugAD+dxiV0sN9BF5
	/v4+8YH8foQytRSCohOoZ9UD488IKYMAVRfTNTr2d7aAkGT7pvl4uODV0VerrpcoxUdQlh+n5nw
	b7EM6VBOdmXpYx+2EAFYvacGZQ==
X-Google-Smtp-Source: AGHT+IHujfcxWb0od0xpJ2ONYVMNZDtoedt9Ys8StxXBGoFZ6pN0Xc7LRNpdnzsY8M8ehNAAlIxYDg==
X-Received: by 2002:a05:620a:5641:b0:7c3:9d35:2c91 with SMTP id af79cd13be357-7c39d353655mr1559305985a.5.1741020809540;
        Mon, 03 Mar 2025 08:53:29 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:28 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 10/11] x86/stackprotector: Move __stack_chk_guard to percpu hot section
Date: Mon,  3 Mar 2025 11:52:45 -0500
Message-ID: <20250303165246.2175811-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index d43fb589fcf6..cd761b14eb02 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -20,7 +20,7 @@
 
 #include <linux/sched.h>
 
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 
 /*
  * Initialize the stackprotector canary value.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 58b63fa4be6c..f06f7b2a0480 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2132,7 +2132,7 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
-- 
2.48.1


