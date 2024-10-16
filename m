Return-Path: <linux-kernel+bounces-368305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F59A0E11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0AD1C225D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1020E016;
	Wed, 16 Oct 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY+Qn35L"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709B207A3E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092223; cv=none; b=LRZ/tVsV4637+hstovN73HfVAOjcDbhG9swK1VLIcKn/+FTCn7jymAyTNG7T/eRBFeGuvCFktFeYvn0LsRM3Uec4cn0FjzoSdObRFSdpWuth+C43TX7+ObP/ukyVG5fO2rQdB+xaQWWE1tA7LWECwM31VTDfEY2jq6/H4ssBS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092223; c=relaxed/simple;
	bh=0qu2cXXnC8reMEiuHb1Zivk3BVfZDUXth2j7TV4Dg88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usXfNbeC0zMFUVYo2fBKFHZevN0nXWBdyD5fYI2odNM4c1mR4fVZPnxZuWC+dJZIpCWzZAa7IACQ2/oPxbznj/vb8svIyGWErd1mR7iTeID47tgw4dLk366E2t42MyDNV4uC8TDryHv5WvOEcs67jISVLNPZtaxQKft23MS2xwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY+Qn35L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5aedd177so3694607f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729092220; x=1729697020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cY/0jnN+gTIzlQ25L2cKGw8awZf9M+TjmgtDbkXUG4k=;
        b=FY+Qn35LQrxDtQCOu7sm7Fbjdvp8EyuLGbjAr1FHIqwgRmWiS/gwhKDJy03or/h6TZ
         OfqjzhF7hJZ7CiWQAV3UOONMnc3yQuTfrBIYZW5EHg4aFWqsmINzMK8ojHvT/p5EOCuK
         faS2H2O+9+A6UHer6i2VenghaototFfMJp97q0ZReBVsjw/iX2FX0eMjE7nH9CVnDvRD
         Wm37Rm1/GkB/zsWLrVeKiZ83CQNubfMisyTHpLGDJFcfd1d/RWTqHjdTElvTOCFk2jnV
         EshvAyBZU5pf4CaV6NFPM81AiBz8qUGIEo6IU62OM+hySbBHz/oWkZd+eJapNh1WV8Qd
         uc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092220; x=1729697020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cY/0jnN+gTIzlQ25L2cKGw8awZf9M+TjmgtDbkXUG4k=;
        b=XU7Kt8yV60hs34n+P0w5BFeGyC8/SZcPmC1mhY+yfbuwV9+1XY18N6puYRSrhs5ZSS
         JjPwEzGe0BHv0P5T1aW76RZn1qwXvd6rHKpwBklvVX1M8ItBDgmBW5AZl9vBEJwucCz3
         J0968J4VYVieZ3kcPfQea6oysfqVac0YFYv73yyBslvdjlIumkULCnlr+iST61J8XFwZ
         8yCDRvPYYgPGNNueDwi2KHX2V/hLfKsosEnDSNIEBvYoOIHsIM9dGhxqbSQog5E68WjS
         sZmyXFcnz7kxAPoO9BcjlcAeWHcGTa0zhNCrwrgcd+RknHvIVCUMikSJuoqZTxgqnbPK
         3uzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyI7B/8OAN9WoWwmREJa86ZQ9O2REQM5KvGatM+oaQqCN69df0fWsg7H5i0APSarNE2fudAgK0t34Je+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtKkWaiS6SnRqK+Kj621fFxnKiyyxil+2gWrKYMlFumAKq8jw
	8KIx2lIbgNQYtpfvq3uf99zuYToejFWksFsviTK9QbJZozJLasCxAJPQZpTO
X-Google-Smtp-Source: AGHT+IGtKdnTyrupcSRTo62NMnBUnx91dS8LOjqbIPdLBvUbty78w4AU3o2DRXrzuLqroVCLNmqXGg==
X-Received: by 2002:a5d:63c2:0:b0:37d:52bc:72ed with SMTP id ffacd0b85a97d-37d551c9775mr12197578f8f.14.1729092218149;
        Wed, 16 Oct 2024 08:23:38 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa95dfesm4592545f8f.63.2024.10.16.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:23:37 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	glider@google.com,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	snovitoll@gmail.com
Subject: [PATCH] x86/traps: move kmsan check after instrumentation_begin
Date: Wed, 16 Oct 2024 20:24:07 +0500
Message-Id: <20241016152407.3149001-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During x86_64 kernel build with CONFIG_KMSAN, the objtool warns
following:

  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
vmlinux.o: warning: objtool: handle_bug+0x4: call to
    kmsan_unpoison_entry_regs() leaves .noinstr.text section
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST Module.symvers
  CC      .vmlinux.export.o

Moving kmsan_unpoison_entry_regs() _after_ instrumentation_begin() fixes
the warning.

There is decode_bug(regs->ip, &imm) is left before KMSAN unpoisoining,
but it has the return condition and if we include it after
instrumentation_begin() it results the warning
"return with instrumentation enabled", hence, I'm concerned that regs
will not be KMSAN unpoisoned if `ud_type == BUG_NONE` is true.

Fixes: ba54d194f8da ("x86/traps: avoid KMSAN bugs originating from handle_bug()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/x86/kernel/traps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d05392db5d0..2dbadf347b5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -261,12 +261,6 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	int ud_type;
 	u32 imm;
 
-	/*
-	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
-	 * is a rare case that uses @regs without passing them to
-	 * irqentry_enter().
-	 */
-	kmsan_unpoison_entry_regs(regs);
 	ud_type = decode_bug(regs->ip, &imm);
 	if (ud_type == BUG_NONE)
 		return handled;
@@ -275,6 +269,12 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * All lies, just get the WARN/BUG out.
 	 */
 	instrumentation_begin();
+	/*
+	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
+	 * is a rare case that uses @regs without passing them to
+	 * irqentry_enter().
+	 */
+	kmsan_unpoison_entry_regs(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
-- 
2.34.1


