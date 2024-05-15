Return-Path: <linux-kernel+bounces-179706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA9B8C63B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1173FB2305A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7E5914A;
	Wed, 15 May 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cS3yVULo"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453414C61C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765564; cv=none; b=PCHKthRmAztvgs1OWXpAxrs6mnz3YVB7+3WBd85eBoYJroHKjK2IwC7oePpqCNoB+KOO7jtst910xkN8ncCq3yWNLlvg3bVP6O8GQHK1CgZQyBOPd7X0lsqMnKnUCZBZ1xH8AsITisu6vk/b6uis5b4yDGtik8mi+E40U16mqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765564; c=relaxed/simple;
	bh=I9Njt+qSZitDC1cyvp2ud8/Ev+h1Ulu3Mosrsc2hC/4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=heiD7qDHKyYk4DQOKjGLCng7uyF82X3mTx7CkRmTBcFgNfFOWOMTakeEE0xB3czaTBhaxLFrZA57tvviXTbL6m2fX76zw+XCWLPreuM/3NNV8Gk5EWTOzmwiuXWmK4Ukl7+oSyz+AO8TRPuTWSCwz2r0BMm1XLxuodAXAU/JFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cS3yVULo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41ffb6bc28fso23317765e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715765562; x=1716370362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nEflG7FT4wfp5aRRf/eaCxI+2fXY/+QXyFHn23LNuwA=;
        b=cS3yVULoeD1Iw7sOuiXbesKqxYDwUqtZtKBRGiQCPpgSBY53W3n1e8NM0K9RfFNxDG
         6ChYBxfJ6cBZPzl2WnOaN6bbtPhjnWSQ4Z6gd9v7Ykc4Le1SesJISJit+JOG9p5VMRV0
         XJv4ZhN4gjL+9IKbISgljsB+FZ182BoQbq6YTBhYxOfz3R1dEm7IK/0VPNqFPtuq0pEo
         7mv9sI5Suc+j5qaiOzroUGbauKbo+t7GvbkxlXsPYniCKcUNlobB/r0rPnJfdk+mUCGj
         2N6A4PyznJ4ND6nRMS0CRiI8RcCAj9631U1R58ji6c+QzUlDX5IA83g9tAOVRJl9FUUv
         QzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715765562; x=1716370362;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEflG7FT4wfp5aRRf/eaCxI+2fXY/+QXyFHn23LNuwA=;
        b=r1Yf89uA0u15psCHH+7T7ScmC3D/MAPvZdYdNCZIhZnw9CxbfNix8/AI1NPDnRfvjb
         7WLHGyMfZqHtQFsgDiPRp/C06UwUhG1gVcWvAiDsuqTvzlFhrx06OtqXPbo/ha4F+jSU
         8cXBKc22rKf3hhxPTneV/LsH0mtIs0wAQC+f99NOZc2cEko3HfSWjO0+HYKdZIrKHUUW
         TxLVObYeKwQOjO08gNGcp52mw/+0e153/XxWj2vMvJIi+aZM06+j5A5fcR6hcE9jwjwN
         q/RlSf3fBci+3E2YAW8VY3V9P1O3VY6rXJJdLBVOw8vloivJZpNl1ir9yOk45XnB6RQi
         OwgA==
X-Gm-Message-State: AOJu0YxFg2AgWzbml4vTedoTAvWAg3jO66bxGT9OO6MraaElxuYTEMQ1
	Jdn7Kp0joqDRDcFL6iYAokdjhnxbtniERm2mYipYPw1+v7NG3gjy7diDoiGw39FvKeSL6kFcbEe
	VjJ2zGmHHksEOcI5KY9pKiIV7XRjXlmuKt5zxFRRs49HSZRhAhCp9Z2A+lEbTLZ0Bw/HGtC9rjL
	20NqC2ApidbV8nDQh1mUQ5B9a0+TmYgA==
X-Google-Smtp-Source: AGHT+IH1gSBqvp7AKGZ667U3ixsabHSvj9QhU4Yt6ofdfYCD3Ty+ONz0FDjbciuxrugmAaUEJQIwKs+Q
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5101:b0:41f:9ffd:fd26 with SMTP id
 5b1f17b1804b1-41fea526b2bmr978075e9.0.1715765561622; Wed, 15 May 2024
 02:32:41 -0700 (PDT)
Date: Wed, 15 May 2024 11:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=ardb@kernel.org;
 h=from:subject; bh=VGmtaanEnV9/j3ToAO2iBPI8VwmtRdsDGLxG+F/6uRw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIc2l0ah7Q/TfAPlntz67F+4KWR3145TsE7mzmheEFnBE7
 38n4728o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyE7SHDX5ETXGZm8s5nRU8J
 s2s47Fq0nN9kA4OKHuOH44YNT1PVlRkZpljpSt38/y2vs2HLPQGH9VXuX2d8X8wyP2zK88dbDqx m4wUA
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515093233.3698988-2-ardb+git@google.com>
Subject: [PATCH] x86/boot: Avoid global attribute in early memory mappings
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The decompressor uses the __PAGE_KERNEL_LARGE_EXEC template to create
page table entries, and this includes the 'G' global bit. Global
mappings are a performance optimization that requires more elaborate TLB
maintenance, which the decompressor does not implement, and so global
mappings are disabled entirely, by clearing CR4.PGE in the startup code.

Since global mappings are not used, it is better to avoid setting the
bit altogether, so clear it from the 'flag' variable used to populate
page table entries.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/ident_map_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index dfb9c2deb77c..e24fedf1e36b 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -121,6 +121,12 @@ void initialize_identity_maps(void *rmode)
 	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
 	mapping_info.kernpg_flag = _KERNPG_TABLE;
 
+	/*
+	 * Entries with the G bit require more elaborate TLB maintenance,
+	 * so avoid them for these early mappings.
+	 */
+	mapping_info.page_flag &= ~_PAGE_GLOBAL;
+
 	/*
 	 * It should be impossible for this not to already be true,
 	 * but since calling this a second time would rewind the other
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


