Return-Path: <linux-kernel+bounces-557715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310FBA5DCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FA93B4740
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA72441A6;
	Wed, 12 Mar 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2s0OuAT"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331423F37C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783135; cv=none; b=bpAzfOaemMyC9neiBEsi9HaUwhL7hKl5gIby6G8+fbdruMovL0p0sm9dvZWLl1C4xKkMWVGQPwqE5luIoqvwPymRulP4hA3BEMevEPlmCDYbqAfKEcCj4EOgKr8Q2/kwZdf++8nNUASR1+arZydHCjPHpeeLYif+9muv/U81vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783135; c=relaxed/simple;
	bh=OfHcO9JZhXwZDjruvnxbdiRZ4GWlhm/tXZ7b85KX+9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHcUGu6KtStRkpiWwEP8C82+dGofOQCOQlIG2/dIAPLKfYc9Y31Nqv6TAr/4gM83OWl0KwLf7nInjjLszMyh2tqG/30Mn+PSOjbo+43iqJWag11W20DJuyUEMGyTfOo7jBHhaTiveVleivh+uI7pUctT4Tf/2L1e79cMT5gRp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2s0OuAT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so8857810a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783132; x=1742387932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw0sogIKoGHWEqTyMEwfwYtaiWMe1RMeD9bIfoB4RU8=;
        b=f2s0OuATh1gu19eL3GnqLH4k35lVHnlcqmEnGjfAypURyDSxLN4YpAbPHXC0Jovjic
         H9e9dlxBl9O4qWKrDRwJVP+6phT5Ez7HfM28ptYC59EUBrbtQFqznyYEHVC7sVUVviVH
         YoT4/KYgEFm76jDc1bBSGIo/WT76mIbKbdD63ImCvlpNSVYjy/pYnjhGi/1Y9ZVx/44p
         wtFSykUey+hPMVt+F9A3NR/4oIMHKyXZIxZ6XUIGxa0pG/YBA1jJmPld7AyEj7G7E41c
         jvrIbj9QgVp8laZ7ErUqZ3/xt7Pjkr6fQqomOAhMlTkPvBsnKXeMfOcI/u2wDtlsgiTU
         trWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783132; x=1742387932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kw0sogIKoGHWEqTyMEwfwYtaiWMe1RMeD9bIfoB4RU8=;
        b=idC4enPDl9s2yUlr72I5PpeuGu70Qfig/t9r69bk2NgNPQ4zd0glBNNDFhFH9C1FI2
         XMfG569hk7X8Lwi11GwnNY7A+cQD1U+I2k9onrFLRO+HsPIsN+bUJJWYJSLexQRHyLR4
         oRDZk/HglT0+LEJu0jppWQYtQbTxl9hxOVnSJAhDSyCfO2IzpLfH1u9vQUZuW1OlEG7q
         2JabiqdZ5OIaQQdb/GHFRbjjjii+mkMkRmt/Cbnamy1+jWn7y0ML6M4qz458lyAyyBVN
         ktbLVnU3dm9Ekj/WDlaPcWkQauTf+na+o0iTvOYHLimy6swcmRszK3NYoLX0pzEzs0hE
         h7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXhJ7RGg0pNQUweMvWAylj7fq8/RZBno6Z/XyMVfIFN9HvjrbzCK0rEJsuJbv6jVCNUV9Rr6ruW7LgKfs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eO9mBlTxTcT2TGRQTMMLKiVCY3Ef4e24wHeftyFq+iEc0bH0
	6haRtEM9bwGyQ+ReLYyUoU2KqvuNOlSh9ZnwwV8NLu4mtSoL/EYm
X-Gm-Gg: ASbGnctoQrW6t9ZvasKg/mrqk/v0tmjY+OQybWvwil2Mwgl4z73wICRsUmmYwV4f6UX
	D6UZxZPETEhVHEzjhgIXTKxTULc367IOEld+nEv01t7Uycqs2uiPbf33PannJ0iVk1NTGvTA2Vl
	JDgG7wmoecPGzUZcmXDoohFq1UJNAoFssyjFjjZjmJi7cS6rbs2OGmo26I5lwNheentfcu1sGyD
	QwGhf/eJDSjErJLRDbh1WrxMwJfhnlBuBx/OJbAKhAB/iiZmS0GKZfWAlrd5KNqVqPltHxuIV5O
	VkIK9ynIwvpqSCWZXj4I8fJGn4TE1VhUB/vHzJjkUOr7imE=
X-Google-Smtp-Source: AGHT+IGE3WocipPyc3gLGfzrTYztXQgdZduJaHBQSJ4U1Cp6WypRS4oz/M3jNSXdp0sOYXaY9eTrmQ==
X-Received: by 2002:a05:6402:2793:b0:5e7:73ad:60a2 with SMTP id 4fb4d7f45d1cf-5e773ad622fmr8755106a12.30.1741783131757;
        Wed, 12 Mar 2025 05:38:51 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f4c3sm10077100a12.14.2025.03.12.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:38:51 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 3/3] x86/hweight: Use asm_inline in inline asm()
Date: Wed, 12 Mar 2025 13:38:45 +0100
Message-ID: <20250312123905.149298-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312123905.149298-1-ubizjak@gmail.com>
References: <20250312123905.149298-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use asm_inline to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

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
v2: Use bloat-o-meter to assess code size changes.
v3: Split patch into three separate patches.
---
 arch/x86/include/asm/arch_hweight.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index f233eb00f41f..b5982b94bdba 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,7 +16,8 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
+	asm_inline (ALTERNATIVE("call __sw_hweight32",
+				"popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
@@ -44,7 +45,8 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
+	asm_inline (ALTERNATIVE("call __sw_hweight64",
+				"popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
-- 
2.48.1


