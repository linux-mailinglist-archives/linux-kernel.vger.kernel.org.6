Return-Path: <linux-kernel+bounces-396657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916A9BD02E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D31283672
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE591DA602;
	Tue,  5 Nov 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM5THYbI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADD4EB50
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819732; cv=none; b=VdrNtlBPnejOC93yDwTRmxyrBMiEuFRToGcPQjqqZ5x2WdAVh+yzFJTTaCDmPUOo5AV2I9llhp6wTDcCwQbIdLzkEwpHMVVCsfX77hP+0h3Zh1poFgmmN31OYS4npTJDsyzkjkS9sdBhds9+GlhB9GijU9qjRqnst24lK5zeLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819732; c=relaxed/simple;
	bh=D3758a++ou0Eh7/dplQav3UhcopkGDoY0Pl4xDn0AQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLwdP2puVVRr6Ec7I7e9IFVNhuKP6Xg17F8zu2GfjfSrOz3JK6xbismOJY2+s/Jl8i3dSzF6Eh/dNk2OGkyVHPy9301Alb2Y6OuGdX1tW2Yt0xLm4EPPNV4/VbOUqoB73WE/4AzZy/bkXRPvQp/dkyeA313WqG9qbh+/7IRDBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM5THYbI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so7524191a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730819729; x=1731424529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5rVHNS+v3hPDM+SOcagtjAwRadQS3w7TlqdUetnBxM=;
        b=VM5THYbISh0T3livRzG7mKme3qKY0cj0FNxCyFUwWTXkoza+IrpXPlSjjO7fTOkUC2
         EF7XE88nv3Pj+jIOYxOOPnvCukiJJVfYnlAuoj/ZLYGMNfUQnJ+lX4oOv7ri3EBzrp+H
         JMzfGWqhmHBONw6qaf2D6UjghTB2TY3pO7OskJJg/GAHpbQWkwX62VBqlx/fLYqLCuJ1
         6Fs3fFRxso9QhYKV5rCClzy4PZnoFLcY+l9Lvtkk76yWJ2fP5N5VkWM7yTFG5gKoknUc
         dzcC3arNL8+dNIq4f/AuRU+PbX+ms5eV06mvkz/S2FeF8l3YrCNeYqjCKy6lm4bHn637
         I5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819729; x=1731424529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5rVHNS+v3hPDM+SOcagtjAwRadQS3w7TlqdUetnBxM=;
        b=e1ek6VO/Hf5TzlNI5nSu+oOnVEe8T7JYzjRiyIs5r2NKEX5J8YkOY/IntyujxBeIvi
         eTcFIVnMs+n9u2yzyTjSN4bVMQ0+HWsIrpP9IkKuyhCNEj8Fmkqf/65HJVthCF5hSCF2
         ZlHSYykGy3ilNETX6HjeGpiSSeud00XX+MbF7UIixE1OGmLW+Us6oS8g0JA2H57d1c5t
         zZ+0+GYrFtj5VQRL6X8l0EY63Cg9NlPRNkGxBSGtCaSZ1SKL50oDx4G7HcAzrcFzSn5S
         R+c+PcCEkvg8R0o9mmuE16AHeu+NwDwgkn5dKTkUzH74gq5KcKmdTfSQHNYypDGbVd5Y
         mYyg==
X-Forwarded-Encrypted: i=1; AJvYcCVMbatUFu7B4A3tmYsHystEiTBonFPFBpa6VlIQWDpdzoMygjtm8DuGTMkuz4T5pG2hbq2QOgxlfCGTIbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcDLXC5SYE8Z56ddj8c4dIog1aigHhVtSObroA/qXZ++8pg3b
	GZes5wRCvC4oUTCvNGr65lt3V9s81de6Cg5z0wu7s4MaG5OItUiX
X-Google-Smtp-Source: AGHT+IFpfT+pQ9yQI8bqfkWsrf7FaiZUkGgH0GH2EJwAHN7PKEUeke8tthYvAG8fxB0zG+d5dFCuiw==
X-Received: by 2002:a17:907:9720:b0:a99:742c:5b5 with SMTP id a640c23a62f3a-a9e6553bcb4mr1605046966b.13.1730819728614;
        Tue, 05 Nov 2024 07:15:28 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a3b6esm145523466b.18.2024.11.05.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:15:28 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Beulich <JBeulich@suse.com>
Subject: [PATCH] x86/percpu: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
Date: Tue,  5 Nov 2024 16:15:08 +0100
Message-ID: <20241105151520.2632-1-ubizjak@gmail.com>
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
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Beulich <JBeulich@suse.com>
---
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..b131d1bb9445 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -349,9 +349,9 @@ do {									\
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
@@ -380,10 +380,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP (CC_OUT(z) (success),			\
+				   [var] "+m" (__my_cpu_var(_var)),	\
+				   "+a" (old__.low),			\
+				   "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -420,9 +420,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP ([var] "+m" (__my_cpu_var(_var)),	\
+				   "+a" (old__.low),			\
+				   "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -451,10 +451,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP (CC_OUT(z) (success),			\
+				   [var] "+m" (__my_cpu_var(_var)),	\
+				   "+a" (old__.low),			\
+				   "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
-- 
2.42.0


