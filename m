Return-Path: <linux-kernel+bounces-203049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA338FD597
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66454B2284A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3ED13A3E2;
	Wed,  5 Jun 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGsi/nBM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214B2E401
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611284; cv=none; b=aPoy5yGLBAVoDE/pX/y7eI19oz+e/ZF99REnZ0TNVexAAxj2HJuIXgZgWmNdTQejzLCqauKZojlx4liSQNNpZ3AJ+7OQF8ee6Gjd6jkgDd9at0mU2C0/Phhnysf6FMh1QCeQJQsZNdDPH4a77kQdyDXXEzBqvHy8ZIfc6ddfH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611284; c=relaxed/simple;
	bh=lD/VvV5cQNmX9lBlY4Rg/253A8Uo2p6wQBL/wkK5+Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tS11FM4weOFRKNNmsNlf4a4zNCLWgil3ax9I5uo5ThqRNUs2t0F+GeLksxACHZiTvryP5gT1HRuPKxLpu/WASbuibPRXYv54g72l2njJK4R/csPa9y8HVo63EiXMLP1R0okkrFgTcPWRxDUSSxIbFSSDambDpLuqGX1z8eBR0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGsi/nBM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a690c8e64bdso6240266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717611281; x=1718216081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TeellwoKZ0zlrV7V+ziWlsye10PSNVrXFNVzLtw7K9I=;
        b=OGsi/nBMjKrWvfF++9e4FK0fs0GpLfsB8Sa+AhxBCGPciSaGLKAHHbef2aVEnsJJtE
         I4aATLbOG9T1x7V8+79msUPiY/hXQE8XTEcUKNls5VCXTyjgeNDUv7ZqZb01fcPQB1n7
         qtlkHqvzD7hYvidPHkNQMImGMcVqqppliDviYF+TLiQ2gt5rleAEfU0BlAiQI1dpEQZ8
         4mI1bVHvzaUwLw6YMiC/q1OjLR6ugpXWwlBpwOfB7D/06F8Ejgf4YpPnqk3zY0B9yZEk
         ENMLSOCUaA4yZmx/kiX/6AdgkZCN9Cy6VtlAcrq7pm4lLDggglkDCeQ81ek97otBG0HW
         pJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611281; x=1718216081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeellwoKZ0zlrV7V+ziWlsye10PSNVrXFNVzLtw7K9I=;
        b=wfNuJzRW4lMEWKoKH7KFt5wR45wBKw8aIb+A4TlFre2AeQMEQvYohOWDGMxQ9guCxY
         jlRcqo50D6po6S8vK4FZp+dH1V//VgpFIDsjd25cpbp7aBbhruNwvossXmszb4Nw/mV3
         S7Ajk0dOKpy842iGUMbi6aJ8fZQFCRBzjlPexMIcy4DGEBNr+Sx0s7t71oAbnBMmsN3N
         BlKPwHZ2Npo2OVo0BN9tK8trNA65az/xqk7/Nn1LlmdJWRTeGyMrKCR4UiLGCpZlSCTT
         izlMYUKTw1E65mTOWJ/AYr5PlMN36a0RGFjJZ7AoN+hG+Uc/IJQivVCNCNRt1Y7M4bbk
         8G4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU507pPQLXueWHWbwCQpm6GF6TO/QXnz0GT4hmIf2ktOY+w3gH/vgm0F/sm4qijz8eLqR+qTC5nS3S0OGfRcZ9O3qYx5MNJydr9GdcG
X-Gm-Message-State: AOJu0Yw//1ty7Eg34XB00SSyT0XoQ4vYLIJgaFFIPkMv91nwySJpWzE9
	MbWfvw2mt5p4lKqXmjglzS7Ded0dpMynmaKaCuNtXvZC/kUoF13y
X-Google-Smtp-Source: AGHT+IFshboOpbXSNKsVJUe8rLz1NDL9dBjXIKe5/vK1GfJE3zESFgUK/J18gpObGjsT92BMONcIBw==
X-Received: by 2002:a50:bb2c:0:b0:57a:4c22:b3 with SMTP id 4fb4d7f45d1cf-57a8b69751fmr2430327a12.1.1717611281358;
        Wed, 05 Jun 2024 11:14:41 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5b1f9855sm6976233a12.70.2024.06.05.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 11:14:41 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND -tip 1/2] locking/atomic/x86: Introduce read64_nonatomic macro to x86_32 with cx8
Date: Wed,  5 Jun 2024 20:13:15 +0200
Message-ID: <20240605181424.3228-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in:

  commit e73c4e34a0e9 ("locking/atomic/x86: Introduce arch_atomic64_read_nonatomic() to x86_32")

the value preload before the cmpxchg loop does not need to be atomic.
Introduce read64_nonatomic macro to load the value from atomic_t
location in a faster non-atomic way and use it in atomic64_cx8_32.S.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/lib/atomic64_cx8_32.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index 90afb488b396..b2eff07d65e4 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -16,6 +16,11 @@
 	cmpxchg8b (\reg)
 .endm
 
+.macro read64_nonatomic reg
+	movl (\reg), %eax
+	movl 4(\reg), %edx
+.endm
+
 SYM_FUNC_START(atomic64_read_cx8)
 	read64 %ecx
 	RET
@@ -51,7 +56,7 @@ SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	movl %edx, %edi
 	movl %ecx, %ebp
 
-	read64 %ecx
+	read64_nonatomic %ecx
 1:
 	movl %eax, %ebx
 	movl %edx, %ecx
@@ -79,7 +84,7 @@ addsub_return sub sub sbb
 SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	pushl %ebx
 
-	read64 %esi
+	read64_nonatomic %esi
 1:
 	movl %eax, %ebx
 	movl %edx, %ecx
-- 
2.42.0


