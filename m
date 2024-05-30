Return-Path: <linux-kernel+bounces-194798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E85DA8D4240
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06661F22838
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56728C2E9;
	Thu, 30 May 2024 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DJe4Rq7+"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3654C66
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028259; cv=none; b=IODPyaTpXFkRFeF1GLY4Xa5y7dIF4Z206LcPGIVaIDJSyEgOOmsXjDVcHEXBDnf87gX0X6p1v2Hl3iiasH4ehnGOIRD1T+AJRUXObL8E/qr+PWgsk2k073cMSnBbWAWr8KhVPlI+fKBsWEXwwxKWCscqm3BcwKwZJ+q3Kwxujyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028259; c=relaxed/simple;
	bh=yY/gxEyGxhRFbtdU3MNkfHK5yFxHXxkQvyGAhpiHdzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMwCxN8UAEx0kZJAn3tOhLnmOF6FSFoxXWgCnVmRr93wc2yK/JozO5FgMVNBPxzCahJGUJen90frF7FsX0nkn12aOb5p+Qov7ODrJ5/2bbjyRwz46v6h1OEtL02rJMnMmZQpDx9/LEr3MEkulsfYP9E0Abc1W9M+9FSdAU8JmWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DJe4Rq7+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c19e6dc3dcso267100a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717028257; x=1717633057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ03pSwu03IPlBKbH+1bfFOAbPC/t45t8cr4rrzecao=;
        b=DJe4Rq7+hwc9hzaYfMS23pYFxhadXaNFB9kLzPwww6CA/3FBbWdlX7Ss7kclN+13rD
         H/5b1Bld6MrNOa2VRxoNY8S4CozsNAJSdzLIXJk5BZ4NpecCPXJm4lj6XuXIlwyisuIk
         7TQ7HK3u6uTPWccQ0DyHYNsGwXqi19kwLzxjxMkF5QZ2TKjIygGKWWacSVP7LA0DNj0V
         MGMQDBGmuse5IAmBe3jH8P2tP3NZsoM9srPIkQC7JWUnCiBRna+P9MATkuMa0XljuGKJ
         bRCqhDpP7NJg16+MvacbKtpVstMAUV7J1RZWxwHrXXMo3qvexNaGMbYbGKVlgVMuXuOr
         gCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717028257; x=1717633057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ03pSwu03IPlBKbH+1bfFOAbPC/t45t8cr4rrzecao=;
        b=OAeY4MpBnknrJPAxGmBKnB1BJ9u2wMUxLpTZCn/8zbcNK4jYk+QtPOcaDeGzG4WN7b
         G/pmM8sHpFXmoTJjCHk8MBRV3AmW9eokBjWsDsei1gaciWfsHCz7+e00zH9fmohs004c
         ZmoFYMYaA9DssXpmbj4apNWEqhuBy4dX4LNQwnpTNIYyg9hDPi0g5yh2EIIhjil3Iczn
         C/OXpF7DVqX1BK8pqYcqBNbNtgc6Hjb1aclCsFS0cdbTu86k5NUo6XQIzhdbucaNnKHa
         6tFovR7/y88p4qNe4LK0thwToSgPBLNEftW3V1Ny5vurzbsb8WBNSnPzZwBHO8WZigNQ
         65GQ==
X-Gm-Message-State: AOJu0YzCz4YQ5gee3QrbLGCh8l4Y/eaRmNDMunFmf+yxQZ4LMHvnf7AK
	U6tMLfeP2eqdZz5V/JSxxClIRRfjfXpsI2JRECC+9xnMs1M2RZmCGv77bU2FfVSPvQPheh4WQgO
	v
X-Google-Smtp-Source: AGHT+IFV4do0wB/tiDJFQA9Xx1T77rhYSpTqSbv/IzD31/94h2G5nVcdYUOmAGTE5Nch160EFNVFmA==
X-Received: by 2002:a17:90b:3905:b0:2bd:f968:da46 with SMTP id 98e67ed59e1d1-2c1abb02cf4mr633039a91.27.1717028257563;
        Wed, 29 May 2024 17:17:37 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776e206sm432171a91.20.2024.05.29.17.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:17:37 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/4] riscv: entry: Balance vector context nesting
Date: Wed, 29 May 2024 17:15:57 -0700
Message-ID: <20240530001733.1407654-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240530001733.1407654-1-samuel.holland@sifive.com>
References: <20240530001733.1407654-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vector context management is the last thing done before jumping to C
code, so it should be the first thing done after returning from C code.
This also improves efficiency: riscv_v_context_nesting_end() clobbers
the saved value of the status CSR, so currently ret_from_exception()
must reload it. This is not necessary if riscv_v_context_nesting_end()
is called first.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/entry.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 4c5b22cb7381..d13d1aad7649 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -120,6 +120,11 @@ ASM_NOKPROBE(handle_exception)
  *  - ret_from_fork
  */
 SYM_CODE_START_NOALIGN(ret_from_exception)
+#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
+	move a0, sp
+	call riscv_v_context_nesting_end
+#endif
+
 	REG_L s0, PT_STATUS(sp)
 #ifdef CONFIG_RISCV_M_MODE
 	/* the MPP value is too large to be used as an immediate arg for addi */
@@ -143,10 +148,6 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 */
 	csrw CSR_SCRATCH, tp
 1:
-#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
-	move a0, sp
-	call riscv_v_context_nesting_end
-#endif
 	REG_L a0, PT_STATUS(sp)
 	/*
 	 * The current load reservation is effectively part of the processor's
-- 
2.44.1


