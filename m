Return-Path: <linux-kernel+bounces-396727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D1F9BD15A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CF91F21D30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61117BB32;
	Tue,  5 Nov 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b06IHHIA"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD6171E43
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822303; cv=none; b=hTtbHzxzxPka0nUWC12qHmd2P/O5KpD18zyN2Z0Vb3x09uCuGetuVboqV/WpDNxH0YDNN9XPBX/9IRT1OAK/S+E/L8tfrdU3tZhSvI30L0U2uVjI89mWgTwBmI78NBxlXax+9+5tIyamkTBIz2jWNJud5ZKZ9ejL+SgdrqDatvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822303; c=relaxed/simple;
	bh=aSfoz8f01sAcycyReVoobqmniWwJv2hf1ixTs7gUL4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGgSvjta+fATl1w7P4IIpJgZJkoC6KLMOMPsNfWcoVmuznz0YTksucDq9Y034TDdTKwU743SMpJoYdd4dcYCaaN5fpmY5WEP3CPJi8BdAMdNAFIIQZ++904hZQO5c3RSBq2gvcnngq78noS43/Wo/JKBEKIPqyq8L1GIgfj9m04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b06IHHIA; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso38800466d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822300; x=1731427100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZR9fCyHPy22vSYH6NWComy/2hJfZVn6mMOShQy32Qw=;
        b=b06IHHIAY6pvX6bI5VhSmY7PfTZ4WB+5uQ9YZfpsrbIi1LSV4bnDGThoz7Wc5lUuW2
         xt7Tx7fu8qZV7WnfBIof5lc90ug/jaEz78dbIDrr5MUCQ5uGoV8UW49bUBAW0zKav1hu
         pAbwmeeROxhX9quWJY4w/M5LlzaeG50KMRyM6ZFgOwatkZGM8fedbzrnzF+Xzz8duGsR
         WQLxEplGJTEfMuMEXl06frRjgFaHmDR8BoBBAqGS88hnsECWcm8qP/b+8dMRPO6OvNiJ
         +YogyNSlvcnSly9CoEUINlaT+kqyiTTWwwuFC7C3Puffp5hA7oXeTa8Mm2qGh0ZXx2OY
         irTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822300; x=1731427100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZR9fCyHPy22vSYH6NWComy/2hJfZVn6mMOShQy32Qw=;
        b=vvBXlVpPJXkq3EuQPBkY7VmVedYXBVMy2WJYWhtJjpSDNEbkCM2v3a3lUjd1sh04vD
         6uilvkLUE+Bl+24TRKfr+3DqgsFeImXj3AF5GpVq/UXnjIo04+G7Vtk6NWTGd8GW1ULe
         hkYjaFGYfVDQRG0jQTHUNzKNQcKue6P3UMFazn3Fv49vpqFrXE+Uy787shUnk0K9EDfF
         2g8OhDgIk+KzkTfmnfOZg50g31Y+fj8ByxihpP+vNdILLL9T7MaoLt38hzpioNe1pRPt
         /adLQLOe3R0W4ZEP+acyk4L6knElKmjdn+zSuE8BTk0+vwkUGrZn3SPAlcNRB3ZgN9ue
         HpsA==
X-Gm-Message-State: AOJu0YwM8oC+nJjWDsMuPsx1u044subtMNC1mNElKXM9Eqdl3ntOnPIB
	08ujHk9K+/w/627Y7flEOsZhuZIa33IkMayXVfXfnwaElC4j1rzG+9a4
X-Google-Smtp-Source: AGHT+IEVsEQEBvJC9E3lWcRb9NmeXlQziTdxrVMNHUPvzXAvTMOXCNBef3tF/J+2F/Lif4NgP8C+YQ==
X-Received: by 2002:a05:6214:440c:b0:6d1:9e72:596a with SMTP id 6a1803df08f44-6d351b20831mr300129496d6.37.1730822300240;
        Tue, 05 Nov 2024 07:58:20 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:19 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 05/16] x86/pvh: Use fixed_percpu_data for early boot GSBASE
Date: Tue,  5 Nov 2024 10:57:50 -0500
Message-ID: <20241105155801.1779119-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having a private area for the stack canary, use
fixed_percpu_data for GSBASE like the native kernel.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/platform/pvh/head.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 64fca49cd88f..b0a9a58952aa 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -159,10 +159,15 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 1:
 	UNWIND_HINT_END_OF_STACK
 
-	/* Set base address in stack canary descriptor. */
-	mov $MSR_GS_BASE,%ecx
-	leal canary(%rip), %eax
-	xor %edx, %edx
+	/*
+	 * Set up GSBASE.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
+	 */
+	movl $MSR_GS_BASE,%ecx
+	leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	movq %edx, %eax
+	shrq $32, %rdx
 	wrmsr
 
 	/*
@@ -232,8 +237,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
-
 SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
-- 
2.47.0


