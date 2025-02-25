Return-Path: <linux-kernel+bounces-530942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93189A43A61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1443A2789
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6C262D2D;
	Tue, 25 Feb 2025 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzC1qgKO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982824EF9D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477304; cv=none; b=It0OQ85NaglK5TmqeQPhetRDSov9/wTPjm2EnFGCBrGyzhiI7NUKWqtYse4+kk9V9xcHrkbgLtxA9RoGM+FClqJ6EHcF+ERN7bzwxJng8NuWaBpMDFv1TtkCwUsKiuM8Qvk+OOgo/iMsGsBgdP/7dDF3Yylipx3U4iAr1tZs5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477304; c=relaxed/simple;
	bh=14U0ZFqNhjjw9E+TCTCsgolcWhF3eoCcGTNYVrgmoTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8rcZaG9kDrnKxdMjo1+d/IIAp/sfg+/5+MR5RHuBFNF9TqkXwqxgUJR9QWnolqQ6v6iXDVR4JKYvgCuaTWWPOz6A2f0dfCBr0LT53/sFjmuMahuIfZiA8VhD7LhzBZ1+yI4zCbe1IBePGuwjzgke3g6TyfeiiMUG/EoPn1u+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzC1qgKO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548430564d9so3039757e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477301; x=1741082101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IJUdaO+5dTLVXPMwfcKz8isZKL74F9HfpoDdIYxpPA=;
        b=tzC1qgKOGohHuvhmjBewcDJA0HG5Q4SZpieQgzQROV3x+bIuRxG8AYj6kZys/hR11l
         YAT2uhKITDJUsLC58LhA94kPwJ3hXTMwC8il6OPOy5XUhyJbeP6MXeGUheH72jRyUZIe
         iyPR/pEbw6nox1J4SQRK6uNt8WXTD5JGQmYNCKZq7O2/JnfBH4tb1ecYAjQrmdd/qYZI
         DTBRRVXKw+O6jifYG/1u2G1Ny1tMVPvk61cN3mhU6xEFLD0VtWXKCGgl2E78WrAavjxX
         HeHVAYk1Iid7GZfBkHNbz3oF9eUuRAJORGpGAiKAn9IQzhCoCIy+ZUAD1alCcVzcsdQO
         zRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477301; x=1741082101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IJUdaO+5dTLVXPMwfcKz8isZKL74F9HfpoDdIYxpPA=;
        b=hS3nkJc8ebnnBT2qi9K1NQNaqbh93IGb4wRqgzDJ8tROQJrYkFWEPmm/IC4WlAsSka
         BhiLa86QSlEhXAjkCIOCGw2cupQJSAlsfMZsNYD/D6vsR71peU0EATzuaH2ixdBnKhKp
         8oQhvuPdaxe3gpNTefGlN32IpjjrmRwKQJk0ue7lE2A5YrAkAZlxjn/tPkUzwlh72wqv
         Oyq8okfGRRRMscx+7ZSgP/MlgfpRH76oQkE/vj9aqF7AhYPtgsyXeIfnM+VT9wBeZXcB
         afpMUxNO3Lau2wcvR7y2vMiAoshs90waECCJR/JwZ0Jgo596t2NNKkjagDrG7kU7lgMT
         Y2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6QoHGmHLbJi2Pnxwl91AlzcfGcJ74i2CxkOD2I9EgRH208wLsDXK3otYD3EVdCdqmmolGqNzIUkjr49g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcaLWYA57aDhQu3aHErDXN01LBw5Y7JBuknLyfeweZnuEPNTY
	Q9dneNZ3BaXuD/1MAIAaP3dg6QUN2GWlGxTtXdxLDwelG621dYJn5vpfNHSk/Jg=
X-Gm-Gg: ASbGncvwIj01Om1HGeYG7xy64V8rFx0aoyPZwJyzGYovffm/URLj0SzgVDZZC59NWSN
	NtYFxLUmeduHg4xU9QxrZ0fEMpjwsosMPAWOegEn7+YUiTUepDNXsz17zbuv7hwdZGeMH907ep3
	oM9aP2XAx31tfZ5ngpLlfpV4de45Ng8AcMXpnMoPArLU961pMbNX+GYEPuyIRv+qFi0pFRkhICf
	Ds8JOoP/1gUsqnOF+7HZav22Y3+Vj7tMaMMbhFz7Ris2nWlyoHHOWPB2z/dzNMk/14aWeV1Ksh3
	N+ThpKfTylr/I9AAQtvLsx7BvHBfxlURWC36
X-Google-Smtp-Source: AGHT+IHd+JITPLxMXULU7ZpD1f9xac7PGEst2Tk9nAmNTghxAif9Rd8qWrav88C8IW+IaffyeOes+A==
X-Received: by 2002:a05:6512:2310:b0:545:16a5:10f5 with SMTP id 2adb3069b0e04-548391452b5mr5483522e87.30.1740477300601;
        Tue, 25 Feb 2025 01:55:00 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:00 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:48 +0100
Subject: [PATCH v5 01/31] ARM: Prepare includes for generic entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-1-2f02313653e5@linaro.org>
References: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
In-Reply-To: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

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
index 6eb311fb2da06fa393f8be7caec8d997637a88b2..a01c66f0ad907882af2a383e53de8aca68c551e5 100644
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
index f80a85b091d6c4ff365e15ae7100af1c3aed597f..815b5f256af164daa053f3bfd6cb2f54042a8d2b 100644
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
2.48.1


