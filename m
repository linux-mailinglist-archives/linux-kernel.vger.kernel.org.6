Return-Path: <linux-kernel+bounces-560917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0EA60AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535B13A3BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF6198845;
	Fri, 14 Mar 2025 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPezrNba"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5408B194137
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940082; cv=none; b=m4s2S1kWvbEVv8Wk8O1u4hiBZKfmHbx+ZxDOB0kh0I1uziXL1ogUFVyw+c/+L3YBPHFS/Wc3W6nyR/xfC2xB3BBig+NM9R1PhibPxuKUbHTW93UhJ+fMUEwQ+yuha0Nz39APi/9ewuf9K/lckRH2GgM4Z1bfVz5AMDcKJdgyv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940082; c=relaxed/simple;
	bh=O9LQG/lpPnOhkT+jYoKuvDbee+y6Sz3wefUhFAgS2yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHPUqMnFClm3Oh5pIYTGZOm+b8Jq9IO6P2hSLSBpnKa1PzZzB0wVCx6rSddoY3pJkwtV0d+hbTa1q/ayElkqVPXKA4CFq2RWpV4cxnXQnjnvlAcRJlwSNsKOZAm+CnCGOL01axDnHgLuwHW/N1qhnHcCiSHFG/rk16fLBDV01Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPezrNba; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso2306124a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741940079; x=1742544879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4jL5xAzxvHMCk7fi6TBU/sDX0DbhcH+sqMw7FTW5ldM=;
        b=VPezrNbaU/S1mOE6z1Ihr/mpoULdSL9kpiY0hkF8dW1GNZ8Gt/4r8Rz4ImjOTmHf2F
         AD3YuMzzinlkKGmdU12+PtFX4U6x330X9XE0uIloVHeb/9HkUECUaJK/OYcZw+xYkukz
         JS/btE/jkwpt3hDeUfWQD3JuzffKv78EJgJLekTHtGx1GQUZwzV8CjOAUMWxVYNS1o4w
         2Spqb0/+i2xnQ7uRnjCTjaQdrWfYDdFzzP1/XFGVDcY8yM2PLnKcNo/V8VD3axYhZ65L
         5lZtFel+CfV+BvxFpG6WoXydGXsKBVdL23vWhogmLcky/+b1LKrJSXFVAwD9cB3JFfKz
         ALnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940079; x=1742544879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jL5xAzxvHMCk7fi6TBU/sDX0DbhcH+sqMw7FTW5ldM=;
        b=qioUclEm6dmztm7paH/yHdNvsP+Do2AhX0ZxMRP66HPC2NFidwNdSlV+0rQrnoGlVU
         bFrvXHWk6DhLY7jwwQ8LFZCE7oHUM6caqB3FMnvnpSxyt7mG750+z9JGM8HQyqAf6QYJ
         I5aXV4vcTv+Mp/wk16oc4xylpx2PMy1Kfvj4r8kyI5YlCjsnFh3RpyKekXbr8p0/yEg2
         Zbr+4XUUo9Sgrf22BTzj42Bwev7XCDcezVPguJfViEtrly9p0cLdlqmGiMYcm/kTHRzt
         WYMv8zkEu4mGOryRocedN8NcgtDw4K/as4x0/1Mwo7G2CTrtHwcSej0EEu9p2xC0Hx18
         ha9A==
X-Forwarded-Encrypted: i=1; AJvYcCUt6GjKF1xWq2r3/kyPJI5hWXlM5O6o2OrPHn0cWeGfYdLOxfIOc2ErlIS5cTc2pK5yrlYSrNa3Hc1KzEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OyRKge/uUDbqFjhHooIs4vnLm6RiM6wFN1UUYxhwcoWgXp8c
	tYTDt73DUVFFXqppRNBrDt5qOaz+aocbHpM87BBD3Hz7IA3+dn2pTor0VXGe
X-Gm-Gg: ASbGncv4wTiI5EUvWuVWa4oZryC1gJOajG4iasnIeVkeFSyp5kZkxg1ELcSojEPEI1Q
	b2+WzCDK+0/QO+9iVEk2b0SmDh5MbRapwHiuPzkQ6a1+OmLXOQfcHcOzG6vZiSIgx3DT5MqKb+S
	8tfqyPlXXtP0MuZfX+zayRoazdwQTpxHD5IQ0A5QRGzqCRZrdi7r3avg4KXZr7OcrupfaGd5p4V
	XzU8K1WrzTq7V8z1n3T179QEi1xCV62AXIAnsa0bvmLmLG0EWmZQQl/kDBKw6kjsrke2Q1Qlnqm
	GwlUmTMlaxam05DV9lI1Kh07mgUQ0srx4VAdKqL+SakX3gE=
X-Google-Smtp-Source: AGHT+IH2uHvvaFjRLgPzz/axbDjRTaASMSL04mCeERLdmEA2nw9uAOEg7/99W5lF+t00yYVFiSpFOQ==
X-Received: by 2002:a05:6402:1ed3:b0:5e7:f707:d7c4 with SMTP id 4fb4d7f45d1cf-5e8a0c0d331mr1485652a12.31.1741940078358;
        Fri, 14 Mar 2025 01:14:38 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe26bsm1651871a12.72.2025.03.14.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:14:37 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm: Use alternative_input() in amd_clear_divider()
Date: Fri, 14 Mar 2025 09:14:38 +0100
Message-ID: <20250314081453.565859-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use higher-level API to declare assembly with alternatives.

bloat-o-meter reports no code size changes.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/processor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5aff26..b4b5aa46f68b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -707,8 +707,9 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
  */
 static __always_inline void amd_clear_divider(void)
 {
-	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
-		     :: "a" (0), "d" (0), "r" (1));
+	alternative_input("", "div %[den]",
+			  X86_BUG_DIV0,
+			  "a" (0), "d" (0), [den] "r" (1));
 }
 
 extern void amd_check_microcode(void);
-- 
2.48.1


