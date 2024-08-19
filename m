Return-Path: <linux-kernel+bounces-291697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 680C09565A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7476B20CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23114EC47;
	Mon, 19 Aug 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtBnHmgl"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B45C125
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056430; cv=none; b=AHZ7g+iUkXKyCfql4qR9qOiLcvR9f2FTdmI8UydxVCh0PuKh/v645bTvkd/FU6mj3EMXVxANTgP4wo7OUU/EFTtTO6KdP5y9GzdIm8GzSHa7izY25F5k7VchjcXvKwe0HdNwP0Eq6xB35LrofchOQnK8lzINrtlLzhHva25aw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056430; c=relaxed/simple;
	bh=r/2mE26LhYOUrCN214dZpQf1JZLHP0/lng5fopOYvzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNwAMxvuXFJ+aJHCMReHsL+vKGShV7tc0Wzqw3BUWb+FA2IsTxsneqb5m2e68pwlfs2IRmLItgY35SYXzseMhB9RJ868rzf617Jf1jJ9K+HotfMivvsKN+cTeH4mb328NzOlBR6BeUSw3GHKAOgZmBa2zUywDxqHJMxprKAdQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtBnHmgl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8384008482so414249066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724056427; x=1724661227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3b7+fBvPEBrGNKQcOtXVzvIBh569+UuVGvzSAzppHM=;
        b=WtBnHmglFcQZ4rIPlX6ZdMIfHptteDWGd+SAmZfLWqVQKZ4tDnN7nC3jGChq4qqnlu
         cA7ETzNDuaf8675iD85SVNVy7lRG59bj48lpvkWdCcou08AIS8IovyNQAKN+19ZqmgUg
         6chrk2vqNc5OopqbS+j2MfYKQw9hAdEHLk8CZ7/bBjn8Z5Phs7ccMwnBoqbbDzQsS8Mw
         3SAUZflQAd3h496bpRRexj+pJ2XWfWDfbFhkQgJO/0xqeQiGgIltnslP5+RL7IuCLz9/
         6yDVZGPRUVuN6L7wEu3hj1DYUxjwaYKxKXx9+j+a2rTdaKWCDx3JK1DMSZ+grA9U1gBv
         YJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056427; x=1724661227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3b7+fBvPEBrGNKQcOtXVzvIBh569+UuVGvzSAzppHM=;
        b=raTGrgxg0Bte90QCrNSvwoxLyL5IwU3Uq29/Mv+hYbkDlrFiUk+r7IyB1BR5N89Elt
         xxUu3B/wAnDXRe6zMfyxXh6gQ+tDDfbUjsOawSNCQBPvnlpQ4rTk3xhKAn9TBIv7JF8y
         j+IDxoHEkmTPqKsaSm4ZJy8sX3P3JqsKClhu+T2qtzmbQOY9q6hoHHk/KKSVr1G8pwxO
         AuO3tom423LYCFqU7v9JSGmAZxUGqqkoRlmqmAcsUU2HCCXGh+FYhe6UB8wA/ewXnT9N
         deppKxntzu9osROtTE681/YaJtaB94lRVIDXbRhFRa8HfZecUEjndkpBY2CSz1jWX+gT
         8Hqg==
X-Forwarded-Encrypted: i=1; AJvYcCXRfP9Q+i7Ay9ave1Nb2rdFEUoiizS6kuuuwXUa1kBXL2baf2ENJYVzWshemt5q1hM8FToRBZr96/61B/gagYT0Z3ZU50N/81GgPuYt
X-Gm-Message-State: AOJu0Yx1Sfjfgm3+DdEJ7GOV2e4/AXtlWbI1VJvywaS4yBL1rPv79Pf5
	5kv4inWlbveQfqGudYH9LwqH7AUiEo4urtQ7NMPHEdHJxDOOEhuV
X-Google-Smtp-Source: AGHT+IHOYfgi2IoBawBKKtV6RazPErmEGbc9wdhSXGegBYXfWADFYW/keo/GyPEHvhyPEnC5ocegjA==
X-Received: by 2002:a17:907:9407:b0:a7a:8cb9:7491 with SMTP id a640c23a62f3a-a83aa09fe65mr454713066b.54.1724056427023;
        Mon, 19 Aug 2024 01:33:47 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934564sm602592666b.126.2024.08.19.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:33:46 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/boot/64: Strip percpu address space from gdt kernel load
Date: Mon, 19 Aug 2024 10:33:13 +0200
Message-ID: <20240819083334.148536-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

init_per_cpu_var() returns pointer in the percpu address space while
rip_rel_ptr() expects pointer in the generic address space, resulting
in:

asm.h:124:63: error: passing argument 1 of ‘rip_rel_ptr’ from pointer to non-enclosed address space

when strict address space checks are enabled.

Add explicit casts to remove address space of the returned pointer.

Found by GCC's named address space checks.

There were no changes in the resulting object file.

Fixes: 11e36b0f7c21 ("x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/head64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..2b7a4e28e72f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -560,9 +560,11 @@ void early_setup_idt(void)
 void __head startup_64_setup_gdt_idt(void)
 {
 	void *handler = NULL;
+	struct desc_struct *gdt =
+		(void *)(__force unsigned long)init_per_cpu_var(gdt_page.gdt);
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.address = (unsigned long)&RIP_REL_REF(*gdt),
 		.size    = GDT_SIZE - 1,
 	};
 
-- 
2.46.0


