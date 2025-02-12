Return-Path: <linux-kernel+bounces-511005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA6A324BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0AF1886F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F320AF93;
	Wed, 12 Feb 2025 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEPpvCej"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993420A5D1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359392; cv=none; b=e+qqwB1Pr3JgYJSMcwnPDRshvTvmihFM67eNGRIxr8sKTRhLntuSylJxAW8ndLo3Y/re8Pdy9Ntild5fNljm7TccLIEX09PASVEtK1LKLYqiKYXp0wf616tnzUhw8K1QT7V8oU1VhuudHpqKxgi9rkOKccHzT0OHoJZ1oXFlf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359392; c=relaxed/simple;
	bh=/aaEg0GUs77SXJXwiTAWCor9c6mN7KhETo0EatnyqEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lu3P8V4Iaj7lpCwPxy2yYKH+j844QvJLk/vEQ2tYoFAp4nweFO+2LuhBDJd1gI/B7cmBVN4d95oJwvV/ufUdeH3c8A/qAHUYytttiwewi2ISfGN4H2N1o+YzKnPFPbCZfLFMpGWVWo9e98WrO9Zd/YhOZol6y4cMx4o2tbti9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEPpvCej; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-308e9ff235bso30048771fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359389; x=1739964189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5mhd6DszF79mgTOhWslIzEoODnT/4x94Ab5tm+ZGKw=;
        b=vEPpvCejOJJrF4KLy5brfmMXqEkb0YhyKBPfC2BqzC/1vfAGeHD2Y9d+OGmp31h4yo
         ww5vgqeqDTtilp+O92HNiyOXLX5eBlBCxnX26rUzN63OIvI5iTwRwnlBmXUMWohhWACg
         rdoPEsT3xhmFBSMwjKPL46exmW/6VoIzgmKKeTIyvw/vB3diGy4V0z48SiYu8b44fMrX
         1AxZCKi1PUe7xJNqfMD6yfUJJglMZPkmDpeIXANhDXVEaaMz08PWdYSKMzMmvs8tJ+Pr
         iCoNoBWkDMM4Gfq2/wSmSxYgsacmIQQjH5yzKq/MPmgtOLOI8jnefXkATXS/At9djvVH
         It6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359389; x=1739964189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5mhd6DszF79mgTOhWslIzEoODnT/4x94Ab5tm+ZGKw=;
        b=Yt04ce/eSKyvX1DYfQGaY4ODsvz5Aj0lBEENG81lyt2plOisdw42pz5n3QF7fjxl2/
         8ogQZnF4jlg/8f/zFg7W/P7fxAWv/OciNqQpCUoDTzyDDqZ2cExz9fzk0fpPg9+eHhct
         kFoyTV5xFnKtuRyGebre8rg8ToPyuQEicAkUez+91EbZwQrx/CZ6lYWNv3QV5GFL4umM
         nQDEJ4jzbmOaIpr59nHStIZXda0AHxOuu+YooXopX/VPcdlo2wacd4y+ul/HXmTlDCGD
         suHDXTgyJxifIRXwYevyKmJuUBnnxR1IZr8HZ3L/jD+r44DzoLmb9h+utx5SvM6sQ9xB
         9O0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyHMCjuTR995BK2Vdsi0H6Nf5RL3M+Z7xwhwp2mKltpYSQzq/vzgP+L8X7XYiYUoX8ADTfeLtEisOaADc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmNL+lhVpvo6LkcDB6CbWBCQ9tJBgsddPpwKiLDb0HZvVAkRB
	DySCVqcHkdrHswqSel/FEfBT5zOfqXfeH1qFzPjMIHBV/wvd9pqKK0qJuFwy7ls=
X-Gm-Gg: ASbGncsoB8WEgFZzeDjaYYfFLTrGKskwKJ9shvL4jGo/B671UxLSgd8KIy191W0g16R
	8ST4GaPF4YKvpkkTKXNSEatCU4YrBvCpDweQCxnKJEwqANnGchVhrHe68Bkq1b2++y+0/MNkW+X
	zPUkFFswLsoz/UGy0UZ0unrKEmbaePqrHtyNsEeJE3BcMqH3ydOBZmrGGqhBtfVn2/vNv5nxxo7
	bNv2Qv3YHdcVpgImpnq8T4LXPtkTAqmAwMK87N4InmYDZmaovyCCEmcBLuU4eAdmUNr5FEPVnzy
	q+xVwE/zYW1hHvV2Aj8poca9jg==
X-Google-Smtp-Source: AGHT+IHTMqYXojqkTP6hLJE6s2yoQfyjlXS0zVkP4hZmvDjU6HV8U27+O3ADPsPzDGK4vKbkksnjiQ==
X-Received: by 2002:a05:651c:19aa:b0:308:ffa1:88f8 with SMTP id 38308e7fff4ca-309036d733cmr10944651fa.23.1739359388991;
        Wed, 12 Feb 2025 03:23:08 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:08 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:22:57 +0100
Subject: [PATCH v4 03/31] ARM: entry: Skip ret_slow_syscall label
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-3-a457ff0a61d6@linaro.org>
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

Don't introduce this extra label anymore now that we have
a clearly defined entry point for ret_to_user.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f379c852dcb72fa5e960bba5621cc2152f0df0d3..2f93c2f6d5b8fdf6aaf3dda0192bde144fcf238d 100644
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
2.48.1


