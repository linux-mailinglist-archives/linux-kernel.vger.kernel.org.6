Return-Path: <linux-kernel+bounces-212812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA89066B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD261F20F62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B884E140386;
	Thu, 13 Jun 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxD0L54+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DD13FD62
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267214; cv=none; b=DL0At8eivFI3vpUkERgpDQcUiHmJzwyzTZkx84vNl/I2Ee/MqBM5NdeU2SJcKu7knC1Pk1zDsGY9X/3vkFYRjJBqBkeH066lKgkAWkCfEPtqj+O2f4xUNv49VtU0ftL47IIIRQEN5yfAxrzo4ICKwxjQDnU5MOUCPwejqLQJ5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267214; c=relaxed/simple;
	bh=D5vLAFT/UKZRUuFFIFhE24D1SKV46kwIgaeP1UBJTnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiBx8jY3aGIPF66w3204i4ZJi46u1xiq+DnP7KztlqXlATwhqlOpSRjaVEkVyjgyeLskij6zY7qlmoxhDgrB6inyCqjcJPHXu5n9IlXcaZLHY1PTJoUtIvdEdc4WOLiTmrKs8Syc3ZU7bqsdWoEX3AvbPV/SJ7q2JeNetVzlLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxD0L54+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f0d6255bdso739888f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718267210; x=1718872010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12pt0uydV7PfO4lc7iBWvrcrHxVdMObVPcnNLZgNxF0=;
        b=FxD0L54+fQlzLRCyJcND5IGnijGIZwEWJKaklrDxAhGib0+mF0gP21sQ/kqjyph0lH
         UsDkP3sXFOR3qhqH+uzRiJPDxCBsosk6cRpWMJo0KkXnbeotOPc1yliFS29p2DJnPKxb
         VuXMG/X3NeqrJzaqxpzgUgIXzKRfBq0zQZeA3SHEyTKxJvGtden4rqIg+wyfeeNO2+Kj
         lubG4eYxcbmjzZ0qQ5lCINiJuH76kLZb6vKx93Sb9wYjc4FEcxx46rwuhcsUae8JwXht
         RxKQ/Iz/DyBBFnqMgJPBV1nCyijtoeUzrcb2bf6kv4D9rQnhP2IIRhyub1mkIpBjS5Ni
         rxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267210; x=1718872010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12pt0uydV7PfO4lc7iBWvrcrHxVdMObVPcnNLZgNxF0=;
        b=WRjT37xiuQmSOS4uo+qrEgqQTQ30lYxghqw7FHERBx6jI4rUGFTxq7jkRRI6/OnzbT
         9dFrlkBLyqdBNBAgfZeSWGUvQFFvKOlbFum7hHrL8O0lCsMAjBTZu/r/XDHzKBO49rSn
         h6bbLOr1eMXCu5bRvK8MTTiwrO+QbhEmuR2qwJNUkeyF1rOYUFmhTBFL9n1xlrKHSjLq
         r1idWwj34pF16oQK8i9QZImwI8X8ta5neqikeBb/izIMHBgD5odG0+eEAgk//ailnfgS
         0y++QxZVSplBZaeFZOWYWhgDkOzNF/jErV9hPFaGnQotLN3+EW+/IFb6gnKcxzsHI6tq
         H4Fw==
X-Gm-Message-State: AOJu0YwOswQSVyYpkqrS7h/8UujSaEDx3fKzq+5BGnJe1qRtI+IqD7ae
	ODP64ajQQUir4PUGXmyCOlNUkaEBYPnjguI1mVXFV790YG28ryNYO1RTag==
X-Google-Smtp-Source: AGHT+IHAhd0MhIHxSYnYmOs3QvR47WmveBcY7duawIDRhtH6pYeHO/WCF2Z+xJeM8P9gZGHB4n2Qew==
X-Received: by 2002:a5d:6e12:0:b0:360:7809:ff16 with SMTP id ffacd0b85a97d-360780a0043mr539327f8f.7.1718267209683;
        Thu, 13 Jun 2024 01:26:49 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075c6fa4esm845727f8f.67.2024.06.13.01.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:26:48 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] x86/CPU/AMD: inline amd_clear_divider
Date: Thu, 13 Jun 2024 10:26:37 +0200
Message-ID: <20240613082637.659133-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is used on syscall exit and on non-AMD CPUs is guaranteed to
be empty.

It probably does not need to be a func call even on CPUs which do need
the mitigation.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is a random tidbit I spotted at the bottom of the profile while
looking at something else, I did not bother benchmarking the change --
not sneaking in a func call to syscall exit should not require a
justification. :)

I am assuming the ALTERNATIVE mechanism does work fine for inlined
routines.

I am not going to argue for the change. If you don't want it altogether
that's it.

If there are cosmetic touch ups you want done here I would appreciate if
you just did them yourself, I merely copied a chunk elsewhere.

cheers

 arch/x86/include/asm/processor.h | 12 +++++++++++-
 arch/x86/kernel/cpu/amd.c        | 11 -----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cb4f6c513c48..7a1f741df8f1 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -692,7 +692,17 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_highest_perf(void);
-extern void amd_clear_divider(void);
+
+/*
+ * Issue a DIV 0/1 insn to clear any division data from previous DIV
+ * operations.
+ */
+static inline void amd_clear_divider(void)
+{
+	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
+		     :: "a" (0), "d" (0), "r" (1));
+}
+
 extern void amd_check_microcode(void);
 #else
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 44df3f11e731..be5889bded49 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1220,14 +1220,3 @@ void amd_check_microcode(void)
 
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
-
-/*
- * Issue a DIV 0/1 insn to clear any division data from previous DIV
- * operations.
- */
-void noinstr amd_clear_divider(void)
-{
-	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
-		     :: "a" (0), "d" (0), "r" (1));
-}
-EXPORT_SYMBOL_GPL(amd_clear_divider);
-- 
2.43.0


