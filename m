Return-Path: <linux-kernel+bounces-252038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB8930D67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB811C20F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4113A863;
	Mon, 15 Jul 2024 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHF53Get"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0D219E0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721019999; cv=none; b=SFaRkrtS6yGK3E0jIxAwzVZULyuXKt+kHQts6vkxETtgAAWpSplbGdub0GYGr9w6NXuk7lkags+JjmoWFaBKik1xVpQzRyNAZn5xk96u4oM/Tulmi21Qupom0JaknStICsDMcV1HYNJGauOySN1qEb1aodKxRg6wbIIAOFHBGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721019999; c=relaxed/simple;
	bh=SchhP1xTUPh058L1YFGenmEB6nsWYqHH6cP9FUmdSWI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IyuV7O5BjioKIgEDzSlpL2cqN9f6OX7TCu7WsuBbzbYc8OXlKyEZGoKg7fuqftR8mYiwgfizzVmsZUNb7qXZiGT1PSoyecWvKoLP5kLtOqS4pbxZWRQ2cOcFZ9OIDIfxsmFW8DjCInqM/iJ1JJVNuksfSHy4dlrvJA7Il4ab7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHF53Get; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so4465605a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721019996; x=1721624796; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhuaKhfzUtvm5TcoXmIFibN66R7nPMt9WjarjdoSjhI=;
        b=eHF53Getvh5Sxp7UOmi6m52VLfeVrTxu+UCBrrnW64AzN25EcyXQ0D0vlWhHGE6NC/
         TSeKHyu1tt+bLygCjSBKTnvZGW+oaNDuoPulCx+9bfs9ZKVGr64Ijuwn0zdDZ8mL64c/
         bJOp8Po6p5Vb5yi4Sya84m8jBO6bMKjCWkRx8UOgb2ofYQZ8bOpmTD3dQrT41dJxpO5W
         /kfVutclDT1cXHbo4gnNghTtCLgyeO2cK3UpF2EUetjiOEIrxSBxciSN5r4AtXoB1uUO
         TbM2qbKDu2k3b7fnnHMiU9BE3UAS58OXoitKGrzekPTlnE7CGHAhm6G4QfCHLsw1IDhV
         zcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721019996; x=1721624796;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhuaKhfzUtvm5TcoXmIFibN66R7nPMt9WjarjdoSjhI=;
        b=Y9v/OHAIPrVUDy9WfSR67eequn5MV8NSu7mpX/zLhYFXnZRod5wvV03GSuHCdFXWEt
         aEdMGNzBZhXiFhvpQNSxrj8doi5fmfOUFfGTGzps93DiqkBBCl5vDNe0f4BfCUNJcp/a
         f3/fcc6sbjAKfVFDNxGiAy123YXHBDaSwXNu3ZK94Tk34UuIfd+bFwU9Ry43u46AUN3N
         Ycg4C3FqVdOFfAYF/N3qu4xataohCa6REgpY14gzgWCxtpbnIN018Gq72tb5t29KbbCd
         fxvLenE5wyYhOosgqmbBAikdGNGJKx/cmmXWINN//Ex4vSPpINcW3o9Nrogd49O1UfWa
         CZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU485xDg92QYBJw9FhHmGDID9E4VKwhO92ZTxTwIFv1jkAOkb8s8ouOYcj5CDk62wI87KejhDAFqUSPo6KAXE/NOYybsuqyoyLPyDKc
X-Gm-Message-State: AOJu0YzGaRACYAyidgdhUihNMsEk1P1X3qiSAGAWPnu3VTGV6FG6evYN
	HY9XOEDAWgGQ74S+IN9ALbhO2iaPM3bAMzQkczZTnq6lX0Uh9qq6xgEa
X-Google-Smtp-Source: AGHT+IFqYZYpxzvfu+vMQ5vHE1SalrQW7r0KdNZkH1TLoiE9as9oI45SZvMO/60/sSkNw7mVVX8nWQ==
X-Received: by 2002:a17:906:48b:b0:a72:8fc7:ef7f with SMTP id a640c23a62f3a-a780b89a12fmr1112377166b.65.1721019996094;
        Sun, 14 Jul 2024 22:06:36 -0700 (PDT)
Received: from p183 ([46.53.249.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm180017266b.126.2024.07.14.22.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 22:06:35 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:06:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/asm: simplify some inline assembly with pointers to array
Message-ID: <072d5479-17e0-4224-b0e8-e2f710f8dfba@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Use pointer to array in memory operands instead of dummy variables
to save LOC.

The patterns are:

	"=m" (*(T(*)[N])ptr)
	"+m" (*(T(*)[N])ptr)
and
	"m" (*(const T(*)[N])ptr)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/special_insns.h |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -188,17 +188,15 @@ static inline void clflushopt(volatile void *__p)
 		       "+m" (*(volatile char __force *)__p));
 }
 
-static inline void clwb(volatile void *__p)
+static inline void clwb(volatile void *p)
 {
-	volatile struct { char x[64]; } *p = __p;
-
 	asm volatile(ALTERNATIVE_2(
 		".byte 0x3e; clflush (%[pax])",
 		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
 		X86_FEATURE_CLFLUSHOPT,
 		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
 		X86_FEATURE_CLWB)
-		: [p] "+m" (*p)
+		: [p] "+m" (*(volatile char(*)[64])p)
 		: [pax] "a" (p));
 }
 
@@ -226,13 +224,10 @@ static inline void serialize(void)
 /* The dst parameter must be 64-bytes aligned */
 static inline void movdir64b(void *dst, const void *src)
 {
-	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } *__dst = dst;
-
 	/*
 	 * MOVDIR64B %(rdx), rax.
 	 *
-	 * Both __src and __dst must be memory constraints in order to tell the
+	 * Both src and dst must be memory constraints in order to tell the
 	 * compiler that no other memory accesses should be reordered around
 	 * this one.
 	 *
@@ -241,8 +236,8 @@ static inline void movdir64b(void *dst, const void *src)
 	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.
 	 */
 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
-		     : "+m" (*__dst)
-		     :  "m" (*__src), "a" (__dst), "d" (__src));
+		     : "+m" (*(char(*)[64])dst)
+		     :  "m" (*(const char(*)[64])src), "a" (dst), "d" (src));
 }
 
 static inline void movdir64b_io(void __iomem *dst, const void *src)
@@ -271,8 +266,6 @@ static inline void movdir64b_io(void __iomem *dst, const void *src)
  */
 static inline int enqcmds(void __iomem *dst, const void *src)
 {
-	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } __iomem *__dst = dst;
 	bool zf;
 
 	/*
@@ -282,8 +275,8 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	 */
 	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
 		     CC_SET(z)
-		     : CC_OUT(z) (zf), "+m" (*__dst)
-		     : "m" (*__src), "a" (__dst), "d" (__src));
+		     : CC_OUT(z) (zf), "+m" (*(char __iomem(*)[64])dst)
+		     : "m" (*(const char(*)[64])src), "a" (dst), "d" (src));
 
 	/* Submission failure is indicated via EFLAGS.ZF=1 */
 	if (zf)

