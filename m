Return-Path: <linux-kernel+bounces-542112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B8A4C5CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7AF1892272
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAC221480B;
	Mon,  3 Mar 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e91PJ2Ig"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986C3C00
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017300; cv=none; b=oqcdiLYU+E9l8kWQpbirvBZQhfiafNGnGCUFuMt5Dew7IbtnadSD5+4HPPbQ6XV5y2jfat+womNhMvzTRI7ByPGcHpGle82Tx8byELJGd3RpD+MblkfPz5I69Q3rSlr98DoNqS3GcUg2FHkyWFyXo8BY99/L6C6myARhqQL57HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017300; c=relaxed/simple;
	bh=whmlul+o5qIUTv4V4i7WcMVLDUT61tyN18dtg2ZBIvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQ0LBLKi6RVwxUAYWwoVBrzFIlcT7L5vjmtoZcUirLD7d/53I2NKnOtFY2iYarZI2/OBbUE8VtQTD1VHoeMdbvIG065nyjgk9wd0od113RkLZ7eYHBe8DSUVWEiZ1GWaeoxkUdOHCTrSzhO5gl8NzlyQKvRlFXZS2GmyFzjgoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e91PJ2Ig; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abffb7b9619so172509566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017297; x=1741622097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pg77YU+A9jfWD5hcRvLkdTxoTTRgQ/F2tGp7W/XocGE=;
        b=e91PJ2Ig3H5w5pfqnYIW3NmDTkRq+lsncD6hueZzudzOwzQsYxCk8TW8rDGdMwKyNk
         HtK3cDDCrqxdn15lu9FN2f7BYcOH3l9lZsCcmUiMSItcCYv762yxgNT8z2WPHIEy7VGs
         XJh0DweTxmf3EYcgySs0uHfXep/saYgcm6aQyHH3WtD7CXYQsS6TpggnZG/0LwfqKwZ/
         pOlyp4vX97d9nyfZQewI7PezSal94t+l4tWFXyOvE8zfLcis7RyQWsdI9D8L8WpGB9z5
         E0pA2ybJh/lfdAtjzHW7kiMrPRUr8T9lu+xyn8v37N8eE1Sg5RV07qTm7m917ZmGwfMJ
         Mk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017297; x=1741622097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pg77YU+A9jfWD5hcRvLkdTxoTTRgQ/F2tGp7W/XocGE=;
        b=RIK0ufEThGqmAQOTYU7f9wrGDy+umB/3JimB5CW6Hf8/gyXjODb4zzAhwLdEv3JCql
         8xo1FVvBzJxeMwC+d9GvZGQPvdD1277kdIn24IUVz6k82o77ecMsoECBwpt54gxLafp5
         rx3kdzf5PoUznUkeB+SRnb7+U1JAFhfiNgpM0yU4/c5OCKfrtd5X+N1RHcNKQvm4Q29Q
         Sxr0RejCldsQ0OPq7zpUxdVZdnPu7zHCsnK4hOZX+EVR4UgVMTQTpMyJWNHAbOLl9vyT
         YksxBJJygDXCIB4b3nXePjTkd0C4CbI6R7zAXJQVSCtMTxlJVVgGnL/TIPAnpIx5jZY4
         um6A==
X-Forwarded-Encrypted: i=1; AJvYcCVbeTP/vCmdI+xlfYF9NCDQqwuCFwbcmOhD5QTS76ci79a7nHpQp5o651+1p10VUnGWunhuakhwnVvuIgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oHA+rsKyPyUqNf/6IR2wLdTgX+eRm0+5E/iieA3i6tJOUsuQ
	fTVlw0x2vRNuNXU3ylzJTh0WZ1/51sVSAI4795hIZZcFPbGQZqYC
X-Gm-Gg: ASbGncvVdS6rfofp+E24byiypjfYLXyreJNzRXmreJP0RbQzq6oih5ihHbr4SamyG0V
	Jkj+no8v1ww6FzIEeiZUknOLvjHAE07bJc/PBq8uL5ep6tgYex+PqjoaYAdHmCLx7VEiReQURcX
	GBHNyKrDZCMxO57XTKpVDjC6PstEdvo9jLpumtHVFV9hcVLyZ/V4zfauoElVbpioNLyDN26UsOa
	7gKZZZSEm7dIcPSxbU6nn7vP+QN9I5xFzyMPK0oIuqcGhAPQAiJDl2G4ar1ddZ0vzeTazRBTTYu
	7M+7Xy3w7U2idCMy9sFXnVTmux2IGw1bTbh6ws+T4D9GSmO6plaRkw==
X-Google-Smtp-Source: AGHT+IHI4Ifbi8vA/Ou85GZwq6w2bZhRYjllsZYYv7uKrPwfl4lkkvXK2ubQjPp5LBs3TNOmdIHY2g==
X-Received: by 2002:a17:907:6eac:b0:ab6:d4d0:2be9 with SMTP id a640c23a62f3a-abf26862b90mr1740381366b.56.1741017296950;
        Mon, 03 Mar 2025 07:54:56 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6c405547sm305699466b.110.2025.03.03.07.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:54:56 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 1/5] x86/irq/32: Use named operands in inline asm
Date: Mon,  3 Mar 2025 16:54:21 +0100
Message-ID: <20250303155446.112769-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also use inout "+" constraint modifier where appropriate.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/irq_32.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index dc1049c01f9b..c4719c40252f 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -54,12 +54,11 @@ static inline void print_stack_overflow(void) { }
 
 static void call_on_stack(void *func, void *stack)
 {
-	asm volatile("xchgl	%%ebx,%%esp	\n"
+	asm volatile("xchgl %[sp], %%esp\n"
 		     CALL_NOSPEC
-		     "movl	%%ebx,%%esp	\n"
-		     : "=b" (stack)
-		     : "0" (stack),
-		       [thunk_target] "D"(func)
+		     "movl %[sp], %%esp"
+		     : [sp] "+b" (stack)
+		     : [thunk_target] "D" (func)
 		     : "memory", "cc", "edx", "ecx", "eax");
 }
 
@@ -71,7 +70,7 @@ static inline void *current_stack(void)
 static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 {
 	struct irq_stack *curstk, *irqstk;
-	u32 *isp, *prev_esp, arg1;
+	u32 *isp, *prev_esp;
 
 	curstk = (struct irq_stack *) current_stack();
 	irqstk = __this_cpu_read(pcpu_hot.hardirq_stack_ptr);
@@ -94,12 +93,11 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	if (unlikely(overflow))
 		call_on_stack(print_stack_overflow, isp);
 
-	asm volatile("xchgl	%%ebx,%%esp	\n"
+	asm volatile("xchgl %[sp], %%esp\n"
 		     CALL_NOSPEC
-		     "movl	%%ebx,%%esp	\n"
-		     : "=a" (arg1), "=b" (isp)
-		     :  "0" (desc),   "1" (isp),
-			[thunk_target] "D" (desc->handle_irq)
+		     "movl %[sp], %%esp"
+		     : "+a" (desc), [sp] "+b" (isp)
+		     : [thunk_target] "D" (desc->handle_irq)
 		     : "memory", "cc", "ecx");
 	return 1;
 }
-- 
2.42.0


