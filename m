Return-Path: <linux-kernel+bounces-336860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C27249841D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783621F22581
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7E155A21;
	Tue, 24 Sep 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUr4BhD3"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01256155753
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169417; cv=none; b=f4pW638sPpwrRr16TwIuQblgNE6A9OGTUA9J9FovWKUW+d3h2dCkiBSyUTVHmSrfYDnYbuYY4d38uQPPaEH2Ufp4cV532QL43Xd6utZvJgpgDNF/VtfWI/+Km4hL2SkruptOSoAC7cgpzE8qhoNvkHVZGfExiBgFNREVRO1o1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169417; c=relaxed/simple;
	bh=C+LwmkyRKyyAe5zqhFuN67aHkoPhFaub3dYA2DiA+7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AK4eyV3qiuzsoJaNcSgmnFKDDw9epe6xz6DaRLSvKhSCBHnds7nwIX/5b/8InfnQWlBvssPvsROHfS0w9C3JLBYlEA+eeidsMPnOCJiD4cEuvkgttm02YEouGongEjscLb2nFH1kpcBgp5CkP5/YTKx4GPP7iYSYGSZ7uwwnDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUr4BhD3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so2971691a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727169414; x=1727774214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn80kJ0L6WBXHBbdNhas4oELBR7nvgAHYtPEyt6cEB4=;
        b=FUr4BhD3+eyQMkpFecQ9kR5UhIk1gAlFr2Nzqv3GkR0IYMFTGCdF0tLKOYatmZyyNd
         M5Ts9MFwH7iJXg/a8WiquERgSjH7X2Q58HbyHTJ4+pLQM9hR7rhSw2AZwvNOKcziEVfk
         WKQ7HbwwElufcfnDueu36cE70L+g3u1a8JXn89xnIuQT7n4uRfSmRdwg6arHRMwfiZMB
         Uw7uS/lojlM/Nc13PhWQhkPhBS8rU2UTeJoDD6/pjgJP6TX3/JBdavrMP+eIJXWCpFl9
         q0uqPeARLECyKfpK7Rhc0nK/Q57G9rY9TjD5h3myOg5/6/LeX6FrJFLPbYwdfi0Ey3Se
         4IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169414; x=1727774214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gn80kJ0L6WBXHBbdNhas4oELBR7nvgAHYtPEyt6cEB4=;
        b=t3NbEsiGjlDkCcirNZ80q/7VUYaTLoyleAlad++C96a1X1dqL2crmb4lFjoIKwHyfo
         R0JY3dlmIP5vgkTZ8Ec+XHbhHCH/iD4+fPgbuIXJrNUlaZp3vwzc51qcLWPu2ZVU4kff
         0dLJijFFTPEdQX+k4rY9lM6TLVSwJz9/jHIfLWXED9v9sYy1tJ9LoZdDyDxdJ8eAruN0
         zV/S3YDiuOYuFnzEdsUogyS9Fs4gd4yNyKuYTf8DmShxSbVt9cZSRBE758z+SSTBE4Im
         TD7GM8DzG9Vr1BxMkSG8rXU2cjkE3D95B6wukyehyasnR2s2YmeIcOEqa3PJDVDvjnhp
         ua/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZjRFbieNnHSQcwngQtEjPApuoMqm7Tw/sAagmKkqN/oZPulXo/y+eYgS9fJ3QCAd+dBOE2HoM4UhdTow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcSFEsaiWwuyyGHZw/6/gkYQiSJG2bLZfkYW6M3yfP+VwmYw2
	8AeHgCL1Fns0QIbJLdhbRS0sqoze2IXKVv9Yb1fVJ05vCFvnDKVU
X-Google-Smtp-Source: AGHT+IFkYCw90G6l6dzmsPDKcl8ZKP1kVRPLXIw5kLjF1AmUmY1iV6wSkbCXuBChMv/JxBYOL6WShA==
X-Received: by 2002:a05:6402:2707:b0:5c4:2e3b:1831 with SMTP id 4fb4d7f45d1cf-5c464df011fmr10003297a12.29.1727169414048;
        Tue, 24 Sep 2024 02:16:54 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d77d9sm547069a12.94.2024.09.24.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:16:53 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/kgdb: Use IS_ERR_PCPU() macro
Date: Tue, 24 Sep 2024 11:16:19 +0200
Message-ID: <20240924091650.1354115-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use IS_ERR_PCPU() when checking the error pointer in the percpu
address space. This macro adds intermediate cast to unsigned long
when switching named address spaces.

The patch will avoid future build errors due to pointer address space
mismatch with enabled strict percpu address space checks.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9c9faa1634fb..102641fd2172 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -655,7 +655,7 @@ void kgdb_arch_late(void)
 		if (breakinfo[i].pev)
 			continue;
 		breakinfo[i].pev = register_wide_hw_breakpoint(&attr, NULL, NULL);
-		if (IS_ERR((void * __force)breakinfo[i].pev)) {
+		if (IS_ERR_PCPU(breakinfo[i].pev)) {
 			printk(KERN_ERR "kgdb: Could not allocate hw"
 			       "breakpoints\nDisabling the kernel debugger\n");
 			breakinfo[i].pev = NULL;
-- 
2.46.1


