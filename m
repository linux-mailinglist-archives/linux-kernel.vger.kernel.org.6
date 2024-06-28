Return-Path: <linux-kernel+bounces-233820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C891BDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABEA1C22EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A8615887D;
	Fri, 28 Jun 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CiXXyr5R"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666015886B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575304; cv=none; b=c9dmjtYnfacToeijufVYny2+rgsPb+2mK4KOQvlnO/TsQSR22Yez1SLGbTgJrkMh6axEp1wDk65zeGa8X0wUdkM0tpL3dnSrb9cyJpIZiuix3LSM07ujzpT9VeGpCYrgy/riAcwaqR8Cb4jyeyyBTLiy57XICZvrBU3wVUL3JfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575304; c=relaxed/simple;
	bh=p2HySWNSHl4lGfXVKZPfkGILCZymtqNKCJwXmlevm4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDcjvBDd5sel4GZUjiGOUVVsT7Q90PDApgwyJHoKV65mMc5wINlwpLCaKVP99HkX14e8aaZf8AqE83fA0y32Dh9vhSz3wkMJ0bRDzxF+kZ2HPb5IelD8UISztDjKcjvoHsn7uJqLj+hHzVb8gjIIJe7vupSQatQtNSEBVnYIyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CiXXyr5R; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d55f198f1eso232960b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575302; x=1720180102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R4ThAGGzyxzKL16VZ/3SLSpBqDh/fGCMoUEXeAx/HQ=;
        b=CiXXyr5Rfdm7YFdwgKAiIFKbW1PbwyCs1TMJ65k00F5YeSy5Se1MAQRHTbaf/UoYLs
         f2n6kL1EkG3g/KsF2KpL1ty43cCpbslWLICiA6vM56tRIHVPHLqH6x5i6NCNd8XymKiE
         4KRSTtrU4K8v7/aort7spDWZa3uPNIr993/K9TmmJZB9lKTvGpmGxuoKoF7hgWyqPt8c
         cxgoG5dB5BCT43jMmNUOsbWVtINpzIq3ZEWsoFS3ojWEP06LP3w7N5Jm3H03ZjHDzUK6
         hK00yTd+WHejxi8QE6qfKvcByH3TszDHPUMve6bdzdgdJpCdmMFm85t8OlotaBqPGgBu
         aGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575302; x=1720180102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0R4ThAGGzyxzKL16VZ/3SLSpBqDh/fGCMoUEXeAx/HQ=;
        b=Luy3fOOa8qeFsZgO8RFXawjP733sTn5Re89o1NGl+BldYku0azDfr0pq+l1rTjnhtn
         /IWqWBQU+tlwPQlzq1R9dtxeCHeUmQ5ffjNmzHaTkbSK5PnhPDV6yf2CEwWh8IAvPYlV
         cCbzSoXd3BCOoF/bwPJOGSWH29GUdmPVWvD9aDtRhWPrGyDY0Gh0rHqXv6BTlTLP+JOp
         PIfA/+F7MoFXDlUDN25f9U/bdiwBH92L/QR75O1ZJoHhGzuNr2uWYeTN60vCQ/f5aMi3
         YZJfhclcZiiYgalUVJ/wZulS8THb9vDECw5LadKu0tb3cUXjZ5L2behd9CXTgYNvUPMi
         WETQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyv4ZHowt2x51sEAL0xiHtzP948SXIvQYjJFtX6Rgq3EeFvAVW8R3V/HOlj1YJdwDZHXGaM7GXE8bGoYb8hcNs92bLjjsZbSSb3yyS
X-Gm-Message-State: AOJu0YxGprVfsRQ4cnqifqQ9QOmXn3GzrKr/03cPbdq78+OwkQpCKnZo
	tmC45PJRUiNMzQndUAf93NeV2VZOnP6m2mkeVwY5gLQguvVpqLLVnUaXrUd6xB0=
X-Google-Smtp-Source: AGHT+IG4h5F6VzLgJwsJVSFf3Gl7LvgvGwcibgWFpRNTrZUraOpcCSEmqXroyM6n2QyUfXey/pxfEQ==
X-Received: by 2002:a05:6808:16a8:b0:3d2:1a21:782 with SMTP id 5614622812f47-3d541d46720mr17312078b6e.56.1719575301977;
        Fri, 28 Jun 2024 04:48:21 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb90sm1377775b3a.139.2024.06.28.04.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:48:21 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 28 Jun 2024 19:47:45 +0800
Subject: [PATCH v2 2/6] riscv: ftrace: align patchable functions to 4 Byte
 boundary
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dev-andyc-dyn-ftrace-v4-v2-2-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Evgenii Shatokhin <e.shatokhin@yadro.com>, 
 Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

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

---
Changelog v2:
 - Use CC_HAS_MIN_FUNCTION_ALIGNMENT and it friends to prevent reinventing
    wheels (Nathan)
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 704d4683bcfa..55c70efbad0a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -133,6 +133,7 @@ config RISCV
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
+	select FUNCTION_ALIGNMENT_4B if HAVE_DYNAMIC_FTRACE && RISCV_ISA_C
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
@@ -208,6 +209,7 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE
 config GCC_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=8)
+	depends on CC_HAS_MIN_FUNCTION_ALIGNMENT || !RISCV_ISA_C
 
 config HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option,-fsanitize=shadow-call-stack)

-- 
2.43.0


