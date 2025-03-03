Return-Path: <linux-kernel+bounces-542114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2260A4C5D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80507189265A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EBD21505F;
	Mon,  3 Mar 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFK3x3zN"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD331CAA90
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017302; cv=none; b=idzHlU3tGnJ7vrdm81UgSVValip/jNlWtaZW8tP+wqi/tcuaBuplo2Hm1PC3Q37n/yJIH31pFC8jN6P4XWzqMzdRM4YmbDA6zD/rn9Bhp5vLpqyHrCCdUHpHDLGLbolzV4aG9Y3pkT7CMouhwulaSYlZ9vKi7+zNnWqkVqZ47ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017302; c=relaxed/simple;
	bh=/GECM4yHN14EcBQhKEHJsLZnNhGEL64XIBBV8w+UjlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJGt8d7EcM/Y39fkK3y2ImP8ZhXOzL1shYvl6Ui9CvKFa1bTNAMZy06o8m/0rMbMuErwYL5F+HkQTk3cN2JI1gJRXITuk6+tN8OV/fN5GIxIqVtlCtmYcHstzkF5K93aZRzjqawCVQzXohzn/ydkQzmavx2wT9MXrKwOeQVT4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFK3x3zN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf42913e95so416414066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017299; x=1741622099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dO7PyIFZgM6/OdALW/Ipr3nEA+C1o2CzwttbTsbOUI=;
        b=eFK3x3zNhxBS1WL3NO4KJG0jUyodpCg6snc40dBb35L2eG2WjsRcdGGF2rnyiLtTZK
         cG5JkQCwYnKvLOoXAiWWZ5yWqVnaqv1c35BrrGxxZzMF8xEz3nfxoY5pSE2Oji2QMYEa
         WSPYClKHh0f8/42m3ybWRKeL/OAgAFaVMcybbW55d6JVG5c1bG1+ezT3IppxLMWmI9Fj
         ncn6t3Xm/NMD2jEHxEb9zSXCV692MyXnQNErGW59mfKJKeOWjSuCQ0+NhhYy/ph8QH0c
         y4F21v4cfJXg5U3HdkydX0sLe6aYZwiPkepguyDi6qz+lvNDJT4f1YNfo0sXX0jUOkpu
         aDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017299; x=1741622099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dO7PyIFZgM6/OdALW/Ipr3nEA+C1o2CzwttbTsbOUI=;
        b=VGqY60UTCLeg8CT3MSE5a7peeItVMKzDfJZPUC4fduMt5s7y53WJwLmgNXqbEA12/9
         qDXLGmwxmcx+mJCNQf0+vWRDp/UC4Bw4pLVdKdT48krazuDOWdwbbefNAnRNrRyWykP8
         iwW+cBaJHSaZkblhqlMVcbQaSAP7Bx6a6AyQjEihoZgn/msPFsjbzAKvtlGIJ4WHMyDO
         tE+bBA+IIaq5zkiAxqrGTj1asok4JcvPtZ9968DTOUMJddTqVPdK2t98WAXc5BtXqaD4
         a6P3XpJ98YUzxjqQ3QibolSfsJRJvELP5ald1Ex4q3Ohipf0RkB7sObloZBdPb6B9FzM
         j7pA==
X-Forwarded-Encrypted: i=1; AJvYcCXOqCzi8NkRJrOso04QJxcTvROh1KrMSOWKWf01Pyhdljn1g6EMMFlWCwHRO8fXjw+jxlAXQ2qAoIzM6OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pNBMOsGF/OLLbm0PUnR1ZwD02Bgo9Tgb4ddKKR8CVXhzBm+e
	lgQV7J/oYz9S7BRdybbIvf3KL5sZ/ZwNmkxn9/u3WkyoiAMEW1q4
X-Gm-Gg: ASbGnctisyx6U883bBr/XemjcW/Qux5Ecrv1/mPRWJrPM2zWyxfLI/xkaX3e9v3Q+2K
	fJwtU2Y11oi5F6GvUQdzLYue6I1wSJQYnRaWTDnJ8VmHERE/ExjA4JCoGW3leBA15WZpuxEvHyl
	AhOPpScg39q/wlm1G82/3iDZKOBIBhDhkqsZeuy5BZd7r+jOxCrBucjooAb20HoN3SptGCXIZsZ
	AJmPpYRFBwHi2sHFVJ1BMKFZPTc0i8+M5nnb+vBwJpwMLxS0KAYTsrUmzaT+RMi0bjMyQNrs1WK
	Egg7yhGyt9O4GfDRDDbLDF7hMISolG0OMVbEwBf4dQpsqnpzzwbC1w==
X-Google-Smtp-Source: AGHT+IGw03B6o9Xl5aCrS4NCGjCn5n79x9qVCxJjAqNfLBRi1fVapFpQ4sI+xkYPYv4bPPvrjNAt1w==
X-Received: by 2002:a17:907:1c28:b0:abb:cbba:c346 with SMTP id a640c23a62f3a-abf261fbac6mr1653506966b.2.1741017298723;
        Mon, 03 Mar 2025 07:54:58 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6c405547sm305699466b.110.2025.03.03.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:54:58 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 3/5] x86/irq/32: Add ASM_CALL_CONSTRAINT to inline asm using CALL_NOSPEC
Date: Mon,  3 Mar 2025 16:54:23 +0100
Message-ID: <20250303155446.112769-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250303155446.112769-1-ubizjak@gmail.com>
References: <20250303155446.112769-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This constraint should be used for any inline asm which has a CALL
instruction, otherwise the compiler may schedule the asm before the
frame pointer gets set up by the containing function, causing objtool
to print a "call without frame pointer save/setup" warning.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/irq_32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index eab458009f97..f351fa1ee6a7 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -59,6 +59,7 @@ static void call_on_stack(void *func, void *stack)
 		     "movl %[sp], %%esp"
 		     : [sp] "+b" (stack)
 		     : [thunk_target] "D" (func)
+		       COMMA(ASM_CALL_CONSTRAINT)
 		     : "memory", "cc", "edx", "ecx", "eax");
 }
 
@@ -98,6 +99,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     "movl %[sp], %%esp"
 		     : "+a" (desc), [sp] "+b" (isp)
 		     : [thunk_target] "D" (desc->handle_irq)
+		       COMMA(ASM_CALL_CONSTRAINT)
 		     : "memory", "cc", "edx", "ecx");
 	return 1;
 }
-- 
2.42.0


