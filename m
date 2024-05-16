Return-Path: <linux-kernel+bounces-180900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110368C7491
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B641F2423C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87758143C5F;
	Thu, 16 May 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MInJD0O0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F3143754
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854965; cv=none; b=uwM4lv4dmm/z2Z0oyWOEdlEcWF2LHtMwqybSy740YENO90a3isQK0Sdkgrx+Z9UdHcPNwGX9yFxA4SLYfUpm8tZyVJA96s/H2/FFrbBgZjhEpvyTB41HCxXy3O10//2R0REBqsY8uf9OaS8UNmulwO0d0wmUX3ZDAV2IobY6GY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854965; c=relaxed/simple;
	bh=4RESYLk2bxiIAc2MMrElvplj/bOnF/qlafcOgSEVD4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RV8XRqPqs4nMThDnX1a1vW8bAo7ayNjsGmwpTebnRodqp2Tuyk+skMiVZaxP0+OnT4PCM6Xx+ilvIIwPsuOQnqj8CWGgJwWADXunyIgiZgoULV+UGEaNHwmxiSFJjoCydy8gO36YOyqfsQ8w0sKLL0xOs49oDt2Hlov8yrjhAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MInJD0O0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68333C32786;
	Thu, 16 May 2024 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715854965;
	bh=4RESYLk2bxiIAc2MMrElvplj/bOnF/qlafcOgSEVD4k=;
	h=From:To:Cc:Subject:Date:From;
	b=MInJD0O0w3I5bZuGy31dUwr8mUye/DTHdK17Mgrpg77dVf82/nj9Hh8UvkZ9KkVgc
	 hdOjnlXdWnOeBrJLyeMhV7umhv44hBf4hAEsnqrUe1H78W00D5Qi4Jh/bdFFi50LR2
	 WGuM4Tu1P/hyKAf1GAYLkc1u6rfKOzNXDAEsWvxOQ3IJJoPUUZOJDPWB2XLHlwoTzT
	 e8Y4UJrgRaDYxAHU0BJ4wNyqncyoWfcsIjOMVK0RbY7MNUNy3v3YgsMal2dkgQJvG5
	 0iF0Rh07pbjTuKOWiESdTH9VzHnJHD8XDkizCgyS8y5aiZzyAocdsUF74q1wzPhdSA
	 suZHtYHCr9AGQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/boot: Add a fallthrough annotation
Date: Thu, 16 May 2024 12:22:40 +0200
Message-ID: <20240516102240.16270-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Borislav Petkov <bp@suse.de>

Add implicit fallthrough checking to the decompressor code and fix this
warning:

  arch/x86/boot/printf.c: In function ‘vsprintf’:
  arch/x86/boot/printf.c:248:10: warning: this statement may \
  fall through [-Wimplicit-fallthrough=]
    248 |    flags |= SMALL;
        |          ^
  arch/x86/boot/printf.c:249:3: note: here
    249 |   case 'X':
        |   ^~~~

This is a patch from three years ago which I found in my trees, thus the
SUSE authorship still.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/Makefile | 1 +
 arch/x86/boot/printf.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 3cece19b7473..343aef6d752f 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -69,6 +69,7 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
diff --git a/arch/x86/boot/printf.c b/arch/x86/boot/printf.c
index 1237beeb9540..c0ec1dc355ab 100644
--- a/arch/x86/boot/printf.c
+++ b/arch/x86/boot/printf.c
@@ -246,6 +246,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 
 		case 'x':
 			flags |= SMALL;
+			fallthrough;
 		case 'X':
 			base = 16;
 			break;
-- 
2.43.0


