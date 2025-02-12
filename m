Return-Path: <linux-kernel+bounces-511003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C881A324B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E65D7A317A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1E20A5E9;
	Wed, 12 Feb 2025 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZerPLqS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B582046A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359390; cv=none; b=HlYnT+iwIiTZn77066VLcpAd6qDvB2X1VdjDsk/t8twtaHXmHOta93PYts/iyJknourpWO1fBY1GLozsAH9fGb4B+cqNwGbxmJ3qv/eXyiHP2vDZjGivNQ+8pbj891vmxmkfGnc2OnFwVZZMc5piLMwYXekIX797PJ50OT1htmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359390; c=relaxed/simple;
	bh=14U0ZFqNhjjw9E+TCTCsgolcWhF3eoCcGTNYVrgmoTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zc9Xsz7gliFZuQU5ecpTuB9gixRzoboFNBqMiB+6kT0ecQq81ciBO3B7s/yfWbUZhWPWZSiKS4RpjzWxJhfKv5D2ZDy9IgZnhBcjwcqEVlfTnnHaqDR6ozRfP81ZCObTS71YaK7QMB4slhuesGsJKvwmTdd3nQvKUmIpuUiLf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZerPLqS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3072f8dc069so69700621fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359387; x=1739964187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IJUdaO+5dTLVXPMwfcKz8isZKL74F9HfpoDdIYxpPA=;
        b=VZerPLqSdVipF2xpUOhHOTZTuW5/X28kWWDhGeCiCLInu7VOzMIFGJogPrMwV/ZZsk
         l+rj9HS0XEB4yKtpZRJEaDGYJrx5pzaMLF2LKq26k8LZ91c+tk+c/y65vudkyUeusspf
         pWEKSPSPh6PLVMNxeASgeVwjkveHBvUqjzlZd4qSEvv7R/uVY6Dey6jkyfbN3vDfFdqX
         hokJROji7WP384wh/7bXnsKcW1KejFuxTtWSUZVujWTbOBJqxyN0EDdea82dNprHmTv/
         cphqI1RlfyXEesmCBF6g1a9IU8aw0h2Lq91Mi7kGRct+YbzaMnqdr++ZZbGL6YQOd9sy
         PO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359387; x=1739964187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IJUdaO+5dTLVXPMwfcKz8isZKL74F9HfpoDdIYxpPA=;
        b=CyL0lqfse8/+3moHRd8ZQbHkZUotQwidV0kgvKS2UdLdmLNLaoI1lkD5Hq7wTOVxsx
         FL+1ehiKTTLTwd0aDsF0wMyG4dcE4FFZOUrXMDnt5HtJii2vrr5C7lRr0cv/a9bVcQJ3
         Vbd6mUEWnhiWRTV/bgeWoIUiJLMC3ZvBxY5xEF8dGSRyWqftl7sN/tXACx+KKuUOgCyg
         H5MPLDgFoO0p9F1/CwrEde1mziccOvDL08p1JgV0MdJmPZml8sBqoA05C1738A8Phoda
         NBNYrwynvV8dfyWObjSwfcIU/siAeX9c+8ty+9JWoIejoXnib6uonx40y53f/2GczxfQ
         WWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQSb96GY5BH9YYz6uaNqbYy4G/vaiTZFzujKdVVlnGv7VFo/EbVBiWXi0XPqTRPR28XoJ3FX+hKIfSqnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMDKakWRSqr8yPGg2hMdOmgM2BZ0rbdgGxKK3XBZcoxxcY4dj
	K7EbCE+P6oKtWGiMpKg6SCwwN+cUrTQQy35CMpSTkVCWWNkIVSs7c7K0IcPvVQYgSs8KEaxXgmV
	d
X-Gm-Gg: ASbGncvZCTnTsexKL2EYThd03xnJii33+QKE/SNWFMiMDxYs9Cx1leYuymgQJnDphOQ
	69MxZe+Yl7pZWJYCuHo+Hz2HF+W+CjEmhLjnfo3M/B2gYITyjCu5VN8JAhu8BBrgZFNpzKO52EQ
	fXK7OpvPvrn7NH69h1PRnvHAsyAOmRqaPdy1wuM7ANWHG7p6EK5aZtyLlIpsoxvVRqyBgLsHTFO
	8uE1+dtJEIF9Lc7Zjg0+w43naa98tQAl3mLC2X3vatfFnFj2lGSJKc+tl3cyNVQ7i8jSQs7wvpy
	f0Tb2FqkQT14+VbUcaZIbiL/Ug==
X-Google-Smtp-Source: AGHT+IGpPfdcv9OC9/zIBoroOvzjRg04ZxGmAWsM7JxX7mbT/ANhbd0eNJDQrR2b6LwjPhGzC4w9WA==
X-Received: by 2002:a05:6512:2809:b0:545:6c8:94de with SMTP id 2adb3069b0e04-54518181238mr925712e87.47.1739359387058;
        Wed, 12 Feb 2025 03:23:07 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:22:55 +0100
Subject: [PATCH v4 01/31] ARM: Prepare includes for generic entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-1-a457ff0a61d6@linaro.org>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
In-Reply-To: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
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


