Return-Path: <linux-kernel+bounces-386743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F559B4796
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5322845D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6220697E;
	Tue, 29 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQXCaBKa"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB48206510
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199175; cv=none; b=HsTsbY0zaanjRDwSxgPMPXE9tvbbo0tFXCi81HJACONesgCfGj94rt0B1vIk1BnI2IPId1qjv32hO4ilQ4wARiwzUjFGj45yKx6vlrRVphfXLlZoXc452MVapZuSpcEdo5ZzOWriYB1gVs3iXpIu++nPKSf1S6J51ZrLcAhoHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199175; c=relaxed/simple;
	bh=F4l5jY4Wqe+bOqNg1KeOS2Pb/rQnbpWuqlfxyr64WII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ArDQnzb8WJ7X0vrlGNQSUfvghf6cFCDrrijSkLPCE6wpf7bFZSMWcL8yUSH7FlvR1Pv4hXD5JXCmXvAwOb/6J8aGoy/az7xD97FTnKOlr46su0Tnl/4NpqgdhRDZJvOmmBXwj+B1Cavt/2EnI5EYxRjLMi5FBzpO4oNW47d/rno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQXCaBKa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f2b95775so6131622e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199171; x=1730803971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxEtYMLSB1QX4C5qcE83rstSx0FEcAVbxyG1Gu9/c1s=;
        b=JQXCaBKapyVwqlbD1L9JJfg+rmYE5mHX6oDnrRoET2Amnp+DDRQJoEKc+LQk69rE6Z
         U7+SRwybO0bn4q/i8f9ewHDCWKM8vdVnO5aqf3DgetvwIlPAYq7H+joL6dpBVCGKhQM1
         hJz6XiBE7dS4/6iS7oyrFfSejXsDbjgk6ECeS1+/KCJeW8OlZyQL3GyXPNwu/gs5UgeP
         EXV0MYkWI5rSj8SdMquv6xF3iU1jEpgm7Ksh/SjjwY0n5tR+4I68ScNYRcG1SXStjibk
         4ubeyEI3kXLIMH48PSR9kd931Voey0/uZcnPHdlBLrm55i/HThQjKCaBmiUFFINRDjbo
         nSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199171; x=1730803971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxEtYMLSB1QX4C5qcE83rstSx0FEcAVbxyG1Gu9/c1s=;
        b=Qa5MLeSCVdlSyMesnw0+NpLxHyh10I+Lyz7iWevFVouLT96BfGolRAWXmvWUikvsCN
         m4ksjPaQQ/y89lEu+Y+8LTdW8fAWV+rUr9nYpEtFd+UtsqgOqk7vhy1M0pT7MUO2ymnY
         g8zsQUTMtypFjIXsUzMFL6gI01MV/zyv/wOxMtucfmea57EEiVgeNdQbfkmI3jwwRhry
         /dmHvXidtgoavUmhU7QTYaJ8ohPVsAyVlOdKxeaYxldO4vDJwANZpJOTSA6Y2kDtx0x6
         9r3cRKh0d8Frr6LRZMB3D0jhxM1BNVr3kEz0bA3aJIT1aNjad877/T2BPSFD+iXPDXSJ
         tzbg==
X-Forwarded-Encrypted: i=1; AJvYcCUtJBTyoTpOBpw6okphAkj9M5pPsW5f74pQGhyt/FPt94PjMt0+hZuYHQHO1ODmCcMtxXttveGRSlsZ3tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cYSH4e6Zql3EUh9tK217hJXjuMWl0X63KRbjH6yP4g+EAmcc
	tQCrZD5WXKB1dBCNOQ+PiFrs545dQ7CxCPOl4TE52MYdz4fyxki4wInETrHcTNo=
X-Google-Smtp-Source: AGHT+IG8wqLvl/74zfQu1AsovVWvKhyDOxgS68ymugVtQXnP4D9gfxPQaaqzIINEiXO/D6a/IaB5TQ==
X-Received: by 2002:a05:6512:31d3:b0:539:8fbd:5218 with SMTP id 2adb3069b0e04-53b34a3515fmr9748104e87.56.1730199171163;
        Tue, 29 Oct 2024 03:52:51 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:43 +0100
Subject: [PATCH RFC v2 03/28] ARM: entry: Skip ret_slow_syscall label
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-3-573519abef38@linaro.org>
References: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
In-Reply-To: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

Don't introduce this extra label anymore now that we have
a clearly defined entry point for ret_to_user.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f379c852dcb7..2f93c2f6d5b8 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -102,7 +102,6 @@ ENDPROC(ret_fast_syscall)
  * do_work_pending() will update this state if necessary.
  */
 ENTRY(ret_to_user)
-ret_slow_syscall:
 #if IS_ENABLED(CONFIG_DEBUG_RSEQ)
 	/* do_rseq_syscall needs interrupts enabled. */
 	enable_irq_notrace			@ enable interrupts
@@ -136,7 +135,7 @@ ENTRY(ret_from_fork)
 	badrne	lr, 1f
 	retne	r5
 1:	get_thread_info tsk
-	b	ret_slow_syscall
+	b	ret_to_user
 ENDPROC(ret_from_fork)
 
 /*=============================================================================
@@ -310,13 +309,13 @@ __sys_trace_return_nosave:
 	enable_irq_notrace
 	mov	r0, sp
 	bl	syscall_trace_exit
-	b	ret_slow_syscall
+	b	ret_to_user
 
 __sys_trace_return:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
 	mov	r0, sp
 	bl	syscall_trace_exit
-	b	ret_slow_syscall
+	b	ret_to_user
 
 	.macro	syscall_table_start, sym
 	.equ	__sys_nr, 0

-- 
2.46.2


