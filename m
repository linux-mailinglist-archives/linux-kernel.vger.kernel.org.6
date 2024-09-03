Return-Path: <linux-kernel+bounces-312864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA97969C91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A38D1F26311
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9811B9857;
	Tue,  3 Sep 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0gTPsc/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007519F41F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364657; cv=none; b=blJgxhJws/OmU9fZtRSMMIGVQkCGYs/XwKoxMsq+T7eaVW6EFXYra1E+7YLLU488BRS7/iZrvS1AzbGEnE0NVQ3KEQdUzlyaU2JPZk43WznhQB1KawHTPGXMzur7w59EQ9zjlzGCD5aoHJJ18VgPdxiBECKS/VPDej5eX+6silQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364657; c=relaxed/simple;
	bh=2wo2Yh+NO8FpblC+WCdH1sZQkVuuldrC6DanOfnuIow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeTWyyckEW0+ry1aShby4Oj7jfgC2QAJGYgZFCCtsLPUOzPvyy7cYOSsCIGLNZVk+IZfTkFRXUnJOOYJDk3mopx9UcS5ubHVWpsssE7gQ+MojcSwnDrdoUGuiMzZff6b5AjSanDOMblxTNspbcFh+OXRWRF2T2Ld4O4xoomWijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0gTPsc/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so28533195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725364654; x=1725969454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOWmr1R5h0Gb2a9habh8uARgJu+ANhS3vHaU6Q0Zgt8=;
        b=O0gTPsc/PbbUpUS5HcbWWmaibqNPM7RFEQJqgimvTr9otEGkQ7ysQSfzrWufNUIogH
         1fp5DM5K0/JYhfsj2c5S0rGQ7iAFnLTuo9lpNMG4riCRPp0wrAyQS2KKQ2pvdXBtcs2p
         c+7oQrAHHnHAeSPiDG3HBJG2lRtw776hiWXfRB2usBAFFVUCMIBXwbsIKA2wRKSd8wIS
         mKONy7v4eldDke0PxNqe9HJSv11rKXa/1ebH2k9Cd5qxvckL1Ag2bKZ2r4JFZOAzu6cM
         vx2h/lIBIzGNZ/2s1FmwzJzhT0CjzBmyBKGkapncU1Ep+JBcoTK4mFzSqIF0nqpWGRqL
         ySkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364654; x=1725969454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOWmr1R5h0Gb2a9habh8uARgJu+ANhS3vHaU6Q0Zgt8=;
        b=pZKksCEuBmq9xMw0xuhhZylpO5UYRF37SFZtKWmcu677eP2NoMLdpAMuMmg87PZhJv
         CX3AlQZB/NfvNNUsr8/AKnHxjDc7URWjqrhSsnHqmNaiJKTc+IyAuMIgjLqgoozoVI4+
         4hIMyYmXR8qmgrSkrCSwL81EB7m6dez0ysL8CvTslCFO6712Z4ZJ1cDY/fZ5K87Fc6MM
         t8VluGry10JD0CVYiQHxVNOiF5ceaVIxxSa2DIkriikcSfLmfncqqYGXr21vqeRdugeE
         jYwfSdoWGJeinfPOA13TwtwOMpIMkdMuDefMYdj+AAHum0UK1AyQpdK/4rZhW4YDhBD4
         3cvw==
X-Forwarded-Encrypted: i=1; AJvYcCXkdusmSQhvi4CRGUcWF3YTvTqttl3VyCunM+AVm1CmjlWSH+sgYxXTWkFWmVlgG3M7UKMPJ6+Cn/FeJqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYs71J+URqZJqY4VSXBKTsqDi+inxP9CJPUazRnozVo+HC4dUj
	RXrT9ZLbgjn5Z9ka/a8e56vxjaf9KIWBFIGFb2LJpktg5Iz4zQcb
X-Google-Smtp-Source: AGHT+IHoV/Xibb6pGUjSJ33YXQqsHWG+oKac8y5b0/jIrLojV54vayuBi+7JUi7jDf3QEn317/SYMA==
X-Received: by 2002:adf:ec89:0:b0:374:ca4f:bd70 with SMTP id ffacd0b85a97d-374ca4fbe7fmr3579962f8f.53.1725364653008;
        Tue, 03 Sep 2024 04:57:33 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df7c5bsm168842075e9.23.2024.09.03.04.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 04:57:32 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/percpu: Unify __pcpu_op{1,2}_N() macros to __pcpu_op_N()
Date: Tue,  3 Sep 2024 13:57:16 +0200
Message-ID: <20240903115730.91423-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify __pcpu_op1_N() and __pcpu_op2_N() macros to __pcpu_op_N()
by applying the macro only to asm mnemonic, not to the mnemonic
plus its arguments.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..cd05f6626792 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -128,15 +128,10 @@
 #define __pcpu_cast_4(val)	((u32)(((unsigned long) val) & 0xffffffff))
 #define __pcpu_cast_8(val)	((u64)(val))
 
-#define __pcpu_op1_1(op, dst)	op "b " dst
-#define __pcpu_op1_2(op, dst)	op "w " dst
-#define __pcpu_op1_4(op, dst)	op "l " dst
-#define __pcpu_op1_8(op, dst)	op "q " dst
-
-#define __pcpu_op2_1(op, src, dst) op "b " src ", " dst
-#define __pcpu_op2_2(op, src, dst) op "w " src ", " dst
-#define __pcpu_op2_4(op, src, dst) op "l " src ", " dst
-#define __pcpu_op2_8(op, src, dst) op "q " src ", " dst
+#define __pcpu_op_1(op)		op "b "
+#define __pcpu_op_2(op)		op "w "
+#define __pcpu_op_4(op)		op "l "
+#define __pcpu_op_8(op)		op "q "
 
 #define __pcpu_reg_1(mod, x)	mod "q" (x)
 #define __pcpu_reg_2(mod, x)	mod "r" (x)
@@ -168,7 +163,7 @@ do {									\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
 									\
-	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]), "%[val]") \
+	asm qual(__pcpu_op_##size("mov") __percpu_arg([var]) ", %[val]"	\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
 									\
@@ -184,7 +179,7 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size("mov", "%[val]", __percpu_arg([var])) \
+	asm qual(__pcpu_op_##size("mov") "%[val], " __percpu_arg([var])	\
 	    : [var] "=m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -201,7 +196,7 @@ do {									\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
 									\
-	asm(__pcpu_op2_##size("mov", __force_percpu_arg(a[var]), "%[val]") \
+	asm(__pcpu_op_##size("mov") __force_percpu_arg(a[var]) ", %[val]" \
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
 									\
@@ -210,7 +205,7 @@ do {									\
 
 #define percpu_unary_op(size, qual, op, _var)				\
 ({									\
-	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
+	asm qual(__pcpu_op_##size(op) __percpu_arg([var])		\
 	    : [var] "+m" (__my_cpu_var(_var)));				\
 })
 
@@ -223,7 +218,7 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	asm qual(__pcpu_op_##size(op) "%[val], " __percpu_arg([var])	\
 	    : [var] "+m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -258,8 +253,7 @@ do {									\
 ({									\
 	__pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);	\
 									\
-	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
-				     __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("xadd") "%[tmp], " __percpu_arg([var]) \
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : : "memory");					\
@@ -302,8 +296,8 @@ do {									\
 	__pcpu_type_##size pco_old__ = __pcpu_cast_##size(_oval);	\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
 									\
-	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
-				    __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("cmpxchg") "%[nval], "		\
+		  __percpu_arg([var])					\
 		  : [oval] "+a" (pco_old__),				\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
@@ -319,8 +313,8 @@ do {									\
 	__pcpu_type_##size pco_old__ = *pco_oval__;			\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
 									\
-	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
-				    __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("cmpxchg") "%[nval] ,"		\
+		  __percpu_arg([var])					\
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
 		    [oval] "+a" (pco_old__),				\
-- 
2.46.0


