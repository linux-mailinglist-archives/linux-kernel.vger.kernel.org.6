Return-Path: <linux-kernel+bounces-534602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23EEA468F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A593A171178
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C423CEE5;
	Wed, 26 Feb 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RErttnN9"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319E23A564
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593175; cv=none; b=oWZ7f8RapSjih/RHEhgZRpIrUrOFW2IyQy547GLIBrfeg5znfCdXWHtyzTRheU3BLDXFfHGHhsN88NCwJ6KBpzSNmU5nJEZC39BXMnttXHsvnR/OVst+ATMAZ75NdARWBjQZjIYDS9as1ST8LVgvjOOYVp7FrbtyR6Lcz9I9vW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593175; c=relaxed/simple;
	bh=gbeR1LC6epTxL5hjM57IzLXNWDQ+GaAp9Yh449sHR1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1x5E1E3nwHIlqDaLoNZP8q4OaSQdrKJ2w2UICAU36OYAzSamF5BhrnkKRsaXjA+7syYhPKwRnFQ175wCgXpH4WpRknvwuQLyBVOmV9rgegsp0BRrhyEieR1F8kHKR5t33YjKjS9J5fTG0Ko0VnXJTOEVrDsM6JPMscdcJAxoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RErttnN9; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f6b65c89c4so21317eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593172; x=1741197972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib/up2lq4vie8y203Us1LjVuEcmMH4a7XcIoSxmd8Ww=;
        b=RErttnN9u742rYFY4uL2Lh61sCFEb8ipMca0FsN9bi2Ld8bSVw7ReIVjPXG3K3mJUB
         U7Qo32BxqmEOAdOcacMeYftfNm3UapzHoO1irInnwni8KUqvoPAazigdCVpgJ9HJagvS
         DHlH/l5COHtL5+Q4//Lp1xr0O7gI+f8JwWPy6FxpCGhB5QcD8vBm4b2Q2O5rD7j5V5rz
         +J83DIs4Ijj0JLrL+dBxWplDXVeiE08kzy43l8uwT0bhfJfnXuiZ085tWB2U3JDTJorw
         KPTol96p6ILrFsMhMSrKJl7jjp2dPXyUWpi0o865/FtYtw49DyF9i+q+1cyl1SEIi4Z0
         Hwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593172; x=1741197972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib/up2lq4vie8y203Us1LjVuEcmMH4a7XcIoSxmd8Ww=;
        b=lpQ/niTzOuUAxFEidKq1bpW4PjOv4KyB5qwtuCyhI4Ge/7VAfC0dX/8syNKZZGFDTK
         aWuTM96+w9ijz5Txrwg01kZgOfpcn6dN3RDQZsNFJAl+EHQrMpoEeDe/NPkXUaXrnWqB
         419MGpWYvXxtIFeLAr/Rtb05ydPwEzasdL6KdQqCyXgahLDiN/Z58UrPzh1pstbfPJvQ
         NqKBMTlTpRtOYZiFCNNg2oS97n3bM8fRq89MsXFbkW4lCrpefgoYB4qtrv2Oy73KdrJd
         iXVJRIR1Q1hgfdb0GkiDtJXEP+2oRaz73pUtpidS1wEDRH+4vwyTbCbE5fPp+cQhPldY
         xOdA==
X-Gm-Message-State: AOJu0Yze+VBYiEY5PNmavwUbp+ZZaUsYgqnim5WjyaS/KtOATm388Lp6
	GenTKsxZ3N/pvuaV8IGMyh9c170/V4CUr+X5exgNOldYHI8b+GG112Is
X-Gm-Gg: ASbGncuHPmEbZf8AnSEcadINnlTp6GXO2LgFsOr3Tl4LmZiwTeHa+OP+uFBG0JomBKl
	IxS4IEclYB+80XuDamZoHlobaT11l/fbnz0F/fuETLiQ0VEVIQsDVdLzODGh1gA5zolN2caELZb
	6QFCB1eTnbW26bwGQfLLQLGZKUrzfurMDbfYkX7SObj1TRJ61YaKl11u769JTJGeACD9I/rP1wx
	S2BB8RjKgOKGRRB85jzWhufyqC8vyRcqE99UVOme4X1ryU/loM0B+AOz+d6oaw1T8vSKSs0+ywF
	tmEQsSw=
X-Google-Smtp-Source: AGHT+IEEw2uHIFBgv6fuSgOXXKvyHfckRf/gCuwJonZJVz2UKrz+YgfxDShvuBLOs6wsHI4meNd+hA==
X-Received: by 2002:a05:6808:2105:b0:3f4:af3:74c0 with SMTP id 5614622812f47-3f540fbdf5fmr5020591b6e.29.1740593172172;
        Wed, 26 Feb 2025 10:06:12 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:06:11 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 11/11] x86/smp: Move this_cpu_off to percpu hot section
Date: Wed, 26 Feb 2025 13:05:30 -0500
Message-ID: <20250226180531.1242429-12-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h  | 2 +-
 arch/x86/kernel/setup_percpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e347c6656ce8..f29c85a0abf4 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -589,7 +589,7 @@ do {									\
 #include <asm-generic/percpu.h>
 
 /* We can use this directly for local CPU (faster). */
-DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 175afc3ffb12..bfa48e7a32a2 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,7 +26,7 @@
 DEFINE_PER_CPU_CACHE_HOT(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
 unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
-- 
2.48.1


