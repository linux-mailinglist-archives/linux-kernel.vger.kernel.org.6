Return-Path: <linux-kernel+bounces-563743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49406A6477F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E07B16F70C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C2F19CC22;
	Mon, 17 Mar 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+sHhfik"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9912F30
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204031; cv=none; b=j8z40eogSxMv1anewPKa8k3BAmUZ/EpzJn5N07EG9icsNlg3Z14otDAazLIR7k2vPNASN/Y1v+gCBA2ELfCwoFJjwfqr2hf8JYJ0A1+ceSgU4wXs+0EyGgrptbBQkzNU1mOXrq3TAZTXUzHKV8N76NHCDL0FerIxTRC3DvIKZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204031; c=relaxed/simple;
	bh=ZjpX/FK1mAT9V4goVKLc77ntmvHtlB8pcKFoEoKB9e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhMEc+j0womsyrOrJb35/z49fhIB2a+jXwu0eP0Z/hogZVnpp9Y0YlViT5wevRp5Y9GoGdSZStiMUFUi2cJhwZ+Gk8R7yb9+I5lUnvsHvoH36PeQfBcZBwABU7UCSabDlEy1XwJ1hwyEyQ9Xn53tWwgniYD5MxLwPAQDQkrK8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+sHhfik; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so937866166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742204028; x=1742808828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpVmZE136+Zxm0BS8hIPezjxmGrEUv2QEDGs5qKh7PA=;
        b=M+sHhfikkIAvjr1npQSSRsAE+NmkA3FrtxNu+rxaGs2SgsvfOBabWWRlFGFBNlDEyo
         fap2mrPm5eIyEG+6cD5ZvgqrYH0p8C9dlCQ3JUBSV65tCQMUEW+2oPKNpE0tTC/T55j+
         PR74EwKc5OL45+WoXFZ5rLsUml9pRtB3d7VqNV6FyQwYi4maOKrGr/A/60kI94D7T4Ny
         lNKlddqmO1RUksEjbHnQASgMDWt2ZbGdVt9MN2dvHY26WtVL+xJh+3szB8Iz4yNwQocM
         +H7d3btMh+KrQHYw0aZn1ahcUmPl+jAWkfqyYrd5HTeswMYTOenUgt3VgPzLhvkbV4jd
         0Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742204028; x=1742808828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpVmZE136+Zxm0BS8hIPezjxmGrEUv2QEDGs5qKh7PA=;
        b=j2wtOCwIZhi9OXFd7mSNp4Gu5DtBhoHxbUUpRyKnnR74286xK2FhO4LkdNlqhP9kl6
         ZLMUqx3ORwNBl9calQtd9OU4f77SRGpOO2xcgBullKSVlnHrsT5Y5GHuFND6IikW0WZx
         HrpMhT5WJLIk9vihG6ybAZVx3Cfd0Xn4Oq9bFto+Ne0g5AgkbPHtkWw1UEweMW+juayo
         UQOWcH0QePnpRRv3l/PDKC5h4/mVaB+w29PkggEMUuNNl/+w0WxLTFKkyldXCJflDdAo
         Z/TIlcQ0kE7lJqul/t/v0fwR3srTuVXZOPAe0xCEf2c9OIx1uSHKU8tKk84OZH8pLjpZ
         8VlA==
X-Forwarded-Encrypted: i=1; AJvYcCVSy9xPQsXDN2TMYjDhDy6P9swbxrR5mdASkFdnFO0p0MyHZPxhWvfqdo7qvvyNkb/L7ljDX8vVE8vrFo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6casraz3/Ip1PkwWBus0cD2fphix7MY3nOv9lyIwdBM2U3bQ8
	W5U6W1L65R/p8gxhFizrbVvaZLV/llDWqHjqSyYmcInPPJXHgxj7
X-Gm-Gg: ASbGncu6QCX8cbXFdYPtPUopsDa6hX6WhgyvhsixXa7AfLEV5U6Kw3yckIIA3qGVSrD
	r9kDgFYF+rv/0c2UjwLSaetsQeW35XoYG7UnRTq0ddydfFsiJYTOBstwJESJp7TCCUXOP9CGyDV
	abF0FwZMaI9kCyPmWh3kej56ikGgsqpfqJvVrGQwo+NEFSjj9kqlYiC3zaZdV62wFrmASaA+Yw3
	QmLw104FRIIV5xrGHfO9QLBn22IXZ/BSBcvS/Lgj1ixSjQ4LZ+uTGX2hc591JEU+Bi63EDwtjB1
	dSnkDZZa9sdrg1nMENMaUcDFkKi6eBiAos8NDIpkXiP8GXI=
X-Google-Smtp-Source: AGHT+IHYKRx7NHrqTP+ROvZ68L8dJjMyFHgWRrv3ufsMT9kR9F0OUK6XAqMeXz7hIq/Ex7WWVhz//g==
X-Received: by 2002:a17:906:730b:b0:aa6:b63a:4521 with SMTP id a640c23a62f3a-ac33018ef75mr1171219066b.15.1742204028088;
        Mon, 17 Mar 2025 02:33:48 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6083sm627552666b.182.2025.03.17.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:33:47 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/fpu: Rewrite XSTATE_{XSAVE,XRESTORE} macros as static inline functions
Date: Mon, 17 Mar 2025 10:28:38 +0100
Message-ID: <20250317093408.107282-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite XSTATE_{XSAVE,XRESTORE} macros as static inline functions
in order to use asm goto to optimize exception handling.

The code that used XSTATE_XSAVE improves from:

   3f1fe:	49 0f ae 64 24 40    	xsave64 0x40(%r12)
   3f204:	31 ed                	xor    %ebp,%ebp
   3f206:	85 ed                	test   %ebp,%ebp
   3f208:	75 37                	jne    3f241 <...>

to just:

   3f201:	48 0f ae 65 40       	xsave64 0x40(%rbp)

because there is no need to set and test temporary result
variable anymore.

bloat-o-meter reports a small code size improvement
(x86_64 defconfig, gcc-14.2.1):

	add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-25 (-25)

	Function                             old     new   delta
	--------------------------------------------------------
	save_fpregs_to_fpstate               141     135      -6
	__fpu_restore_sig                   1448    1429     -19

	Total: Before=22809695, After=22809670, chg -0.00%

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/fpu/xstate.h | 54 ++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 1418423bc4c9..c8e31005567a 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -131,32 +131,38 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
  *
  * Use XSAVE as a fallback.
  */
-#define XSTATE_XSAVE(st, lmask, hmask, err)				\
-	asm volatile("1: " ALTERNATIVE_3(XSAVE,				\
-				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
-				   XSAVEC,   X86_FEATURE_XSAVEC,	\
-				   XSAVES,   X86_FEATURE_XSAVES)	\
-		     "\n\t"						\
-		     "xor %[err], %[err]\n"				\
-		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
-		     : [err] "=r" (err)					\
-		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
-		     : "memory")
+static __always_inline int __xstate_xsave(struct xregs_state *st,
+					  u32 lmask, u32 hmask)
+{
+	asm goto("1: " ALTERNATIVE_3(XSAVE,
+				     XSAVEOPT, X86_FEATURE_XSAVEOPT,
+				     XSAVEC,   X86_FEATURE_XSAVEC,
+				     XSAVES,   X86_FEATURE_XSAVES)
+		     _ASM_EXTABLE(1b, %l[fault])
+		     :
+		     : [xa] "m" (*st), "a" (lmask), "d" (hmask)
+		     : "memory"
+		     : fault);
+	return 0;
+fault:
+	return -EFAULT;
+}
 
 /*
  * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
  * XSAVE area format.
  */
-#define XSTATE_XRESTORE(st, lmask, hmask)				\
-	asm volatile("1: " ALTERNATIVE(XRSTOR,				\
-				 XRSTORS, X86_FEATURE_XSAVES)		\
-		     "\n"						\
-		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FPU_RESTORE)	\
-		     :							\
-		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
-		     : "memory")
+static __always_inline void __xstate_xrstor(struct xregs_state *st,
+					    u32 lmask, u32 hmask)
+{
+	asm volatile("1: " ALTERNATIVE(XRSTOR,
+				       XRSTORS, X86_FEATURE_XSAVES)
+		     "3:\n"
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FPU_RESTORE)
+		     :
+		     : [xa] "m" (*st), "a" (lmask), "d" (hmask)
+		     : "memory");
+}
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
 extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
@@ -208,7 +214,7 @@ static inline void os_xsave(struct fpstate *fpstate)
 	WARN_ON_FPU(!alternatives_patched);
 	xfd_validate_state(fpstate, mask, false);
 
-	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
+	err = __xstate_xsave(&fpstate->regs.xsave, lmask, hmask);
 
 	/* We should never fault when copying to a kernel buffer: */
 	WARN_ON_FPU(err);
@@ -225,7 +231,7 @@ static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
 	u32 hmask = mask >> 32;
 
 	xfd_validate_state(fpstate, mask, true);
-	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+	__xstate_xrstor(&fpstate->regs.xsave, lmask, hmask);
 }
 
 /* Restore of supervisor state. Does not require XFD */
@@ -235,7 +241,7 @@ static inline void os_xrstor_supervisor(struct fpstate *fpstate)
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 
-	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+	__xstate_xrstor(&fpstate->regs.xsave, lmask, hmask);
 }
 
 /*
-- 
2.48.1


