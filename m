Return-Path: <linux-kernel+bounces-386740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5C9B4793
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3156283E40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A769205AC3;
	Tue, 29 Oct 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eddxTsiU"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D1205121
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199170; cv=none; b=PCQBFNmUK8xZejFI5PRIRMuyOWn+R4RmIenNWYb8r3FYE+HvRefoNs4lpZZrEA5s3jdlb3jn0hK0ScFcHuYpd0xOhvnWk3eoft2cRTEaccXjRngD03Yio16Qrr5gI02JT5cNc+9F5TGMvNqcd4SsEuvmJeXWYa4nPHsF1BgZhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199170; c=relaxed/simple;
	bh=EKV+QYYhMEK5XzmL1kz1mpSXJHzUUDAUOm6h5P/l9LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUmUVpVpboA0+ZpODp6saaHCzSARoXTeOU4SA8dVgu8OKO6bCTRJRsgcYj2Kn5pb1OLthtjXJ5oUNq1z9K1MYC6mm7FFrJ5WKGC/Fz3Iku6xgzbtXoipidYpZNdiEjiiCgTCWNgoxnUFNUE5QtU/gnaPKcpHuYbi+WtvRKqryE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eddxTsiU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f58c68c5so8764404e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199167; x=1730803967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ECqHBAN3rDV9yo1zqeLO+ji9lVIoh6IkMKI7b6YgP4=;
        b=eddxTsiUOj4eH+LO3P/SR1pOl7USzeXKIldvJ034SfQLizEtooagKNZMSRRHAwSsLp
         4z21RNUJ+DxzNwciC7+cL3FgMNTu2dXqgXDBRd8mop+P4c0ahOFHO33wUZoTC8FiH1x4
         eeUJ4Ta6mpT0jTS9LihGcKXfzEPFtEM4V1DFmLiDYdAEvywdkKV8ItQvQ7TqoGOpmXqg
         6pP3TRQxXsA34uRKrk1/fbKgODzdhz3uucMMpG1Q4G2RV2I3T0bDI7aRvIFVOrssdAjb
         bWPicRGxCecEweQpgBkClui+3sFQJlFMCb7uW4HoyBvFQzKalIO1p+z8Udwt+0DO73yD
         ee3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199167; x=1730803967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ECqHBAN3rDV9yo1zqeLO+ji9lVIoh6IkMKI7b6YgP4=;
        b=KUOr1isg7FKrjtEENrax1WFN8nVRPRQTdE/YQm4maZ9cniC2EXzx8yuS6MeBVUaMAj
         FWV3kHSvmQ6Jn3NigNJUR9OOOOOpI1FWbmTT3moxv1qQ+fKrqyU+OLwCLe0Nen5pFnG4
         r8jynmBK3FBFT1cnVGjICr4+SVf4E/qldx1WAqwuvQP7+IKaO/TgVn3rw5d5Mlp7KdyE
         pKhcLvocOqYHep/lTP2pFIdHgZ3JU7t3wi/PDb0sRURXsaTbJpgCe/jx3NhtBES989Jw
         0YJKEEY+fLSxlqD/GNzre25qFG3oeZprMJZ4Gzu+KHcAKDACGb++4DEuVoJ176dG6uP0
         rfBA==
X-Forwarded-Encrypted: i=1; AJvYcCXCXOEIXzXRfIYXrSXWmdf4/Wg3djiRf4FntqkpNvr4b6j38pdG9whVoja1+FfVD2lGrSbdp55+p4ZR3Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7sa7tS2fQUgCCbv3yEWdc9DfZqI8PACP1S/7PR6uPyXZlsPl
	BRhjVj7H3vPad2Cvf+Ftz+b2Nc5U8WP7BR8WmE0q6xUb602oamhrDZStiZMwN0A=
X-Google-Smtp-Source: AGHT+IFxU85skQ0lHgZfBxehiTWY20leong2ojbAy2znYbSLCYYbTDr3GHQiZv+4b0NSU1Ui/HoHTQ==
X-Received: by 2002:a05:6512:3d8d:b0:536:54ff:51c8 with SMTP id 2adb3069b0e04-53b348cc6e0mr8922755e87.17.1730199167001;
        Tue, 29 Oct 2024 03:52:47 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:46 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:41 +0100
Subject: [PATCH RFC v2 01/28] ARM: Prepare includes for generic entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-1-573519abef38@linaro.org>
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


