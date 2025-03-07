Return-Path: <linux-kernel+bounces-550515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D469A560A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F02170286
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14531990C3;
	Fri,  7 Mar 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOEDLqqm"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0B19D082
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327942; cv=none; b=oNhZG5lnivmeo0VClIsD6YLMazKWqpqk32VLC1nKoOsruOdZPQl3pazUUddmb3wUY2QtfXrotQR3TGiUZnBFG47KCuBTecZqPoVZpexPxoADKLZE0uizIvydV/u/DZL7g9HVpbYUNzbx0WgpVs7UmFVEjDu+0G7cW8XlWSs4P+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327942; c=relaxed/simple;
	bh=21FN1gXuK+D5MtVQmoy0xb2kZKBztcWwxpziMqD+a34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAMDB3VZmvebB1b9zrTB9KjkmaKTBca1n5wYbkoLJbnhnB2qzTygpUy8PZEdAPbFr94lNrqPA4plIdU9KslFKENJb+VipsgrjJtQTuFRf6K9VfgbFStn/NGMV+R+fkVDW8Dpzah1ndTnGZUoReqv4TgZKDJ5Tlk5GMUZOI6xI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOEDLqqm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf615d5f31so286607466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 22:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741327937; x=1741932737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPnD1FATZsx8WlegFpfQmw8cfWWhlMwVwyyTZqMP05g=;
        b=YOEDLqqmDbS5uveH+BRNVBksa64q3tFVS9HwbY/7C9sbVkb51zmWSPZ09f93FSJ5oO
         7Ex4thOyyP0TkOMA3fumNdLxJsLDOJvvPRQKtSR2pi8mRtmTtvyxs5suMX3EroiPpqj7
         VpSi/LeIOxJvBAJXh/XowXNf9Zb4fH4RgZyBtsbja11SG5a5EUx1EexNcv9MM1K6JN5I
         kZEzHRUPG067OZcufOD0fN0xxuKons9wglAX/6J03Gdm8yzdDoCTfG7jamebSSX3bMl1
         ySKYRUwf1pw24ejdQfIPMUXxiUPjuYabOmUB/uztoYM//LZP8r+WwBe3Kf9ZMK1JLwml
         k7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741327937; x=1741932737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPnD1FATZsx8WlegFpfQmw8cfWWhlMwVwyyTZqMP05g=;
        b=QKh5hyDzYC1BX8A5KzddOjVTLTTEJFU3PFM1xkq3BWWeD1pHkOVOnEco9zFd87SMzX
         aGWwKWj3zl7RXtROLh/R4IY5scuukLQNzWWvx+U1w15Q8X1r2OcpFCG15J2U/fGnJ1Zm
         lClQSzPkuipBFb6BdWfpwlIcCErO3NPFiojuwIvGRdUGvYXQwOLzzt6Bil30/kuo3MuI
         aL7vLaPmmHmdGASCjtGmDw1IpPPXUscy95/9aA3iUnpIAxjJBurKjPcx4sCfD8QiAWM1
         nfNSK/e2KFDs0rLtcVk9oJKLTLPdzr7cod2Frzfzl2vSZ/rRoyy6n0nnbi45fp52FpUt
         tXrA==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZENIH4hKZeBStt5yn/74R2aHS921F2CjTsKoWeikqWq+2gjvP7TIuMHiR1CP8sUjHr5orpCMgcCDRKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1KFgaR06KyxL2EmvmySERpjO9syzEr7RO0hA/vdUjjAltjzc
	1vrBXCLbyj/TtYK+s6Br0syRBXwShOxfM8c/LByk2yXYPetCC3M=
X-Gm-Gg: ASbGncvTVRgQpXXGkqwyvqFT7bI+b/K+xmMsTJNV7qXxJ7t3ma2HG5QN8KqoIOHjptu
	6yiCCSPGJwWV4ZiUYDpwHztmsYLrwntY/0GriYUBy89Vd1QRjjQlFcOVsR1TVuGmlcHZ/E4Gkfy
	EwUBahw0LpLu5kmER8V3AmKlYhd7bGBEiP03rBv7dGWUZmFcC/fCJg51xjCrygSQs9qN22X08fS
	rWmJlul5dJYVeZUKezPvjpKkgzyvlzk6s0TYSQdHuWeldDJv97zF7fvlZFUABKair+/e5JJTklG
	bWo37H+ymln8OShysjShO8r9hY6HpAg57fDNDVv1Ns0/ARmNI2KvsM8w
X-Google-Smtp-Source: AGHT+IGOMV7dyJSEdazXcqw1Tl31DRfq4dBnQX9QirrNU704ktKyaaz5tbmWAYeghUw8TclLk7qXzw==
X-Received: by 2002:a17:907:3604:b0:ac1:dc0f:e03e with SMTP id a640c23a62f3a-ac252628a87mr222276766b.13.1741327936887;
        Thu, 06 Mar 2025 22:12:16 -0800 (PST)
Received: from localhost.localdomain ([178.172.147.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdd8sm216824166b.138.2025.03.06.22.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:12:16 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 3/4] x86/asm: delete dummy variables in movdir64b()
Date: Fri,  7 Mar 2025 09:12:02 +0300
Message-ID: <20250307061203.3281-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250307061203.3281-1-adobriyan@gmail.com>
References: <20250307061203.3281-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cast to pointer-to-array instead.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/include/asm/special_insns.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index d349aa0f0a83..b24c6c945c38 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -215,13 +215,10 @@ static __always_inline void serialize(void)
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
@@ -230,8 +227,8 @@ static inline void movdir64b(void *dst, const void *src)
 	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.
 	 */
 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
-		     : "+m" (*__dst)
-		     :  "m" (*__src), "a" (__dst), "d" (__src));
+		     : "+m" (*(char(*)[64])dst)
+		     :  "m" (*(const char(*)[64])src), "a" (dst), "d" (src));
 }
 
 static inline void movdir64b_io(void __iomem *dst, const void *src)
-- 
2.45.3


