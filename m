Return-Path: <linux-kernel+bounces-575698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D179CA705F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3075D7A6CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BCE25A631;
	Tue, 25 Mar 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvM8Zca1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C443169
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918508; cv=none; b=BzPPBesJflO3NKL/Yifh0V9pOEEdavzkVAihSQE7N3vBx5gDt6Sfa2HJQ8JNBvIhTe6DRY7oWzv49gQQbiMtlfM6rUi1lfQJDNbwJXC3vhfoS//XmeBmEd2rOAfRNtt3BL9koypqKjyrmvHHFKXCjJAPoyOsIhNwXKdY5jdVrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918508; c=relaxed/simple;
	bh=O2dKRA9uvJbAtmJ8DU5c5NB3nWRxzGZSCc3fQ+OAJwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QN5oT48+xci2tsEwnuQ2H7sU1IYpddcDPR/OnAWI2z1YanW54C409GI6pIhQrp0lhPJbpSVWiD8KP0+oNdreKQaMZuhycEJK9y1QyUcgRee8kaWDfTgmis2ZdywEmQT0QhKvW3RAn7dD+einlmf2SHM3SVYbW8t34nO4/kbeAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvM8Zca1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso60635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742918503; x=1743523303; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNLrWaHC+F16KWC7Wcys7gq72QWKKTUqdbgRYbG35Hw=;
        b=FvM8Zca1YHsgXMcg2etmQqR+N6Yo8z0GMYgF3pru4QfLDpGjVPhXGD7yJKxJAjQLbL
         8xKvpVk2YPDKJvIesnZwOvFVVNi7IO33d+grHovsdy8envdPbzvjXfsH3r6JkbiWrWpf
         oWJj3iSVU3EiisP+hvckvEBEuqqoWJofHGAZYwNQX+HdhoB/l0wll9oR6BqJvek89bz5
         +Fyx8FH143ZoR4t0BhNle6VVW9jlhIXcgCnt5/fSJ0fS4dQxAE150EJ8UpgVBwakLGGF
         BZs10Qea5uiI7KcTdik82yHPtREVZp1qjts/BNc/wFJtpSO09dWj7tnOFwD74vslqKaO
         MPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918503; x=1743523303;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNLrWaHC+F16KWC7Wcys7gq72QWKKTUqdbgRYbG35Hw=;
        b=hpbW5X1WjVtZ1YlhsIHmMgrbOmNq+nGNHgtO3GSd37OZ3R4tv6Uy0nDXWTi1MFVDSH
         D0E37HuqWEUmno6HH/Qo21SeaOJ6WKU100dTSRC4W8dTULQ/VcguGvsiEr6fb42yIHHR
         boCbXrgR4YAmtZupOp/9gP1R4gNZLejfqTy5FyNyXEKVUuhSNT72P/AOvT96OM7u+MgG
         qRVCecoDUcogi4m2DirAn2OgANeCtoFf1woBtWrfP6JhpBtut9sZkpQMJD5nOxxHqc7j
         bLtqgUQvhMeE6TSThU6J95WZYxYBokTdPHL3VWkDGK+ktGHADdgR8igEOOHBLvft8+cq
         kYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxstLlIS6xxkEmPOc4+8j5k1DG1LtTGcnCkK57NOIY60Qd5Ml7zGuZVD80o/JnAJCtpVkKsKZL14o+O1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrdkdzD+xuGGTpgje7OAT3djDZn4JjwDjau/haBgnrOFXzMGs
	EcXItSEMxK/L18kSA4NbCjGNBzLuaqWvffL2GShZnpX9RJQBIimdSaV6PVH3ig==
X-Gm-Gg: ASbGncv8PIO12agCWoj+I3ldY4nz/7RyAmFGcVtvvmXrJzAlh9l5Neyuai+wnwLmeFZ
	RI7MCjFI2/TUOBuKIab+zNyGmfS/pnvDVU6CXDmxCZskFXL26hKoP/GH52NKmXcrxTwOi851H52
	yXM+PgJTY+Nc4ShMlnd2IdmyXO/agqzfVOKscUQANCE0vTK9CZhZtKOO52+XT3W1VK13W2+gjyW
	092WbsJ1lsa4vQ7lGyZqrIZYlBwYkkKXi09TionnxW0nbDA2qX8JC1QLMYI1tdxVROpWEv98MTq
	/8Gb4RPQOgnFqfcr3bKsaz/f/4b9CfILOA==
X-Google-Smtp-Source: AGHT+IHsIR3lfUVsohrP4cvxcT+BcBgE15Za3l/+RapEBvyBlFjLjq5LVDT20yOcw4Ik++ZPr0Tzpg==
X-Received: by 2002:a05:600c:1c8d:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-43d591c2295mr4838215e9.0.1742918502385;
        Tue, 25 Mar 2025 09:01:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:1e00:1328:5257:156e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdeb6esm204516205e9.31.2025.03.25.09.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:01:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 17:01:34 +0100
Subject: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
X-B4-Tracking: v=1; b=H4sIAF3T4mcC/x3MQQqAIBBA0avIrBtQw4VdJVrINNYQaChUIN09a
 fkW/zeoXIQrTKpB4Uuq5NRhBgW0h7QxytoNVlunR+vwoBoSljsnYiTvNVsykYKDnpyFozz/bl7
 e9wMgdafTXgAAAA==
X-Change-ID: 20250325-kcsan-rwonce-c990e2c1fca5
To: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742918498; l=2606;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=O2dKRA9uvJbAtmJ8DU5c5NB3nWRxzGZSCc3fQ+OAJwU=;
 b=pD/K1HEzZBcPmL7dDKYAHw7aJiLQxHybO/JPTsCHTVCbR2lbNDnEkZVIXWh7hZC82JiFHIbka
 JyE20sMYsBeCBqqi9VId3Q0s9Ahg7NAmY7BkecpwJtQZlp2u/OebQm6
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

read_word_at_a_time() is allowed to read out of bounds by straddling the
end of an allocation (and the caller is expected to then mask off
out-of-bounds data). This works as long as the caller guarantees that the
access won't hit a pagefault (either by ensuring that addr is aligned or by
explicitly checking where the next page boundary is).

Such out-of-bounds data could include things like KASAN redzones, adjacent
allocations that are concurrently written to, or simply an adjacent struct
field that is concurrently updated. KCSAN should ignore racy reads of OOB
data that is not actually used, just like KASAN, so (similar to the code
above) change read_word_at_a_time() to use __no_sanitize_or_inline instead
of __no_kasan_or_inline, and explicitly inform KCSAN that we're reading
the first byte.

We do have an instrument_read() helper that calls into both KASAN and
KCSAN, but I'm instead open-coding that here to avoid having to pull the
entire instrumented.h header into rwonce.h.

Also, since this read can be racy by design, we should technically do
READ_ONCE(), so add that.

Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
Signed-off-by: Jann Horn <jannh@google.com>
---
This is a low-priority fix. I've never actually hit this issue with
upstream KCSAN.
(I only noticed it because I... err... hooked up KASAN to the KCSAN
hooks. Long story.)

I'm not sure if this should go through Arnd's tree (because it's in
rwonce.h) or Marco's (because it's a KCSAN thing).
Going through Marco's tree (after getting an Ack from Arnd) might
work a little better for me, I may or may not have more KCSAN patches
in the future.
---
 include/asm-generic/rwonce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e982..e9f2b84d2338 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -79,11 +79,14 @@ unsigned long __read_once_word_nocheck(const void *addr)
 	(typeof(x))__read_once_word_nocheck(&(x));			\
 })
 
-static __no_kasan_or_inline
+static __no_sanitize_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
+	/* open-coded instrument_read(addr, 1) */
 	kasan_check_read(addr, 1);
-	return *(unsigned long *)addr;
+	kcsan_check_read(addr, 1);
+
+	return READ_ONCE(*(unsigned long *)addr);
 }
 
 #endif /* __ASSEMBLY__ */

---
base-commit: 2df0c02dab829dd89360d98a8a1abaa026ef5798
change-id: 20250325-kcsan-rwonce-c990e2c1fca5

-- 
Jann Horn <jannh@google.com>


