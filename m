Return-Path: <linux-kernel+bounces-528309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C199FA4161C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F373A54F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09D1A5B8B;
	Mon, 24 Feb 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCIl0IMy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785515573F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381416; cv=none; b=Y7LdryyWVYTY0mYAWWI/OEvDoFrVTvf0MvSMm7jSskJ/GsBpSH+EviAA/UJt9LYFazqx5I02yBqeeT7lDgPnukYGk2sbR9L72NMaRazlQq7QA94Q66gn0DmbZq5DTKt+krbEMdh6d534c6uTyqHvRofYzhPv0IoOc+AfmYqpq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381416; c=relaxed/simple;
	bh=TapnOBT9lLgKVdduxBTMDgSIZf7N4uNcg64leFTA14o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7LzUelZW15HXDvCYGRPkmOigBr+izwL/KFnM1C7D+r2/xZhdthkiBZKPSXvWg+UeB+3ppRUe3I82VAXON+BmYMXNt/8D1pEpvdh+4txi+m5Mmr+OhNdKXiTw4pvK4snqEkVRLwTguKziflL+UFMvEWyb7wwvYfWJ8dndmP8cXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCIl0IMy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so7315853a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740381413; x=1740986213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0s/3qzVblPHs/DybxKbK1uCwXjEno9+69ptFJ4oZr4=;
        b=eCIl0IMyNLMGNs+sUC3RRJc+Hl3X86iZe22FLX1BK+E4aD34q7wqseI8ofkdIwSJXG
         btmNI4fFsD8Di9DtTp2chfPMTLs5CPNoeisKVP0fo36GruVlyrNOb8oBB10EHbKC2qrM
         EAMRlZd35rTN4yLKnswTwAnFvTOluhrTuzTtHxAqa1mvJcb9mIremy5wjIZMGVt7LLvJ
         UkWTITi9yNGSYgB0wfurz7egR5FgnnYDLMme8cklRKujwumpw4kO8np2NNIF+7xT8tDH
         J9SFV1Tzn54SUBF09FXf8QI9FfMm9Rn+gy6Dwzr816+c6Dwu+RUrf8+k/52Da0ZxDRrX
         P5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381413; x=1740986213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0s/3qzVblPHs/DybxKbK1uCwXjEno9+69ptFJ4oZr4=;
        b=Pnu8oa+bkNdbFdARt7dwrTl/dZ579NxC6DnvSLfQsE7651vURYIH7dsCFXtVMBTdCz
         wZEyDCqW61p2727wUTvvJW59I3eI/7qJqjplfSsVHY9A7rCzQIV1os1wL+ZmYRMuEnv9
         GACRwy6/nHYqRCqSWTv3KtLE+TZzINShN+nD9fzYeuhhbaSUNJh4wYKanHegeA7eyYb7
         3h1xMSKnmjZIpEU09PwijsCmK3iVpKiFjJJ1IRmPtPZubGHcH7kPlokyZ0G71S5bLEUR
         nAtHnuF9HfWRLTPEPktdq//CgE3R858FwDvbQCs3dqzAMV6rjvp3f7+jzvnH13IOZsmM
         dYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQJ5P5UeifyCmwKtGNxwlGoMU913LIr49Yf967r2vgR0VgTV8jH363jFWzz8y4IqAioDckgHKVxl7mYdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+aADGqXsK2C4eRDm2a9H2gFzPVgX4kiqnyemBz6h7OGtpXnn
	aFo6mdfTXjpu0rrCxObuxe9PpRUvXZKn+UEbeSW+hTaQpITxhy94
X-Gm-Gg: ASbGnctCL89X5i5fzQhhX2y0IoQY6ZRWDPatW8c2dfByoZsSG5p4hV5/niB2VHRPJ//
	gGfyGzI9JrFdU5RGjuxhO7CcFyFHDoh3cQJyWQ+Wo1fEignAsaxOT6eSg8YzzcUkaDS7PIAunci
	7rgx18mUxoctcF2BtUkgkUNWeIM0vJex6CTmQeQ1s6xnT6BP75tA8CXqVjSucH3lV9tU5c/IOUx
	oWwJkLBA+M0eNU1WQVAli7gVP14XSs4vz3ZaZsKmTOky070Ar4z6tZZAh+96Pza0WJGmw==
X-Google-Smtp-Source: AGHT+IG70bU1ZlQuhdDUy/Tu+n8/72hM95b2y81R6qxHgnkMZYC//ghxsFoKkOlg3LpmxxnQ2J/q4A==
X-Received: by 2002:a17:907:8688:b0:ab7:84bc:3233 with SMTP id a640c23a62f3a-abc0da3b026mr1201119566b.28.1740381412306;
        Sun, 23 Feb 2025 23:16:52 -0800 (PST)
Received: from fedora.iskraemeco.si ([193.77.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbe4e29b4fsm951456766b.170.2025.02.23.23.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:16:51 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND] x86/percpu: Unify __pcpu_op{1,2}_N() macros to __pcpu_op_N()
Date: Mon, 24 Feb 2025 08:16:34 +0100
Message-ID: <20250224071648.15913-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
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
 arch/x86/include/asm/percpu.h | 38 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0522a710e004..c456e54adb73 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -106,15 +106,10 @@
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
@@ -146,7 +141,8 @@ do {									\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
 									\
-	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]), "%[val]") \
+	asm qual (__pcpu_op_##size("mov")				\
+		  __percpu_arg([var]) ", %[val]"			\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
 									\
@@ -162,7 +158,8 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size("mov", "%[val]", __percpu_arg([var])) \
+	asm qual (__pcpu_op_##size("mov") "%[val], "			\
+		  __percpu_arg([var])					\
 	    : [var] "=m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -179,7 +176,8 @@ do {									\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
 									\
-	asm(__pcpu_op2_##size("mov", __force_percpu_arg(a[var]), "%[val]") \
+	asm(__pcpu_op_##size("mov")					\
+	    __force_percpu_arg(a[var]) ", %[val]"			\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
 									\
@@ -188,7 +186,7 @@ do {									\
 
 #define percpu_unary_op(size, qual, op, _var)				\
 ({									\
-	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size(op) __percpu_arg([var])		\
 	    : [var] "+m" (__my_cpu_var(_var)));				\
 })
 
@@ -201,7 +199,7 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	asm qual (__pcpu_op_##size(op) "%[val], " __percpu_arg([var])	\
 	    : [var] "+m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -237,8 +235,8 @@ do {									\
 ({									\
 	__pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);	\
 									\
-	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
-				     __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("xadd") "%[tmp], "			\
+		  __percpu_arg([var])					\
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : : "memory");					\
@@ -281,8 +279,8 @@ do {									\
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
@@ -298,8 +296,8 @@ do {									\
 	__pcpu_type_##size pco_old__ = *pco_oval__;			\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
 									\
-	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
-				    __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("cmpxchg") "%[nval], "		\
+		  __percpu_arg([var])					\
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
 		    [oval] "+a" (pco_old__),				\
-- 
2.48.1


