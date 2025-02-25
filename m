Return-Path: <linux-kernel+bounces-530962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0466A43A76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8697C3AA228
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D6268FDC;
	Tue, 25 Feb 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zY6W0Mxe"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348D268C4F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477327; cv=none; b=ef/Gchkdu4lJQaBIiQUZnhUqyZ8OiPyirmlcBE1PU7ed3s1AWW2/TzfiC0So4t0IC7wZV9T5ieAzL60KHV3UmWKOuTmGwHIF2LalmDbSTVdHWKFuEvXB1Us8fLHYez/Co2ViyaOGVT3O2wfqlKtHHzch4tXDVbBaNywP8JJCA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477327; c=relaxed/simple;
	bh=gRRY9I7VEgpc2SzFQFjwtQNQS+H92UlWAbhYCFd9jxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onAiARcAzYyLsE9jGzRQTOkoY3YkmFKZ21qUvIN+gJuaNv3i+k3/rDmqHT0xgb/lXCBVNaXEUlyiqsrdHv4dEo2shdAScp9Zw7cBruCsTePuXLhXpyyXxGJalA4fqYmL3YTonBFEeoeP+oWtZfYSnsZFPCmI7v5N02vZhtNzGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zY6W0Mxe; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5462ea9691cso6001075e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477324; x=1741082124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFYj8M8sWUilipZ79moNvoJmNP0x1CtymAnRzXm2Cm0=;
        b=zY6W0MxenAcFrYaGFoQt4AXL/ILr9xosO6H4N3ZHRNX/spgHugcDCqM5ItyFf5iyzl
         /OfWwgGk6MFZkDdc726Vy988S9oTMh0Gg19NELCd2GXnt5EpkZewilog1hfwEi1vv8vE
         btCcCXWnhM6258rPb6RlduFZ1WCyZ29bO25OhPAYR+hwtomM1tCKb7Vw/0nsKGCry34D
         XaYXIMvuzj1QhDm6w2t6KzxUOrZzPAD0Ill6KyeDxIB3MULtubcuiE6CpzntEFUSzA0K
         bIW0sQ2jxY0G+gudF6i8ulLojZvQPJij1cbwRmIKCjHKM9XoF0tay0hWtmXYe7lwBXc0
         IuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477324; x=1741082124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFYj8M8sWUilipZ79moNvoJmNP0x1CtymAnRzXm2Cm0=;
        b=uGxxQjMCb5KgPBELtBqAyNHHFDcLWgN55VEFSsOKX4dOssQMJOQwm5dUmkCl/duZkK
         Q9kYj/pmCzk5Bdh8JrPFTsAqeyqLgd+k8FsEThUeQO9YdQ/HxKK5itQHxkyAgJB1PopY
         ORaIXt0nsYp+ZpDrOtocdAzyAz8ntFH6n0UT69apr7EwyqiKHr6F5X7btWVO4mv34HBd
         riI7O7NvInTWjIrLju3wAacjOmDm+6A0VNarbDcJLSJos0iBFTFMmfHV3LzmynLbl50h
         LWdSzTsHCLDMirjxxkOHBwanV1YdQPIuIcGwLU8yGusFiewSDWN4Ozn0+UGYNdW/UQ+i
         6BWw==
X-Forwarded-Encrypted: i=1; AJvYcCXtN08NsFpIptg4iiJw1FsWLj+Gi1CSXJG0vv+hkDdxUNSfdRB2SjuC8Lk7/zeiopsZh2FXPHQd5+hLE5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgC+zHnZMXmCMmSxmD8mSSk4jdtpRnqxQU7fpSz7XRPgUvjPB
	UKznlFseZ9/vGnbH3l+k6pCE6A/OX+A8vGSH6OD55WKRPhtKYYSNLEhYUjKsK7E=
X-Gm-Gg: ASbGncs2neImGJQ9ukMU9r5YGIU3tao/JoQ4ovvh/u2hBF78r7pmOWMCQghSqXiZ6zz
	4E8NgfXJbD67gGIi6ts4DiDzfmuFtPbMdxtqFX9OEzb02EbQ/aKp+oJmzX8Hh/IDGmPrCTRAn/Z
	ODFJi/JXKh6orc+sXIIbkiLjf9nA5+EWubZ2dXj7ew2XYYMOjDVo88cqra+DF+xTc2VIUIq2es4
	3LgvjzAOLbN/D4sascauZQay4S2jpG/KuZ7aDlQbCTc76vp4P6eUPzTMT2meGA9bJeoWmr7fgcH
	Hop7E3y3/sAzkJIsL1AbczXTPYwf0wJK9xzR
X-Google-Smtp-Source: AGHT+IEXZnOHohV1r4Mfp6ZZX3DbBx2GvFu2h5njrZLMFHCmGZ4MEwYftDaVvCGo6wOkCls5ru72YA==
X-Received: by 2002:a05:6512:3e0d:b0:545:a89:4dc7 with SMTP id 2adb3069b0e04-54838f5ecf5mr6710865e87.52.1740477324315;
        Tue, 25 Feb 2025 01:55:24 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:23 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:08 +0100
Subject: [PATCH v5 21/31] ARM: entry: Do not double-call exit functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-21-2f02313653e5@linaro.org>
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


