Return-Path: <linux-kernel+bounces-393871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1D9BA68D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77592B2144A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801C188700;
	Sun,  3 Nov 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2z3U/RC"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58437187FEC
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650211; cv=none; b=gbVD9JuWBYg+rzgTst9s1j7ExE00ygz05yih7OaNqwurpWMTs7yZ9pWXC9XvAmaH/v4F6g99P1bRzfhnqMvqbpvqUM2tpH3olGUWrgfI1Ozz7Uriv+zreahyDN1yyw4pL1eXHmEM3PNKHah0dkGrLzAgE6s349UBtEgP0mjhYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650211; c=relaxed/simple;
	bh=HhEK97psqvQIAC9LUTfYzE+LxUNOqY41gQ2WE8IAacA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTVFg9wgQexceUgorKF0slB4kIvDovBVkFqqKipqekMj4kmus8+1INVQmHzA7ckydSSkgeSUQKUTGO5rocSetC9Wqgu+9sgimDqywhstsb4RgGRqtjeW6baMt5Jruz5oVZr1XXL/Gzqs17NRmSznuqjA69kMOK3A9kOCwywEcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2z3U/RC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so4050637a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730650208; x=1731255008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY9gU4Q5FGrh6gvrAPxqXN7yoOJhl+d5ufAcl/DRkzc=;
        b=g2z3U/RCNxUAp91bkBRDKtMkIoEG6OG1FV1j3xWWHtH4vTApzuAjse0AO41I1osuHF
         UDTmmtl+9Ia6LpnjwZ45mEEd8nQ1z3oy78LNS0+ldCNdVOoA1D+BNTmChDrT8NEeSbxr
         54UnZSZxz7Hg7y+DN0cA5jnBzL8o82A5Vm5haF8dMXI3TKfaIorxn+uG+pHbjwbFWait
         +zKBF8z/KV969Xm3xrwSmJ7GEcjQ+x65O7yueZA4vMPcJuJSzkyLNxAK/i2B4AQeUVjy
         cI1RhGVua3t9swjzi2yJljH4o5PGEW+ztS0WIaSMVl0OvbMf+zcXL0sTshLew8iYZb4x
         hU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730650208; x=1731255008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY9gU4Q5FGrh6gvrAPxqXN7yoOJhl+d5ufAcl/DRkzc=;
        b=pOgu/AILPKkwMwSNJ9MVwBb7cDAGsxQ0roY5ORTjxEHPu46w4VS2htwFE4MTIrJSjN
         0uAGf5+ODqSTCJ0evEeoL4wvqBScSgS9mXc14LBnPHUuTaPWt5Q68utu/kv3GKMlUsqN
         PGY3TBzLOyaS4xDfHCCxXnSLDHkrZwRm2lkD65U57m2U3csXO9wCfDumL/wMg7aHjyXC
         l0G2G9wDzrY9ZZAeNoV3Caf+VzLt+vopnnllsOkppKMs6/ckeSsEZ6f/JglWnOwun06A
         1SbhzDpaz+zuuhzdz+du2AnYWwV2OoSni1DnfVgGJhoRRH5DM+IWR/iO372J3lnmas5V
         vWJA==
X-Forwarded-Encrypted: i=1; AJvYcCWDMmZp4ONd5iYGFhFA1P1Bryz1Qy5N54KibcIDSAWnzOYRch87k8Rsw9lAxcRGmmND+9hK2fcRaoNSqxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jWRGWiN8DGYxHgfboRge0MJo2YHG8Fh5YunhWflRdYh1/nBZ
	4TxwDyn3m0QY2iqIdakKqocZ0NVskkKnn73NiL+TE+0D20br0yW8W0nhSizj
X-Google-Smtp-Source: AGHT+IFLb6i3/9fCagjP7RfompZ6eGhM07YRZ0oOU3IGjwoiSFJ0MnvoKV+UG2y2FjDpxgMhlZHY6w==
X-Received: by 2002:a17:907:7f06:b0:a99:5d03:4687 with SMTP id a640c23a62f3a-a9de5ed3e39mr2757749466b.21.1730650207228;
        Sun, 03 Nov 2024 08:10:07 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e0a84sm435718766b.138.2024.11.03.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 08:10:06 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Beulich <JBeulich@suse.com>
Subject: [PATCH RESEND 2/2] locking/atomic/x86: Use ALT_OUTPUT_SP() for __arch_{,try_}cmpxchg64_emu()
Date: Sun,  3 Nov 2024 17:09:32 +0100
Message-ID: <20241103160954.3329-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241103160954.3329-1-ubizjak@gmail.com>
References: <20241103160954.3329-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86_32 __arch_{,try_}cmpxchg64_emu()() macros use CALL instruction
inside asm statement. Use ALT_OUTPUT_SP() macro to add required
dependence on %esp register.

Fixes: 79e1dd05d1a2 ("x86: Provide an alternative() based cmpxchg64()")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Beulich <JBeulich@suse.com>
---
 arch/x86/include/asm/cmpxchg_32.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 62cef2113ca7..fd1282a783dd 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -94,7 +94,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     : "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
@@ -123,8 +123,8 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
-		       "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+				     "+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
-- 
2.42.0


