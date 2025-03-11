Return-Path: <linux-kernel+bounces-556372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B383A5C4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5037ABECC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9725E82D;
	Tue, 11 Mar 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcEipB21"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCA25E813
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705677; cv=none; b=ky4JGWqBjr8iGvVLwV05g8Ed60EP+5xedg6WDRMzA35CtXtTLVW0rrWkBm/phWNu6wdkZ7cHtcgSvFsjG1XBkIiCKUuWAQ2aeruOAg1MrQ/p3O1M0su+hiCvjJUhd5nnfgGFrngMnd0gcV/GqFVVCXYrExOlTEmijololTitJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705677; c=relaxed/simple;
	bh=/2Z5uLh6qTiUL+hDG5kMHpcKNzhYDhvgcJOTWV3H7c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Io1oVrbc1Vymg+GDdeArmrBZFTxz9TwBjPjs642GEG3uMhZH9o8M2Ux9dej1vvYuD3o9F0Hm+YAINcmr1mDvwg0fd41rpatJCyOQ2EAwZ+d5ynuxxh9Tjsbi8xkkeD4LzHTbqEX5tt/pdpwk79dhNqM66NJN5RjBwIzvRTXT0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcEipB21; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abec8b750ebso947965466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741705674; x=1742310474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EbpJbTnNw0bYm27Us9o1afYX9abDb3dmeuTWXkNjLhc=;
        b=BcEipB21piarvN89MrxacBv2tEadvjO/tWnsW5vHvKq7z11RyuH63e2yeqbXK0A8EP
         CAjO9M6ruezHBWFtU3HxIBlZPCTLUfVhE8BdXgEivo1o7u+FU+pQTftSbRORuCEuWHzH
         1wONLLoDJvxzAVrvfxzj7fyU+TQUm9FgI7Dk9eMbkyQh+PFWCVrauS5xSv50ALcmMQVn
         mZsMV9OiA7B8ept0Bodr/ChPvgd04L7cKN7wapxGth7pp44q/wygIir0oj2BL0yqbG4T
         MYjxRXNifm3s2nYiaa8aOC1LBbFayZAvZ9kev0kHCNDz0vqk7TYbskddfP63tojMh16I
         4uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705674; x=1742310474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbpJbTnNw0bYm27Us9o1afYX9abDb3dmeuTWXkNjLhc=;
        b=qEiIjxV8YfqC6ZWdYadL5z0a0TstBplGY+m4z8lnDIx3PcfAqM1N+COFCtdPtoK8ld
         DWebZTLS1uDEamZ82Ja0F+BQxoBmfr7vVIUl7GKu8MQsggWA52f6iu2hFICtGFsVPN0P
         AAKwihWfRxCW5JMswftkhtQxaQdwmux5eWKonrTSKttTzoygoOLTSO3zNccCxzS7sSYi
         Le67vSOVSKyrTfsKbNng4yAkNJ8kGd+hZXbTRZqu1p2zIOuNFz42wn8GA9A8hbsqEebK
         5EqbS3/HNc0N3ZSHGbO1w4h128uDEZT+E+qyGkNm3vmkfz5gf3pwxhMXh59YlhiGN7wd
         /qog==
X-Forwarded-Encrypted: i=1; AJvYcCWjzyNv5MQcFhAJQvP+rckIr2ltdeFiM77yQ+MnsAKG+WfwaeDlPiLPlrjQ7KpAxKeOJEu3VTwOM2Wfye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkiZfB+WbPgHn+nMvJ7bHDOynxn868USvVcYhXZ3lu+iZVVxL
	UkdfkxY/II10/FYt7vXmsXn5m9WpnqcMbI2cWrQ8XdWjhRqzQLo2
X-Gm-Gg: ASbGncsTvFDy+24hSxWcVxKBlNOoP/8VWP6twTBVXZ5jcjYVuhIH3LUm2oSqxcY5P8F
	Wxno6Vv0LJ5x8uNkk+D/SmooXzeN78S4wpGGCwV7m4JwdP0uPEWpLrVaD5gjo7LfJMn0Sl5gA5n
	69mvVdZgIeYHHBt/W66Tkgsrf4h5HHt3UZ8OPt4+jHNZdjFFEj11LTmBUJk6UnsvAnHSXgXXFpg
	W8jaOPE00LrTVEPjZCaJz56TMNHFJGBJsm658c360rO8XfFFCOMHTaIIfq1yoMuBiAPJbu73oTJ
	XpdHupl+AoARdKsbGsEJFegl0Y88nMByh0d1w74434nKTFNTX9pnmQ==
X-Google-Smtp-Source: AGHT+IGwkwEG/QcQLaLWJox96XTHbaBrObBrPZYfHlCqnw+mVhxDSEVw6spQ85WeJ14cOrG1y1wgkg==
X-Received: by 2002:a17:907:c91f:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ac252a88554mr1330770466b.19.1741705673353;
        Tue, 11 Mar 2025 08:07:53 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac27bd0ea5asm560974966b.4.2025.03.11.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:07:52 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/hweight: Fix and improve __arch_hweight{32,64}() assembly
Date: Tue, 11 Mar 2025 16:07:28 +0100
Message-ID: <20250311150745.4492-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
instruction from being scheduled before the frame pointer gets set
up by the containing function. This unconstrained scheduling might
cause objtool to print a "call without frame pointer save/setup"
warning. Current versions of compilers don't seem to trigger this
condition, but without this constraint there's nothing to prevent
the compiler from scheduling the insn in front of frame creation.

b) Use asm_inline to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

c) Use named operands in inline asm.

bloat-o-meter reports slight reduction of the code size
for x86_64 defconfig object file, compiled with gcc-14.2:

add/remove: 6/12 grow/shrink: 59/50 up/down: 3389/-3560 (-171)
Total: Before=22734393, After=22734222, chg -0.00%

where 29 instances of code blocks involving POPCNT now gets inlined,
resulting in the removal of several functions:

format_is_yuv_semiplanar.part.isra            41       -     -41
cdclk_divider                                 69       -     -69
intel_joiner_adjust_timings                  140       -    -140
nl80211_send_wowlan_tcp_caps                 369       -    -369
nl80211_send_iftype_data                     579       -    -579
__do_sys_pidfd_send_signal                   809       -    -809

One noticeable change is:

pcpu_page_first_chunk                       1075    1060     -15

Where the compiler now inlines 4 more instances of POPCNT insns,
but still manages to compile to a function with smaller code size.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: - Expand ASM_CALL_CONSTRANT commit message to mention that
      current compilers don't schedule insn before freame creation.
    - Use bloat-o-meter to assess code size changes
---
 arch/x86/include/asm/arch_hweight.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..20b0633744e4 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,10 +16,10 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
-
+	asm_inline (ALTERNATIVE("call __sw_hweight32",
+				"popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "="REG_OUT (res), ASM_CALL_CONSTRAINT
+			 : [val] REG_IN (w));
 	return res;
 }
 
@@ -44,10 +44,10 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
-
+	asm_inline (ALTERNATIVE("call __sw_hweight64",
+				"popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "="REG_OUT (res), ASM_CALL_CONSTRAINT
+			 : [val] REG_IN (w));
 	return res;
 }
 #endif /* CONFIG_X86_32 */
-- 
2.42.0


