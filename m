Return-Path: <linux-kernel+bounces-575801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2EA70753
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE57188552B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BB25FA36;
	Tue, 25 Mar 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIp1gytK"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407F25A2CF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921349; cv=none; b=qCg3fuHkkcIlxuj9vD+RT6YmwRDCvEgpS+vE8LHoBmuZmfkmIgAQEdJapxLVMuHZ2Oo9Gw6oC0oXeBoMjPwpBjpJDqzAzlBIOyAXrfUHTRGavs331YN23EXZx1UDHCqO/UM3xW7/m7Fln1s27OKJ9IYz7N28v5HUUOnUiDOcikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921349; c=relaxed/simple;
	bh=otdSQONs1zyCwaYeevxU7yUtzAILfEcnRX32VyUfths=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaZyKmozFtPVpM54+y60W29b/VMFSEIyOcninssKnzSO9SY++LWmB6emG3FKh/QLEcy6ixodEwRpm06LTWKhUr9QRSyInPfInlX2DFB+IpIBnEH9RaZ9CkvRtlcF7WqNzFEYL1HGkbSfppcvLGfEaDfiO+I4aVHbc9hVhDcX95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIp1gytK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so824730166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742921346; x=1743526146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5MacFle/YKCV5z55sK3Ig/SMI0vtQr0/dSkJlcTMMY=;
        b=RIp1gytKLqyk12gOgDOYhsbrbfubQL/B5S2TSeaV48IXsL4sLYP6NzYaB/bFG1iPLY
         mclx09wpwluIAbqKgvyZgshZ4NdizhYhoHEPES8FQ08eZMTHqGj1aZlrz5GNykzj1ZR0
         dWV5CDCcXAQ0gqfb+wLOA6AaegawQDPCWvJ5lxeOFnzk4i+YTzd5VcBqx1XqRasVE00D
         46ULx2kLC41V+soODfQcGgvN0Yq3mX9OfF+B3czKXB1qUn3kdNdSIHzxSvOGM3j8Iwfj
         hHDOeiD7MLoSugszguzJNQ+LOVWh2qILoO7xdZ1odLZGVQBjsCwju3LL9eWM/oyesHQP
         c1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921346; x=1743526146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5MacFle/YKCV5z55sK3Ig/SMI0vtQr0/dSkJlcTMMY=;
        b=dbjIwt3didkY6coZi6ft2mUILbxBy8FtjqV42jrRD1+m8XrMM8ORD0Wb+U1XFB0DZv
         +5l6IueXsW6deugD7DIYDIU0Hy93RuP6RPajw6pKLf7czolOhn+3ojyZ6gOCvwC5qmQm
         bjWx4q4AUfD6IB4ZsVu8tzOlNLOQrgqyIFsbo7QT8KvLThTqXKltxY5wpi83lEFu7P/r
         pFCB4hkIGDouwMRomUoJpzivrUUg8/1qulTxas1agDm0xU+qXBItI5bxV870CLky+Wq/
         EiflaJ48VX4KS8AdXIa9bnbtFu0vQZUwJOBHc2j4NTrn+20GlWf5k/ENfwFCR0wq7Dul
         afFw==
X-Forwarded-Encrypted: i=1; AJvYcCX95xfX20JbiN3UjQ84UlTvZC6Y8lVvVrXLKvGuG86d0un8WhVxXEnnc9BGWlE/xc86lyQkq2XRzqNyfwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsaeN8i9Tm8bsAZuBTeo4aDkv5I1IEQ7QMgSVlYq4r9IznQgp
	MDM0pQDCm0hC+SSVmxvE3ATKRRCx9VcEb8L0o197tLSShQ3UtNBO
X-Gm-Gg: ASbGncvGTY8Aqlkk849za+ADMBJz/rEZXOcCjOjwBSy3jTB7/8F7p86ZVtbnXclp/jM
	i5HmUbSocH4Ty/HcLwsYBbirt+UiqNPYRyRX4cTsZz0/C8O8xzl1VB57xlugBcSCWe66c4H8UMp
	cmG/6qYXpFdaKqZOKTmEmemarrl6h4+2enCYCgiuaqjw/0VldXvqoU3UYflsT1OwHUfmclxe3k+
	DzxUUtinLY8OrEQUeencv++X42PWuY3OpIvyWPp6DcQyrYKpVlHdpMZorxPtW2/m+/WgCfdRPn5
	BKHr+cujiSDII+LKkBt9AdAz/iHXIwjCr2E/9VOYv5131Ca4b+y2iA==
X-Google-Smtp-Source: AGHT+IE5K3jhIPG5icRucxpN3m93VIsWLQmaB3/boVzl3GJSyzKSY3NvY58XQnfLf/FPIn3x/WSCFg==
X-Received: by 2002:a17:907:72c5:b0:ac3:2368:9a12 with SMTP id a640c23a62f3a-ac3f24f6d46mr1768555966b.27.1742921346159;
        Tue, 25 Mar 2025 09:49:06 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm877866566b.31.2025.03.25.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:49:05 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 2/2] x86/hweight: Use POPCNT when available with X86_NATIVE_CPU option
Date: Tue, 25 Mar 2025 17:48:38 +0100
Message-ID: <20250325164854.199420-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250325164854.199420-1-ubizjak@gmail.com>
References: <20250325164854.199420-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emit naked POPCNT instruction when available with X86_NATIVE_CPU
option. The compiler is not bound by ABI when emitting the instruction
without the fallback call to __sw_hweight{32,64}() library function
and has much more freedom to allocate input and output operands,
including memory input operand.

The code size of x86_64 defconfig (with X86_NATIVE_CPU option)
shrinks by 599 bytes:

  add/remove: 0/0 grow/shrink: 45/197 up/down: 843/-1442 (-599)
  Total: Before=22710531, After=22709932, chg -0.00%

The asm changes from e.g.:

	   3bf9c:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi
	   3bfa3:	e8 00 00 00 00       	call   3bfa8 <...>
	   3bfa8:	90                   	nop
	   3bfa9:	90                   	nop

with:

	     34b:	31 c0                	xor    %eax,%eax
	     34d:	f3 48 0f b8 c7       	popcnt %rdi,%rax

in the .altinstr_replacement section

to:

	   3bfdc:	31 c0                	xor    %eax,%eax
	   3bfde:	f3 48 0f b8 05 00 00 	popcnt 0x0(%rip),%rax
	   3bfe5:	00 00

where there is no need for an entry in the .altinstr_replacement
section, shrinking all text sections by 9476 bytes:

	    text           data     bss      dec            hex filename
	27267068        4643047  814852 32724967        1f357e7 vmlinux-old.o
	27257592        4643047  814852 32715491        1f332e3 vmlinux-new.o

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/arch_hweight.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index aa0b3bd309fc..d39710e57531 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -25,13 +25,18 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
+#ifdef __POPCNT__
+	asm_inline (ASM_FORCE_CLR "popcntl %[val], %[cnt]"
+		    : [cnt] "=&r" (res)
+		    : [val] ASM_INPUT_RM (w));
+#else
 	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
 				"call __sw_hweight32",
 				ASM_CLR "popcntl %[val], %[cnt]",
 				X86_FEATURE_POPCNT)
 			 : [cnt] "=a" (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
-
+#endif
 	return res;
 }
 
@@ -56,13 +61,18 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
+#ifdef __POPCNT__
+	asm_inline (ASM_FORCE_CLR "popcntq %[val], %[cnt]"
+		    : [cnt] "=&r" (res)
+		    : [val] ASM_INPUT_RM (w));
+#else
 	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
 				"call __sw_hweight64",
 				ASM_CLR "popcntq %[val], %[cnt]",
 				X86_FEATURE_POPCNT)
 			 : [cnt] "=a" (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
-
+#endif
 	return res;
 }
 #endif /* CONFIG_X86_32 */
-- 
2.42.0


