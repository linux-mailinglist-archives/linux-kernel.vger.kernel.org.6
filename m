Return-Path: <linux-kernel+bounces-561082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B6A60D56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FAB3B3E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22C1EF0B7;
	Fri, 14 Mar 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDwULLus"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA201C861D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944661; cv=none; b=GI8kbGxr7q19jsrruuLgQVlB23ZTqv98h9DEnGd7gdyGNLbXNOraNm+XF4aUtGYD+E4jtriVNvPBxm3eFTo1kxvVmMZy+s8C6a0/jJLdF/fRSGD6aEdLmxM/sGPZwVex7swGOt7efFgK59h7rk4pbTTtxUpsUCV/0YE3BWk2rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944661; c=relaxed/simple;
	bh=xuQEv5HHTGk73xsSBeXVLTX8mBkQ60JuWPeHMXmiq6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKDtPeehLH9lygCWOyxf0UBuuO+Cae4LEGJ0UJVNKpw5mZrwqUw7zwTWoUYgyuHZg4l+CxSOQo5bT6wK5bVOMHwtVldTpt2H0/7LM+6Qy01KY/+mW4JjfXsycTwbWf1dsabWvK66wbxARCRS98If8Ttt0fiOd+vrvB5PKp5SM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDwULLus; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso276264066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741944658; x=1742549458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIW5h9flL0z254Wl4wP17SIc55EF1XwRlmQ99cCsC8w=;
        b=PDwULLusSoZC5ZLAaZFMmSaeRO/XpeMaQC3O6hlO2MBggCE9sfcuB/j3dKcU/05yOX
         3siEhwFHUxle8PrrOnMob+KHXpRRQ35gscp0gynNxcqNG2Ukewm+AjZttGgZXw/a4wBY
         +i1UW3Ae2DvUC+va9YG2gcUdoY6VUJYOmQw8xC06f2y0PL4TY26bAyLbJaRD03sZb7k3
         DI09jM94uXWmeYCakHvoyeZKfAwuaoLFMVZzCqFY16TdvaaS5JaWco9GdTfAG6KGKctl
         9TJoh+ByunExf9KCDMC34lPI2Aci0sbNrcomgCgmre1B7EbD1dXoR6FlVvQ0RUuLQLBI
         0KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944658; x=1742549458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIW5h9flL0z254Wl4wP17SIc55EF1XwRlmQ99cCsC8w=;
        b=Ud+5RuhDUKbDWBM6s+VJYKZXHi604s24BpKO9z6GJ5V1XACaPX9d5v7y0t/UvbnRRj
         l0D+em9YFIiijHcR0GLd8D0paUKGke3gWWBed2ZE6KEGXTcEVxxwdOfE2iqQCxBjCIwY
         sZFT16MY2WNOVfG8QrHAEX1reJSJzo9q9ElPORRJVuS1XA/0F2lacDAOJGDCP3yLpPt0
         BsWTDfHlHGP2jCmGJboXNr2aoOQFTvcwutkfyCvGzJZmNLF432Kc14qf51x381Ll0728
         JKfgzFHHn9VoVoue0CHwLiauwP3Q9vnTuNoF9RyC3DlZMwl1kt6spe5GQLsNy0UK49NC
         LY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFlr9NFFAFzMTX10ICUKzEI1Z7y9ImhulzHoXi5PuYhSTi1Vkem96WCvPPiF/Vk176Eu8maHZFHWZ0GZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+ADe+4gU5YrIz+/fGLBaWJmDD3eds5TbtoZmvduqUpWG1JF2
	F92eOHXzrg37eh1LJ+b2exdjI8p3Pcriwti7XzQbPVIQyr9gsYu+
X-Gm-Gg: ASbGnct3lVb71PLCJPUHJIcxPHpxVgR31Iiw0VH+SiO61q1QMlUX6J6upnorADo9UpK
	yaw19oBVUw56g+dfxnXgItfqqN9/INRy6B+V5OmZJOTH6KbI0HgW3gu81mKuzDTcYoWdMVci9Z+
	glBvP9g3yakxZV2pkjBy17CX/1pWaa9rz+NCnjQN0PLDjzaLIUujEANexTpgnuC+PQzfOBRS4mT
	Lw5DDBrN8nWqYy30KLYXpoYs27B3J2j64U+DaK/cVhDoe7AcuOAPh6fnYGjLDwgYPgfj8agt6zl
	m7/CHfyiSrd9MHX4fxZqi3mDOcQMXwOD8G3OiB9RDehbDqY=
X-Google-Smtp-Source: AGHT+IENEbKqV6ujzjKsOzU7ssdVpEddM44X7XRA2VDTkB7A670oiFcZWkcRS6JNJbisnVgj1LhSpA==
X-Received: by 2002:a17:907:3f8e:b0:ac2:7ec8:c31d with SMTP id a640c23a62f3a-ac330267166mr150839866b.17.1741944657866;
        Fri, 14 Mar 2025 02:30:57 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf09dsm196800566b.121.2025.03.14.02.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:30:57 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm: Use asm_inline() instead of asm() in __untagged_addr()
Date: Fri, 14 Mar 2025 10:30:55 +0100
Message-ID: <20250314093111.654359-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use asm_inline() to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports minimal code size increase
(x86_64 defconfig with CONFIG_ADDRESS_MASKING, gcc-14.2.1):

  add/remove: 2/2 grow/shrink: 5/1 up/down: 2365/-1995 (370)

	Function                          old     new   delta
	-----------------------------------------------------
	do_get_mempolicy                    -    1449   +1449
	copy_nodes_to_user                  -     226    +226
	__x64_sys_get_mempolicy            35     213    +178
	syscall_user_dispatch_set_config  157     332    +175
	__ia32_sys_get_mempolicy           31     206    +175
	set_syscall_user_dispatch          29     181    +152
	__do_sys_mremap                  2073    2083     +10
	sp_insert                         133     117     -16
	task_set_syscall_user_dispatch    172       -    -172
	kernel_get_mempolicy             1807       -   -1807

  Total: Before=21423151, After=21423521, chg +0.00%

The code size increase is due to the compiler inlining
more functions that inline untagged_addr().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/uaccess_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c52f0133425b..3c1bec3a0405 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -26,8 +26,8 @@ extern unsigned long USER_PTR_MAX;
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	asm (ALTERNATIVE("",
-			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
+	asm_inline (ALTERNATIVE("", "and " __percpu_arg([mask]) ", %[addr]",
+				X86_FEATURE_LAM)
 	     : [addr] "+r" (addr)
 	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
 
-- 
2.48.1


