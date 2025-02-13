Return-Path: <linux-kernel+bounces-513757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A3A34E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A082188F5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EBD24A06D;
	Thu, 13 Feb 2025 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpMLUBxp"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49F24A043
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474116; cv=none; b=TJiN3EiAtst4QiJEqxT2sWw4TWAm5/415GENwZ6x6xBasL+c6ubZwR6mzkwgA8SaxmXmhH6w/GS3PWZvMtaUp9gGSMQ6ThvK8x8q6H51RJ4DfkT4ChF6CKULpXNJKpDoeTK+85mxOc+7Aqbe+URRJL+YwApsKbn7Fonxer6WfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474116; c=relaxed/simple;
	bh=a/uBemEj9PszXi3HK4tvKrfiV+5Lk8UXkW7mGrTPlz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Voh/y8Tmzc6izgD+KpitfAClk9SfT5sQLaoyaTFg1KinyFwCduxayoMvzsN3Fw0WTTTwavnKqV7puELhxSA54ey6VaKvNTIBmB/ROWNs07sjas8q2M14DEPrqIc4GXXyog7Ak5GkkuxCGtfqsDPv2WYqHtaW9bqoD2k1e9QTitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpMLUBxp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so1178058a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739474112; x=1740078912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCZRk8F5oIr78QIJHIsQc5tZNTNUkD+BR9QkiJxVXFM=;
        b=dpMLUBxp9UujMaURR6oE1EvtUWMJwJPlmR/6iHV/jEHB4MkrEhbFoLHeiy5pSKsgdx
         T6f7xvV+8mAnciKxmt4FlS+MEjJmsCmU0UqArRbiVLRyQRDZ+TINl4RUm6JPMllbFocS
         9/4yrccLIT2fgBJW9xekvhz6OE8VzqlWz4lc6EHdjYn2ysZ54q9u6nViH35zT8MPMPUo
         V25hFzbbMV0B/8uqeQUkicWnt2zarAbYQhGLhXp+Vfr1hZvz8VjAQMxL9UXnCU0VHaDO
         hUa+jCTVzjFnGyen1s0kyB+EZwdXdVDp5odj1deJ1vjkTuhjpdVhgr2p/qPSKXzo7hkt
         MBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474112; x=1740078912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCZRk8F5oIr78QIJHIsQc5tZNTNUkD+BR9QkiJxVXFM=;
        b=rBub9i+G6d0EiXHJhT2sXUY7bFVfliQn2v8SPGMA4q5FG1c3nQk8zxjChOljv9MCaB
         pjB+cFdSnoMfZJpiCaLfegyE9jorYOqxl0y5Y8w0yZYXkNe/19MpNTtlrwFbhibdRuiQ
         3famVkRfL5v5gUW+QfmGunp3hbRcDcu7ThNc8SuEd+Ki+k9bavUi0Mfgpq9OcRGU9NnJ
         Vvf75lnu2RUJU65N01xv0HNLyqldgSNNveRYZZXKfz5veF6yrDZVe9yxcEDD/U50SBln
         bfxRrm9GbVJY0F9FZ4GvqYJ8P2AbiQlwec6ePGEBY/0UKrsTTPdtN1XGy5GH2YNR5N4n
         B5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXpyvCot3zplH69XrPzqySRL9Sxp2GjllzI8I4JoS32hCeQqniyGM6dnYGJAgN8nst7uxyqNj7X4bc4MSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlu0OqxpjVoJHHe4VTbR0WVOD+TLQYibVTPY4udpPQdkky42AK
	fsndoVm3U+iOJEx84AThSl7cbzHsy4pCaOx2sv/3PQO9r+2t0rtl
X-Gm-Gg: ASbGncsTWqTteNiJkHZuaSmKfEyfEClVzlo7qJ81iH4OPrehULveuFBOYb7Y/6LttTM
	e1eowFYtnjYt9/GEyY0MkzPoyzg8MSbGaY6efAc/KdZl1JZb8lqpn6+QcYHsUDIPAsLnM3RQAEm
	wrMk4HoWbxSOhI89WOg3W5E6dnmzBvOkV9YvCq+qz1R/5D/thx5QJ61XFskIY7mZ24Cgo3VmH22
	+DgPGYLxmNyXq94s9TNo2Ezm8RRZ5YMcHdvE7XC2UJEqYy99gJdGhuQvYYZoShva+/cWuNZdwV2
	tqsPvYfkaZUVQxirFaG8bwmy
X-Google-Smtp-Source: AGHT+IGDmxUXgTbru6c8edVkbG2Aem3VAU2thpwucZbIXMGfjZ+bCKmeFDFZQtDaYQRE50Elj5HiGg==
X-Received: by 2002:a05:6402:2106:b0:5dc:a452:4f7 with SMTP id 4fb4d7f45d1cf-5deade07f4dmr8704114a12.28.1739474111241;
        Thu, 13 Feb 2025 11:15:11 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece288e2dsm1634508a12.80.2025.02.13.11.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:15:10 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH RESEND 1/2] x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
Date: Thu, 13 Feb 2025 20:14:25 +0100
Message-ID: <20250213191457.12377-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

percpu_{,try_}cmpxchg{64,128}() macros use CALL instruction inside
asm statement in one of their alternatives. Use ALT_OUTPUT_SP()
macro to add required dependence on %esp register.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e525cd85f999..0ab991fba7de 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -350,9 +350,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -381,10 +381,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				  [var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -421,9 +421,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -452,10 +452,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				  [var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
-- 
2.42.0


