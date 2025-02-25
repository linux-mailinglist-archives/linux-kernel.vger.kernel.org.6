Return-Path: <linux-kernel+bounces-530944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738CA43A69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D4F174097
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1626562F;
	Tue, 25 Feb 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYkDK4EY"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3026281C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477306; cv=none; b=tbti9Wo2TcRi1KZWLW9UpwI+Iq/IcIVsXUyCyqgMAMNaSuwRYyXs8tr3wgY5T0SxLROd03aWGClLQmfnlTzGz7Ea1pDCiNU12Y4mDIgmf+iHfUSCyvg68jGtzSbFSq0CQwE05MbxkNIBysd4PNWHIai7FibfHOI2AQcwEOTwx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477306; c=relaxed/simple;
	bh=/aaEg0GUs77SXJXwiTAWCor9c6mN7KhETo0EatnyqEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYWqtCE2f9mvLn91+o6hY9nOnvvXpALtq5CPm3uiE9Zu5DWN94kZ4cYz66sKz428NkKfppOSegrkouQjLsvIy9u7IRq0S5SuQUUQFYHaY8ai0ClDWWavP8XROoLl3s/Kfeu2LzvuZnKeyXy56f3CGswsDkVwrsrlkucLkG3IBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XYkDK4EY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54605bfcc72so7215576e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477303; x=1741082103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5mhd6DszF79mgTOhWslIzEoODnT/4x94Ab5tm+ZGKw=;
        b=XYkDK4EYXT81YIYAZAONNE3opGyUVtKJoJVb2BnEHalik+0GvYvKHjsX/gWpnf34w0
         yyFkWfrVWfbBIWrtztiRQ1kq82tSf/3N9mpK2V7xGMLMoiEJnR/OgrL9cGeHEmfZ64QG
         DuCVMmz+L2KV8HYe7EuYwkdzHS1DZ0iFY553ElSOZoxL2OG1xir1op6PEljHd6GjaAxl
         tN5kUdW1R8ZPwySrfoLzBBXvzqDxWZ3s73C+HEjnZje3tS9Ic68+v/ovjw89codPR3Iv
         xXVgB3RKLcI2S5r/BUtK7lINhJhjpOVRj0gLYYCMbHRMUqm1RK4FceMDjvIIDBcLqKL8
         jp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477303; x=1741082103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5mhd6DszF79mgTOhWslIzEoODnT/4x94Ab5tm+ZGKw=;
        b=kcbnI3Uz0nS/sUG9fRvuM7AXub48CWfH8DcnAgCi4VMmtoC7hlhfS2TODEbE+dVgK7
         GW0owLS0U0HBGJ7mpemkJxy58n/qZRA/oQQNLtUi7sam6r5ERG9ILz9joyjAcD0eoUSH
         GHtXp3jzf3lNrasliUR2GoxUXQ90zt2KweEo2Kvo8Nh5Knxh9eHp46rx83LL/D2Mn8ep
         lSy2cXlP/BLoltuuK8plIi0QB7gThBx+FDY9497mMRfD3PCDvpSMhPxjq6hFkVl+CsEn
         ax2dsYP9m5P6w84RyBelYYJKcTqCGDqWH4WrT6vTaI01CJm22nSZr08yAK542m2OhHXK
         jCIw==
X-Forwarded-Encrypted: i=1; AJvYcCVnVMPE1dfTFhoHtifQdoh8lFNeSoz2WkAc9xBjRShjj9+1OBGfSL4sf4Yo6YvUny3VwwtL5ByfSlIc8kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7v5M9V5G/O+R8tGPjt7lIS+iK9xoMUGhkbbHlU3li8CxmAY/
	g7qxCl0PLQg/grre3O1AhwVEHXo/vRHWS5h8XpVhcUS4u45uNwDJXDwoUS3SiIo=
X-Gm-Gg: ASbGncvRzQewxiUQS1PIRcI5CPV7ifswGNWZzhP3LZn5lsN/VslpYGYY6biM5Q7fIIT
	e0E2khlYjI8f5XeACCkzyXTyJHGLzxWdfNqyzG01LkcJFLlTDiOoMjB0coIyg+H+WbcjJtX/+Zk
	8iEDup1Pklm88nsCPKDE4i4rmtjgx1e4r5SaVs955bQD2HM8N/RkflCbR1Nu8QUXyKdmL9Z3MfW
	rlLqgJt4368NKL48xi6K6hucFdATmhmYB4bMe8IiAu7yC74L9/D7lDG8YazBlbiIK0vx6zyrg+p
	xUih38fuL0SzAv0VM/dIhzRw55oNPypEC0i3
X-Google-Smtp-Source: AGHT+IHxMI3/M9aEsI7YosRrRsIEAAGbkbNTPpvA+15Mry08Go3W+i3rmuxeIPJbQpwMTvgT3L7elQ==
X-Received: by 2002:a05:6512:308f:b0:546:1d8c:60f1 with SMTP id 2adb3069b0e04-546e4662ce7mr8313980e87.15.1740477302668;
        Tue, 25 Feb 2025 01:55:02 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:02 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:50 +0100
Subject: [PATCH v5 03/31] ARM: entry: Skip ret_slow_syscall label
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-3-2f02313653e5@linaro.org>
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


