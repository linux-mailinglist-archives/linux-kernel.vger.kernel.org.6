Return-Path: <linux-kernel+bounces-561292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7042BA60FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC74F3BCD2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA41FCF65;
	Fri, 14 Mar 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXpoRSjm"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119D2AF1D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951260; cv=none; b=p6YkeZu/DgygZEDL2HKtsgI2saTLjIFmWdtCdyudhnOrseA7SA5Id8FXyvc5IfltpnZtkI6DwUqIbqf/Cm7ZppyxcDwHrCGlCO6OJ3dRetWhPhCfb7Dzy1+dJDinxJKae5MzHhY7vlgNBiqbodhotSEoH9DmcCwD46se9QfGXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951260; c=relaxed/simple;
	bh=PbKEiZZrya5u0kEWI0KvWCm/gY3yi2gUg/KtP7UnA+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YexAT1cBv8FsZ7LzdFsz4eN6o8L6GU9fYYcrbExFXKQ/EL/C/sLrZ5PmATaPEn4jjqu1CkgRqW1/JqNNZi8i5WH2NAphSUCv9Qb1bj4CFIMFSvgYDNoXpHRWwpt3jRp+uhBBdrlo4GLjgLFFcMzMET727pb4oFnAE/JNuLNlsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXpoRSjm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac29fd22163so335445666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741951256; x=1742556056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MHqAOA2ezq19lN9YnaZDowuCsrifMXNPvNzaiFAKLs=;
        b=aXpoRSjmEQB58Vd/0Ef0va1YXgPN3OoLVIMGp1gUFsrNwoW/XTzxJ7p5t4J/9CxxGC
         xjMTHAg3x/RbSPOB32mIIPTXo0T0m4/dRisK1OlfHN2uJojmfJ1WYAIBuBVBhWKrhwvD
         byuyngPX5Hjy1Cm4DRKtA/5RhREfckJWn7XBsSkmSIlWQ3nc6zbSAOrYICRK8aHUsuio
         Ud63QI2W9WrAn/rYeQFDlTotULzDoWNrQSbCkdFaMKkmvDka7IVbEsKyNM//DK7y9DjW
         xrwabqVKrvLRunfieAofQHhoSWRNtCQOH+D1F4nlB4kFVn5DYpJtPLMtPfrQaXB5bIxf
         nJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741951256; x=1742556056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MHqAOA2ezq19lN9YnaZDowuCsrifMXNPvNzaiFAKLs=;
        b=sm2OmEAa/R8ABfw4hdiryZSLbcrucQTDYu9bCItqdXFh3Z3hO3xAdcwmx6Nyu7AChJ
         J9qO1uQehWtXPYWoOIb2qgZlHufoaJ8zmG1T/MvEXuGLo+Zpyjfl1MWDW3Q/hHP1lgGd
         5kv8v6nsNPIn+zdvK6pyL96i15q9E/62tilDHLrkBqPwhjSOOiIm25LflyMwtgW1TBkl
         uK+xDdN/vJ+OVP08SdTyDAoWUvUcJNuvoqNiftODXWKkqqHNi3cmarZ/jT3BsITYpTds
         ygYieqREz/LhjmSHYRESM6oS+aXx1ouvIgPu2S4/dn8ows7hygp7tH/yg6/PE+ce74s5
         E6GA==
X-Forwarded-Encrypted: i=1; AJvYcCUycG4uVPpp3SUcUeiehjk3FmYEPP/Q0h+BEcE/9RLmxrxih1u6uQwtH2P/HTXumL+MHXHs2lYdp5WGdd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFk3eZuug+c77t9/71qGBLNpW6KU7F68/g7SLjmlwphlMjUy4E
	9INVYAzWt4buMCG0ghXd8NWYJ2lW1PV8J5AGN8axXwhbnhkFgRCV
X-Gm-Gg: ASbGnctH08u9Tt2QJjzV7ibiKjF8mc31kFLORagT4NVdtmommd69WhcWkFv0eoWkkjc
	5Y+mOzFdpHeC0YAeooYjIRvn52tXYxN59/TTjb2YzJVsVXEFc+8w5uVKJ+S/tVgjOS2TuIo9n+j
	305TFkDGe0/hCeELDUfcc/W8CsF6hbfr0jCODyf4E5pQYLSIzw+Fkb/r/avZlFq6NYijJSr84iy
	Z3rhpa80eXYHVpwwbZ735fAgjik7bv9FnAUihWXNxFyPI5RO/grkAwJU10TkL5ghPvFbP3z4/rR
	ye+zxAipgEat0a8pUY6+ODZlqTZz54jh1kHC
X-Google-Smtp-Source: AGHT+IEe6egjeWIJz7Bg7NprfgFFpaAc6EqeXueOnOVvLACfkgrgCUXGQQsosgYEf5eISV+MndU/Mw==
X-Received: by 2002:a17:907:6ea9:b0:abf:5c3e:e5ac with SMTP id a640c23a62f3a-ac3301df4a2mr268511266b.11.1741951256348;
        Fri, 14 Mar 2025 04:20:56 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeb24sm212616566b.9.2025.03.14.04.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:20:55 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm:  Use asm_inline() instead of asm() in rdtsc_ordered()
Date: Fri, 14 Mar 2025 12:20:54 +0100
Message-ID: <20250314112110.740723-1-ubizjak@gmail.com>
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
(x86_64 defconfig, gcc-14.2.1):

  add/remove: 0/0 grow/shrink: 1/0 up/down: 23/0 (23)

	Function                         old     new   delta
	----------------------------------------------------
	delay_tsc                        144     167     +23

  Total: Before=21423610, After=21423633, chg +0.00%

The code size increase is due to the compiler inlining rdtsc_ordered()
several times in delay_tsc().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/msr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 001853541f1e..67c9573a803e 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -214,7 +214,7 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * Thus, use the preferred barrier on the respective CPU, aiming for
 	 * RDTSCP as the default.
 	 */
-	asm volatile(ALTERNATIVE_2("rdtsc",
+	asm_inline volatile(ALTERNATIVE_2("rdtsc",
 				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
 				   "rdtscp", X86_FEATURE_RDTSCP)
 			: EAX_EDX_RET(val, low, high)
-- 
2.48.1


