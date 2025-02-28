Return-Path: <linux-kernel+bounces-538082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A910A49464
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11033A5491
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B924C689;
	Fri, 28 Feb 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="y1pFzAlw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E49276D3B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733584; cv=none; b=QRetXpNGpv0CCjG3Qmu1VE0RvzHldW4MgoXWXIDo6HFvl7cdLxjgE+rx93vF5RmOTzJKEmaiuU4PGCWMiYOmrnkrblYHKqDWrjOvNQvx8QnNDyzyyRf1OPYjltsi07vlZu9ATlmzNo7OtcnpoYb52iSo9Yf15VyF3qSi64BPDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733584; c=relaxed/simple;
	bh=kG618q+dGaz6KfSqiJfLKzo0LDr3h7Gt85xhdeTEshE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YqYG4Gx7Jb53vHFipAZaWY0TClGx3D5rnR1dygkRKAaK084rFBJIlfe6CllSBp9jt4rPSydN2WCcHZZLrqZv+4jp+sKhfLYdvNSI4aX6tgQQpp/1fqwgWTiFoZW7bGwFoC5N5JEnMPaCHz5dDOklo3IpDYXYGZEfNY/PftEFCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=y1pFzAlw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so18411675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740733580; x=1741338380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1iDXG4nsyxQE1e1A4QX9w6M1w8CTfF9s/nCaqEJCzgc=;
        b=y1pFzAlwC4JS7YCFKl+7HI0ND4Zv/hoc8TFLiuap38/rOBMiKCFofn1QRJeyUgLVdK
         ycWLYO80a0XAlVcsORMbapN7aGsfrBP7EF7zRdjW2z5r/o5odxpA8dWKODbds4BIvaJL
         QDcPnq4bUrirZAO2zv+6m20EkK7G3qZnQuk9sSz/JIcfP8pQx3wiDEadHDOUtk3dqfUO
         Z05eQvvGqIcyHvnqyaBGKqmpPfivvKApuVYtlV6Ew1U2K55hBdH/Hvl00I8AINpWDG3S
         EnLaU+88gOpnJdcJHQIMsQFVLi+c+TyFkTmbB2LPiNhMZVEbnpAeSxJoeEwh9pJyBB3c
         ep7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733580; x=1741338380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iDXG4nsyxQE1e1A4QX9w6M1w8CTfF9s/nCaqEJCzgc=;
        b=Xhk22vbnoK6PXy13UpcFbdXHQZ8MrrXoIErwgo1YE3VoNbVGhBMyYlI602KHTr3M8j
         HHKePUyOlJ6J4MA8Murp0qioHch0m3EWOmPkaIVL4mRXPra3DrvoEITMZD7eesJ7v6qH
         Pphd+lh3Qq7iIGCv+Ga+6nm8y4kDf4Y2L9OHQmKE92EwCgVr3uD0A1v/6AI7i/Pw0tUh
         6IwjSS0qVsHnbPbnWOZ4SAHASSXgjrkW2u4ET1JiaFm7ZlNxcBmX4uEgBD8z6Ahap/9X
         N+T0uM4RTC3KZnanjYiVQBEAQq/wbqHgEMbz2Q94fZuxUfmZrAp4ZRuOgFGJSy4NaDQ6
         HxNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJy3hIVec7BcUzEBxLIM/zEdXq1a9SIP5xGfmYvUFi1pSO9BE8Xo4JwmXTdofvdlsFEuTopN2OY/SjhWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJokg5RL/376pOdtd/20id0EAiOMDsON2QsVKk8Z9DMYd+vFy
	zsVThfadR5gSrqkD+TCjR65/avexoBjCgQpE/Uhiz+ovq5926zFGvWT/KLX/A/A=
X-Gm-Gg: ASbGnctetWEB+bY+fycKJd/gMwQzENmrXJnuCPAhPs0+QuLoD3UvREsAbhY2/oquRuV
	gtRq2tvITK38aveQDWtH4/7bokExUb13xZ/DTDceou3LSA1VdX+URsNPDI7wlA4Fg7AJG8csaqv
	ib2LmoLqFGgKztceWaheb2UnAflcZSKb/BLPi8HUKXC/Oe/IhUFk/HlnHXc5653fRnEGHlRugVu
	QnXgH9aWHFhYV2JZmlCLFIAYGT7OG+bQxIoy5B6J7Mi3Gmj20GhKAqcyx2jMhOPB9fx7t1MZIy/
	RETMTj4iSKSHOAVeE/71KN9SYwVzG8f6N9zGwdGfOywHnw==
X-Google-Smtp-Source: AGHT+IEMyVQFzZb3up6eSvKW7pURHbIkKoR0/iLhuxHiXvoVMxQ/kbxc0c0VX2sAkkKcTz4V2QSBEA==
X-Received: by 2002:a5d:598d:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-390ec155371mr1736556f8f.16.1740733580191;
        Fri, 28 Feb 2025 01:06:20 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3382:ef90:4aeb:d63d:2b85:ec0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm4683786f8f.60.2025.02.28.01.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:06:19 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Fix missing __free_pages() in check_vector_unaligned_access()
Date: Fri, 28 Feb 2025 10:06:13 +0100
Message-Id: <20250228090613.345309-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The locally allocated pages are never freed up, so add the corresponding
__free_pages().

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index d9d4ca1fadc7..a42115fbdeb8 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -340,7 +340,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
 		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned vector access speed\n",
 			cpu);
 
-		return;
+		goto free;
 	}
 
 	if (word_cycles < byte_cycles)
@@ -354,6 +354,9 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
 		(speed ==  RISCV_HWPROBE_MISALIGNED_VECTOR_FAST) ? "fast" : "slow");
 
 	per_cpu(vector_misaligned_access, cpu) = speed;
+
+free:
+	__free_pages(page, MISALIGNED_BUFFER_ORDER);
 }
 
 /* Measure unaligned access speed on all CPUs present at boot in parallel. */
-- 
2.39.2


