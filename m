Return-Path: <linux-kernel+bounces-511024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1DA324D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE533A375E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526AC20F089;
	Wed, 12 Feb 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqnFJ1vl"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33A211276
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359411; cv=none; b=logZ/H8/d6dnSg5QovjkIWAdgtpkUfqrAD5knphmqhYbn5Rq3fGr71gLO2Pikn3kboFEFFE/9NeqbteeNa1DyxDh2L4x6M+VFMYLFI4Qlrt1zpSBqdxPS7xsNTMXnSQV5SZblC1NYFdnYujkc3vKb9tDTPJA2j5tx1sl6Ek1N/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359411; c=relaxed/simple;
	bh=gRRY9I7VEgpc2SzFQFjwtQNQS+H92UlWAbhYCFd9jxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r67SP+CiYcBvmTliFBcaKNXGlratFRjFQdVcV9+KmQ1ED2a5/FDiY5af6ayZG+n058abzFvLFGIfJUngLHfHI5OwevwZYL1lBi/Hmv6iYBW45yfBIHnUqRdOiYNaGg0rPW0Icq8SXMZDObYjnltCNNL+L5s79Wh+w0eCxQA/ziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqnFJ1vl; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308ef06b4e1so28379541fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359408; x=1739964208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFYj8M8sWUilipZ79moNvoJmNP0x1CtymAnRzXm2Cm0=;
        b=qqnFJ1vl3XNQf/2JjVveF5QMEPbnnE2dYMXY1AH8g5v/qnpBoH+vTaxNWvlQqRYZ3l
         rL3ssKWSZmDWWRyV9IhbXaAK6ryq/5v0lrxivAHfXJmRZma6RxvCCXEG5hPCLaNQujV/
         BU2RflDYMS9zNx0iTGTM3NhiGotEGPNNYc0NrH6XIiPGffj7NvXAvdse2cEoPWKbe7oz
         GpALgb9RvM7nk0Qa9if22Hqi0TzLIyJzrYUViUocTT12qHRSUhvlwDmlFCPa3ANCjz+y
         yRJxheLeHBbQiLi+uFPk/BlTzQt6ztajmgFLhlkTKbtPD/Dc/QK3h0H4/8woUqUSywqy
         trRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359408; x=1739964208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFYj8M8sWUilipZ79moNvoJmNP0x1CtymAnRzXm2Cm0=;
        b=ixfQ/vCr0sSiLMqLpeL3aKA1aAUuXzRTkNH4N9GYSHlAnFUrx6x6oceOxNtgeEb3iz
         Q8C2OXW0lgNpYk6wJdSsBn0hKcG1m80HziX1/ZtQenpTa/DAffiqhU80DE+EYaKR6qxA
         VbC72IBZMemz1Hx1GqGS1C5wZkAYCk0tru9L/41mnMd5GUWufNctwvQisLdDLopzWn1Q
         /05SorpKPqP5jNUktzc8LUeE0U6rEPm3L1KC+Uq8MJLf+1clFN+DSWAhji2ubLPL4q0s
         z83fa8gsFKs7nDQuMaO3/PTpdlQEiU+7+RpZsw/M734g4O14otr0il7ZzeJUDgYWET3q
         J1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVQfQBL7IlzFj1mmpEH9YJFT+tADHFj5Wpse/hItKOumxRqfXNxYO/VNMHKWviSgz/qxkHMTslq7f2kxaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQlPgkxRwYHtIi8FnM7Fh3Cs0vvLUAt+TuJdPXI5N1b6J0cvV
	hJ+xwc74lma9E8G+Rf7aS+4dZ6rdYPbe2+jmaKAodSxfGHpslc8DbbmZErre34U=
X-Gm-Gg: ASbGncttao5XuxwhWSaBfGRgwHLueC6AIFkuvoX4i8XXe0G2uiiWjmyMl9xkQWZtrzR
	Fwg+DV5I/0G2MSdQVMu+Z1e2xeDAH1szYT6nqvzghvA9z+4E1IOS4592uNi50CRYA/yCIIkrBou
	PYBcQsc2tIgtTAB70Th0xx7O8gkTyF28sT4nLKvKJb9W81RLD9peNBNJWw5cIjSS8Qvc+JTKQ+B
	YOtcijCOPZlkhJAymSq9s9wmhLvKix+L6cOuOtWretNZu6CR3aSk7hlRHPBZeozB4DxtU+uRjgp
	pRh/n2Tv00J2ZgqTvSyUmC86bA==
X-Google-Smtp-Source: AGHT+IFtx+JLgvxuRlhMSLR6Ap6cqBlv8BsXuPeR5u4M9sE4qMRSRRT4UspKmtEyZVl6ngpQPtOzZA==
X-Received: by 2002:a2e:be9b:0:b0:307:46f3:4e92 with SMTP id 38308e7fff4ca-309036ea8f1mr13238611fa.32.1739359407816;
        Wed, 12 Feb 2025 03:23:27 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:27 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:15 +0100
Subject: [PATCH v4 21/31] ARM: entry: Do not double-call exit functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-21-a457ff0a61d6@linaro.org>
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

This is a semantic change to ret_fast_syscall: if there is no
work pending the function used to jump to ret_to_user, instead
we proceed to return from the syscall.

If we jump to ret_to_user, IRQs are enabled and we call
syscall_exit_to_user_mode a second time; at this point a
this just means a second call to rseq_syscall(), but it
seems wrong and we want syscall_exit_to_user_mode to be called
exactly once.

Apparently the ARM kernel has under some circumstances called
rseq_syscall() twice on the exit to userspace without side effects.

ret_to_user also checks for pending work a second time under
ret_to_user_from_irq, but this isn't even needed any more on
the fast return path: this was needed because the syscall
invocation enabled interrupts when doing syscall tracing, and
all tracing invocation has been moved over to C in earlier
patches.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index ece9215717143427de7572a18a6dbe620a9193e9..33bc9e7c5b32f62474724f1d47f97af24dba53bf 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -49,7 +49,7 @@ ret_fast_syscall:
 	tst	r1, #_TIF_SYSCALL_WORK
 	beq	1f
 
-	b	ret_to_user
+	b	2f
 
 1:	mov	r0, sp				@ 'regs'
 	bl	do_work_pending

-- 
2.48.1


