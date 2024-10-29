Return-Path: <linux-kernel+bounces-386761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF2F9B47AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CDC1F243FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3420E029;
	Tue, 29 Oct 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uEr0Y7ZY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7820D51C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199208; cv=none; b=noW1eXVIGreO6ZFgwXBvpCvq4Fe6fMuBZukzBlq1+uG7FiDfmiKVntYaUTpOCqIl6Ngt8R6RXlBf0peXBDzPu3KgvWgW+KX29LwBl3NDZm9umEbCg15ZL8P9X1FfC7R/0Xv4bzIT26N9rUx+T6CGonGGlExRtCrnE/g2uT5hJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199208; c=relaxed/simple;
	bh=6+lTQ2GqQK5nFNzuJ9HvRyHeFh0UjePZM0yliybbYSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKFXIGk1QqNWmdsSIcjNPmayQJbeoVvAc1Wns1SzJB+NoT3B0BxcxOwxGL7q+9tu60eSeBFGwkq+XzM0B20dohrCFpw9Cw+IuXJDDsVXzilogdgugltf7BKzkucL2bRBg0QQxdvR5fMbAwIkVq26ajL/mNevnuJOxeNBlN82BRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uEr0Y7ZY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so6476624e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199205; x=1730804005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2OP9NgXP8OYjhdkePmH5sP15xkO/BVCD1VA0/cLgTg=;
        b=uEr0Y7ZYx++2nx7ghfIc5Jy34ioHDvN8MgutKVdej149ITq4+eA4jY/MQbJtxyufsm
         JniBR/FqAsOF1zrs3t7/tE3ztegMip37aa9i7PbKvBVxwTS26tD2a+UpytPyrolqWLTs
         zvPmkAOkE1UzTbWJOvKFdKGSVlVHmzBKnzw1v+rcmLmOmctkQNqmEojxfNmBZ3DFiUCt
         2rgTPP9Fmkf0oTYtfPFjbDSr29bg7TSPpvUiJzkqmCJTys9p7kXj1Fsb0/EOGUch+dm+
         oHa1FLSPVoq9u39jSAe90o+HZ6UjQ+fMpbspUPFhSLCygrTYLAzVo2IKwDK2EqKGfFnX
         6edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199205; x=1730804005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2OP9NgXP8OYjhdkePmH5sP15xkO/BVCD1VA0/cLgTg=;
        b=ZQlVwW+U6xPdRYGoKj+3EZfBByJGu4kU0/rS0zLwjSBecScPrxx+WtXBkL/p+yCobY
         3yKdTqZpTbJKSTHjl0Z4Gwgqpverx0ImryM99rAegz3zyI/chujPudeKVw09HWO95pgq
         gV4RUOnDdWpDIiw6n4MvGULjwNMDU5nL2WIVE8TobTsz+CXStEHRFFRM0jnGbgjagVTp
         i37Ja0I3h7mFoOw9ees1LOzLH30WL6bug0M7m3cWVyV4+hBHc6vNoCkDI95vFZqKWk16
         5bVjHWNTPoQ4fHY6NyrOvO0WzHlZWxLe/H9Y3oqevC6+yqSXjBZn203iBbfR3KlKXFi6
         BMPA==
X-Forwarded-Encrypted: i=1; AJvYcCXl2l15jLvpVjPOWiL8x18XRVygypbmAvs/96uGxQdM4nHcNP+iiwIEi3qOasp1f/NLUfM8z1x7Pqoc7SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+sXGd8IdS2hEir+PTDDPYoHKdq6B2V06e2XewliTCdW9rXk3
	zg77A0MHNxSUZ6PZmqEGYh/k0k1WvP7lY4D8+K2IwDFn/mwexX5bOWIfhNTZIjg=
X-Google-Smtp-Source: AGHT+IFllmxwh7EKDe/a3WvQfs+EHBA3khsZLhUnL3Z+I/JP6m6A/TkF2H92CKvNJpKEWjTk3WNgUA==
X-Received: by 2002:a05:6512:4022:b0:539:fbfd:fc74 with SMTP id 2adb3069b0e04-53b3491cccdmr5480123e87.40.1730199204557;
        Tue, 29 Oct 2024 03:53:24 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:01 +0100
Subject: [PATCH RFC v2 21/28] ARM: entry: Do not double-call exit functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-21-573519abef38@linaro.org>
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
index ece921571714..33bc9e7c5b32 100644
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
2.46.2


