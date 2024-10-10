Return-Path: <linux-kernel+bounces-358878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AAA998506
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68651C21243
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F34A1C3309;
	Thu, 10 Oct 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+RM+Zcy"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006521BE874
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560027; cv=none; b=eDQyintHSK3cJ2gOc6C95ZVrOpGgieawFIKmjIwESbNeQdoPKrV6xXbr5tPu4+5Di26pu5vRx/6gV053YZxrB+PBXBiz79Sf3CWok1iKPePl9LBNeuVmJUmRCpV+CHKqsKXEYKZK6qEqRUIuhxxjRurVBeEH8GQ/abZSf/xKhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560027; c=relaxed/simple;
	bh=EKV+QYYhMEK5XzmL1kz1mpSXJHzUUDAUOm6h5P/l9LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+5XUVPh+i7kcf7dxDeAJP0PIFw85B+p1pcIL4+p35hcQgM1sKF3vclEO6+AeHxbO6Syr3RglH1NLsg5UpUOQWxW9yIwbUZE3bYAgQJrTKJJMgVw/LFoH/I5BCV5TJzZ3c4co8Sv6CI7VbHWhXlAp1/2EGHeDwbEPht6pTXqcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+RM+Zcy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53997328633so1191989e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560024; x=1729164824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ECqHBAN3rDV9yo1zqeLO+ji9lVIoh6IkMKI7b6YgP4=;
        b=k+RM+ZcyZ9/TOy9ZGFZwWldRneAsKAbIJNkfj9uiTpeA4K02LPFee1Msr2Y82uod6J
         uFZTnAbYC+SBgR7UKEwV3xVBFZTRYPDWfz0g02y21Eun0WV4JvgxWrC7e9k9AIhaUtvA
         AaycTz2svptOYMSPlXPCHZWkgsb1eEM39iLK8ch+ocsAst/zy1/QbDEOLibClSN2xjwx
         lCeA5ZqlfV8z67LvNgolKrYoUvDqjPO27F/mE+aXm9ZzCVEQSBtvsbwmL3S3qaFo4cGO
         DA7hdVNFNiQC2vW/kQq9AeHpeOZxpL7LAOmXQkiZeqvkZa147TP73qlizpYlWgEjOb49
         34rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560024; x=1729164824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ECqHBAN3rDV9yo1zqeLO+ji9lVIoh6IkMKI7b6YgP4=;
        b=do21xVEvFI1+UcO3s2BNQ2SbekwlgRi78P514oXGGwa78BGLLSpUhAnrkTYwcMw3RA
         c3VovxiZkl/TJDOZjISmlRUfPfcepnTxT9nr5ZlOnJvB1uKFPq8yC5P8CHNPtI274qra
         HU4ciaGV9GdTqOVeberKM5E3Ach/YH3TxkA62g2SunRu7Ophc75GDDPuefx+/kIw8C6k
         mGycXaTllQDToTiHX6AYz6JX6milxZL9SHoWUWEto5IfFu92mbhFw+Zg1Y5pt8DoL5Lh
         6phdATqm+3MmPUK16JjWfxixO8nZp3H6jF2RYf++GQkE7XC/yhe5XKQ+37WkRE1Id+ux
         XNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZF1FpGCzM5pl38T/fFlnsstmbSUOnk4naFVUcFlYRBwxM6A0d+nhqAdcaneBiMGwuOOPKZTT1ZyinKYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlgku9vVsvkzz92r5I9FdTnYBenQry+WBZxMEvMEDYEEfHoMHV
	xufI8EeG+ooo0upICV9Bx9Cr/6wwjCZsG4mcwTJXECcNY2snbCk1hDfeLvobT3M=
X-Google-Smtp-Source: AGHT+IEzOwjSeRaNRAgIP2djHbcgDjxIdas3zeUxGw2eRXDLl+1CJu9P76G7kqLMU7BvW+xxCPu7BQ==
X-Received: by 2002:a05:6512:31ca:b0:52c:e17c:cd7b with SMTP id 2adb3069b0e04-539c489fecdmr5606542e87.22.1728560023941;
        Thu, 10 Oct 2024 04:33:43 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:33:42 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:39 +0200
Subject: [PATCH RFC 01/28] ARM: Prepare includes for generic entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-1-b94f451d087b@linaro.org>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
In-Reply-To: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The generic entry code needs a static inline function for
regs_irq_disabled() so add this, in further requires the signature
of on_thread_stack() to be __always_inline so add this as
well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/ptrace.h     | 5 +++++
 arch/arm/include/asm/stacktrace.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 6eb311fb2da0..a01c66f0ad90 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -52,6 +52,11 @@ struct svc_pt_regs {
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->ARM_cpsr & PSR_F_BIT))
 
+static inline int regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !interrupts_enabled(regs);
+}
+
 /* Are the current registers suitable for user mode?
  * (used to maintain security in signal handlers)
  */
diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index f80a85b091d6..815b5f256af1 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -26,7 +26,7 @@ struct stackframe {
 #endif
 };
 
-static inline bool on_thread_stack(void)
+static __always_inline bool on_thread_stack(void)
 {
 	unsigned long delta = current_stack_pointer ^ (unsigned long)current->stack;
 

-- 
2.46.2


