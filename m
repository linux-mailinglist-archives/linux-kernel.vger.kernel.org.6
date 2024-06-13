Return-Path: <linux-kernel+bounces-212713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A9906534
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB972289F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD7E13C809;
	Thu, 13 Jun 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iDD5YNkb"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5413D243
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263978; cv=none; b=V8+e7tiZzH6f7PiUVFIgUne25jzqJroCUU7UY1hezXP6kgMXDcValQ5M89SfHQCQqbAllWvvnfZjeT0+FAekUPOTt8xp5XehIbj0kKcvdXvpmFILRrV3VHa6T2gsiAuq3sj2NfQBQc0chBExOfH22i0FmDnV0gPkjeip+HBwWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263978; c=relaxed/simple;
	bh=Dx2FUFHDH8Y1zN/f24u2ocIVhF64yQxKbwIv1iUM+u8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWth5gg6gdPvQkGniRpgTuhCALxjN9PYkbhu6Pr5lcHWahM0C77sVfCcBGMflwqbAylyUGxsy8+C8u93Ht83IUKzTo2076BlHKPruDSzYee6Z9dPKhSDt1DDGLmFDqachfUJDRBRhg6c/KMwN9LRt2OGWIgokuq7QUX6jfzST7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iDD5YNkb; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254d001d03dso274010fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263976; x=1718868776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTElu2O7G4IRv2D6Es7gQcAecPf3onDHBKt+B4ik+4k=;
        b=iDD5YNkbvFhJnGsagRANRfyjoIH27Clpz4BtMXzf07CvK7Hm5MlXOx1S6bKu2eKNUI
         tWPtgX7zKKB5NW4VungXMwvI4Asz+yFRWUprn1TBpNIedqmz1x3mj6BmiwRxOOl5KMG6
         UCorkRpIOT/TMUr8ANB68TRGEljCUH6AuJFfYeUnUGZ0dWmWsiHpI9HD6xJ1qlEqeIJH
         K7NJeBG9vCDi0UVNllGag4NnmxVuvz8APW3UoPS52/w0LhK/p4J7/QEdnE1waTY2y8y/
         mm0y9FOJ0OkZ6Q85d4XGNkDoQAn1mRJSd8PfoYeuw3Arrac3A+IXbckQUxMuLo2enK9f
         XiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263976; x=1718868776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTElu2O7G4IRv2D6Es7gQcAecPf3onDHBKt+B4ik+4k=;
        b=Gxes6rXbny2MUPAkoyGEyyCOtNgaxCYyZzTXhNGWHziknLwXpxVFRJ9enEzBbRHjih
         aDeH094aIqKoTpCaTBOZDV1hMcL5b4XfVbLA53n3mKn7T+PCPZW2AzvN85GvwKicMQ2v
         DT9ZEBIbMtNUQrFXN1ueLCIxkno6ME/KlxYwA2mfKBN30TqNpAZg+CXHBVGNVGJXvYwx
         uodkW2uITrxpUPdQ8+J6Hr5lv16WdfA28aOSoVAg+GSfVMtOq3ZdXt//fpGDL/ANFKzC
         lpKFcaYF1l5e0a+Hta+Wm/0+E4+saUW7m7OZTslr9HvVuSgDobwLJnxNw4bgmrb8/kyj
         J7lA==
X-Forwarded-Encrypted: i=1; AJvYcCUTgYWNmKWHxJ03hNKVHN4GQFXukgj1FpR7Ku8qt7JS6DGVre3h7VTwureab+5be+ntQpK3cb4SoA1BFgqEdgdcrwVwV1hNaKFf5Dr+
X-Gm-Message-State: AOJu0YwZLrnHKwmw/bfTbpQUr68S8EgIWhW3G/VF/5/ztb8MDW0PXoc3
	r/Tan8j8gKbqh3fmQ7AY4cOBtXhXlZZZT3BCReDfgqMmwC4F9b4//MtqsxuKsG8=
X-Google-Smtp-Source: AGHT+IGdJsIqWxldlAuacUU8l0dK4I8dOhgAshBKtsVS5QR/psuALrZ1MwA3KVg0EXK2RXnVq6OGZQ==
X-Received: by 2002:a05:6870:c087:b0:254:a9bd:70b2 with SMTP id 586e51a60fabf-2551501e0bfmr4485943fac.59.1718263975852;
        Thu, 13 Jun 2024 00:32:55 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:55 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:09 +0800
Subject: [PATCH 4/8] riscv: ftrace: align patchable functions to 4 Byte
 boundary
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-4-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
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
 arch/riscv/Kconfig  | 1 +
 arch/riscv/Makefile | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..80b8d48e1e46 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -203,6 +203,7 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE
 config GCC_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=8)
+	depends on $(cc-option,-fmin-function-alignment=4) || !RISCV_ISA_C
 
 config HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option,-fsanitize=shadow-call-stack)
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 06de9d365088..74628ad8dcf8 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -14,8 +14,13 @@ endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux += --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+ifeq ($(CONFIG_CC_IS_CLANG),y)
+	cflags_ftrace_align := -falign-functions=4
+else
+	cflags_ftrace_align := -fmin-function-alignment=4
+endif
 ifeq ($(CONFIG_RISCV_ISA_C),y)
-	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=4 $(cflags_ftrace_align)
 else
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif

-- 
2.43.0


