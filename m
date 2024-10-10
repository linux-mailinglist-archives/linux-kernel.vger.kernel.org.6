Return-Path: <linux-kernel+bounces-358898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6199851C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD541C24406
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD531CBE80;
	Thu, 10 Oct 2024 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFavN5Td"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C001C4610
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560061; cv=none; b=ttgnSJjUI3GNDLfulqkLMLtx7bJbJDC4ulVqAkDTZy9+GmFdDUlAmhnwQ7ywbmGKlCwhtYmOTHgdkTVYgUHzSESR8U4KdUZcjMoC0o/dvMngvPXTeJydY6A8Bbzx4LW26juws1Vu8DNqVILQfLqDc93QdPB8AHOIMCIF+X9SnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560061; c=relaxed/simple;
	bh=6+lTQ2GqQK5nFNzuJ9HvRyHeFh0UjePZM0yliybbYSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9V9Gd7eJ3z+63noCSAQ8DT09XGDLt6Yl13LljoOUxg10NYt3rtlh/fXMM2Lqu8PmsUtevfeI5n9ivE7bvw4KT+PAkWiA8ipUIaYxj9KRe2zw/jeO0zWks8bb01gfjk7J3dQ9H+iHv+S0ePS9LsgBG11HASSoBTC7gADWlkDBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MFavN5Td; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so115801766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560058; x=1729164858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2OP9NgXP8OYjhdkePmH5sP15xkO/BVCD1VA0/cLgTg=;
        b=MFavN5Tds+CPqSMPLsUYWVoAqQRCbVHZ77DEcxQ9xKW/+6+gJyYrIATM41l6NPVqCb
         hyPujHeSIYOUN40Sny/R9wMYc9VQbtIlM3aBjgqnF6wqfkKviEde4bGpJyJsChjSsvwn
         kjI2HGQfjq+cFqQb0y8cwlH6YmEYaREyKppGXSYT9O+LO3QYfEqm8iG0pZwIJ5HdzUdc
         hjZrwH9hfB6YDgLTI8HJurVH4a/VvvV63tTPUPyamAEFAXn+GtqPMVeI+tSk0OQXlF7R
         S5OTO8wSjqDcQwBsy3RCKhOBf4NO5SpsdYW+FBElck8peeXN5n0vuoDdnu0K8mDLKh0T
         cScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560058; x=1729164858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2OP9NgXP8OYjhdkePmH5sP15xkO/BVCD1VA0/cLgTg=;
        b=uSXz6lXS/xON1JCkOWDye12nC4RI9WqW05QG1TcczPuO4KDGIr+49EOcGhegM2hqlf
         3rixXf2rcakZJNwK/iPYxUDFxv5dL96PJxZhO3zxnAFJkt9IX/U1IWY2URPoC4tbhPJj
         f90Ac0tBoPGudFEh3itgySpQfxPbxUUPXMoKBjUaEHMuR6wvXdLlhq2JFcdz33B94+1h
         PMwYal5fSeZrk2K49t7LUtC9OIApWo+kwPYOfG8H53BUrm9+6GBQKwo74/qzKr0tLWeI
         mEkOiM0nAptHC9ZC5zKFLEcx92Xlm7XsE4w7yN+yF6yrR9e+HprMmSaIzsD8SinmWLQs
         SW3w==
X-Forwarded-Encrypted: i=1; AJvYcCWfNljsezBHsDsyCzfMNKd4E4Sj+0vHRGD5trSZgilZCITfubr6N86VIWyyFkTn601JQC5Am63t3xXTMf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOf/OisIIt8w030JvWQvqtSnO9EKBXklbStsYtIOG0OUMw/nbY
	CV1Wjwd0NV/TVzYeeqCudvqRrW/hbGcJu1RJ5wHgWIyTmwYnLUFxu76F6bD8iYo=
X-Google-Smtp-Source: AGHT+IHjkGGKiDc97wWL2KlgD9Onfb1ojmEjNcRbkL8DUMdOhIwDFVL57b9sjrWd7TF2zYrCFdqZEA==
X-Received: by 2002:a17:907:7ba9:b0:a99:442e:34ac with SMTP id a640c23a62f3a-a999e8c9f03mr327117266b.40.1728560058140;
        Thu, 10 Oct 2024 04:34:18 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:16 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:59 +0200
Subject: [PATCH RFC 21/28] ARM: entry: Do not double-call exit functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-21-b94f451d087b@linaro.org>
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


