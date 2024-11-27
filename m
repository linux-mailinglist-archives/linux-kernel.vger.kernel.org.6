Return-Path: <linux-kernel+bounces-423766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2EB9DAC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0CFB21F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A320103A;
	Wed, 27 Nov 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euNZRs1w"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED0201029
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728600; cv=none; b=atit8GlVt1pHSsSCIgtlOn3ucbPZfcn3x68GQgjSMpL9ll6OMAUz49tJNaxpme/pNT6zxkBGwgm/HlChDZbu2LbBsVk2MZMhYnYiI3j2UIKyu3Zc4LBsvVxJNGbQhsNE1JWkanqnStwJ+oLudu+CqYiwzvjvchC5S2ayoXAAMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728600; c=relaxed/simple;
	bh=E04pV8u5X/q/zozMRQRJk3vOfgV/NAqjoTSWAiWptJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1U7mz/6GfRcD4mCb5+yU4fE9ya5IGfSMcf3gU6WVtQFX6dHtUtWARrXyREUPrwJsiof6mgnwVQwYwTFX4wMHw46NiLahgA1sdzKX2e38OJXJkjH8B7+cM28mhktdPjd1P5J/SgCj1yATg94SelaVsawiTccFfuvw/q8+HZ+6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euNZRs1w; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so6171512a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728598; x=1733333398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUtTSvLb/awnb4pf5MloBg9/ARoAYzcuulYeAOWZ3lk=;
        b=euNZRs1whaXNbAJcIkiy5tZhg3oMSOlwer5Dv05vU9n3Vi3hB0aExqPa/qqBcgLfKf
         3zhVaI+LzD8jbE4bXQ+JEvDMsINP9J+GP0G59/mwWn0w8bLxHUOSIk36dJdqma6ENJ3A
         AdO+AAR810xepY0N0e9HV6RdvI3dfwfJHsGaGXDoFiUjcqhp/aqI0vVtBbJTRU/Tl4ny
         VQTdwXYKx7kVrlN4L8magTrknRbtrgGmns+nEXm1b9MRLGb/v7+0j5FjSFnNiSTz7n9s
         kbpYbRaBcoCFT/LhzxsVO9tVPewAfBDo3q9gREiivLX1qyN+AW14pKQRVAP5Bob3iq7G
         vKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728598; x=1733333398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUtTSvLb/awnb4pf5MloBg9/ARoAYzcuulYeAOWZ3lk=;
        b=LJZ9bgpvF5Kgyhea/yiTCKFI5KOQoke1BddUFVg84a+PtU/8+oy9sFf71ZdHMfggha
         1k5wAVuWu2b3ATvLoe4EK5OjWz4CGI7qOsn5MjzFARKc+ovY276a/uYrqyj90vsNybhC
         HdDgSUitY/PsgDdxqGuUThZRpjhCzORLrM2jGAGo1Dm60wTW6b7odsFmuzqUH/zUfjCb
         qafz+u/EG6PBWqgfi4/Dgp4QEfXOfbV5P6RAQ2JhL9SACLuLnUiX7rILunFeZJgJS1Qr
         vpQA4i6/kKe2i91ui2GbDYaP56FyAjF6mzPJKhiKL0XlMKCrsgUvvyVGIG74pH/XY3Af
         yxLw==
X-Forwarded-Encrypted: i=1; AJvYcCW3DARW+zJLvSMdEiiFCCdahbyNDf66MXzE6NIH6QhnRmipy0T8CHLHmP9rOSWKnBENerUq9E3r2tEFHlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkb6hgjc5Tfdwwb3q2yiCP83vrKWGok2+F2ZbQcK13Zptzbk6
	mPQFcETiWOWqELXLNjRy2B/AgVVH7bJ7v14fQQ7JNB0rrl/kuskB
X-Gm-Gg: ASbGnctDXqyYeOkIXnBva4xWtTknYLBi8tEAgRb1mgYUUPugOGxLLKSjTEJOMweUZab
	aKe8YA2H3aNEA7BeXd/Le2lMNBwZynGLpz+Rz3COJQSUGp8Ic85Ehl6g3Vk9MFnQLKmpRqpR59W
	YBg67azYgsQe7Cl+hyIbmYA0/RSWg68XLIbtBJxdiEXDk8Rjw4tBq0AG+3ECU+BQUp56geqRNOF
	NBrfuwnfOPpNIMapVQAXVfdenNvD1RhU6mOjp3nQy/6A7MHsljxI1q+0BNSB4S9WM6Bb7YOp6J7
	V5ipWizRsFcLvfezDqKffmVDbKHR
X-Google-Smtp-Source: AGHT+IGZTrwY9TsRiJj+/2qS9smtrrSi2Kd6N3yOUCcWlvOO+wK88Dm28z0bcTIf0ysSO3Z6//fqeQ==
X-Received: by 2002:a05:6a20:6a09:b0:1e0:cfa5:e32e with SMTP id adf61e73a8af0-1e0e0b8b8eemr5787909637.44.1732728598105;
        Wed, 27 Nov 2024 09:29:58 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.29.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:29:57 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 2/7] riscv: ftrace: align patchable functions to 4 Byte boundary
Date: Thu, 28 Nov 2024 01:29:03 +0800
Message-Id: <20241127172908.17149-3-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

We are changing ftrace code patching in order to remove dependency from
stop_machine() and enable kernel preemption. This requires us to align
functions entry at a 4-B align address.

However, -falign-functions on older versions of GCC alone was not strong
enoungh to align all functions. In fact, cold functions are not aligned
after turning on optimizations. We consider this is a bug in GCC and
turn off guess-branch-probility as a workaround to align all functions.

GCC bug id: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345

The option -fmin-function-alignment is able to align all functions
properly on newer versions of gcc. So, we add a cc-option to test if
the toolchain supports it.

Suggested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5bdda86ada37..75a5ebde4427 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -142,6 +142,7 @@ config RISCV
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
+	select FUNCTION_ALIGNMENT_4B if HAVE_DYNAMIC_FTRACE && RISCV_ISA_C
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
@@ -226,6 +227,7 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE
 config GCC_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=8)
+	depends on CC_HAS_MIN_FUNCTION_ALIGNMENT || !RISCV_ISA_C
 
 config HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option,-fsanitize=shadow-call-stack)
-- 
2.39.3 (Apple Git-145)


