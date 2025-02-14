Return-Path: <linux-kernel+bounces-515163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3093AA36117
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861017A586D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDCC266EE1;
	Fri, 14 Feb 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq5HTiYN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B93595C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545782; cv=none; b=cXMNWyZQh7+3Xu44r4Hxs56eAZRDV7FWPE0RxfWmVFEPXvD0vmgsVPthhaO+KdjiPvO5aZkpVpBhzdtmOevFPpWi+mKGbHIlFpg3/dMTxXMZNBPVdItPiKsDh9+1u/bDTRz4WDFh9x/DM8IEJ8g1JhBNYc1zbcEWJiaD/LdGzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545782; c=relaxed/simple;
	bh=4o44pkpKgmGJCdX6x5UPw6PoMPdQ6qFQXtbkaMpfRnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFmzMF8QMG5/996b3Y304XI/A6nqN21ZjFaua0eXZSr5f3p6/CW2RWn3JxtJSNCO5/SYcoywmtPmo8eB0Oi7zwcNPTSTZiwBzk6ByPFdR1qpgVZSoaXCfzoqddhZ4HWF7Xw7b2iHnEE6V1hRyL2qCdiA07NE9aYE//HYzlgDOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq5HTiYN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so2551756f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739545779; x=1740150579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVqMZ+3Mpmpk9SfLsBXSOCQc7oNYAD8Y16TaUhOCH8Y=;
        b=eq5HTiYNRzQmHgVEaImWbwr5AQu2jIdjfG6qn6Xh/IgO8Iyt72hRFwlsASTXmtJ6OS
         NEospOcTUMFA1UbSkjFPWssADTOsbYNx99ZZq9hsHNQ//NXRsRl1ejaTBMv+i7uFkmQV
         KR1458wbffQPLEvkGZqfWQEDtOM48lIOLN6vSbZk68AfaBjB02bAznM9RDzHwNQQJ3gj
         PYHGYe/W4jFagMt0Yq40GFDIQj8GfvpC8GVgzYZYZJMPNC1HSWtOATje3eWoEjNVpx/I
         FR6SKob/q3POMlrWvcZuOE0+yuoTLWVNX8rFgvZPdsGjFBWxMdsgYsLjH7rv4t3iboj8
         b6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545779; x=1740150579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVqMZ+3Mpmpk9SfLsBXSOCQc7oNYAD8Y16TaUhOCH8Y=;
        b=YPoTzZivQpUFm+UYcbuJoTUHqnPqsgpc7Iz+jaVLC5cXcyW8IuN7Hh771skDegJjz6
         n4SwZ4tiQuD6noVHM1MTopLgUIuJeLJzECGOjpEJuzs3iCwQ3caTc/w7H+2Q1a2+efA8
         aHXjf30zA2JE4JfXu2rLvbZHryLfVMM/qsZAQbUApIZARNXZQHFzWE822UQDKEL+6Wvb
         Bcd8BefOxk5upFjjfEVb/QZwXE2uBo40y012W78ex8mRNnOg8SKHZInvCvH3nox5RF0+
         3MACO8vInT5TLoof6IaPdoJDx4VOauiiT+eIzGmcsQ9prGVlUKwmrpWeRiPbZOD4i+uc
         c5ww==
X-Forwarded-Encrypted: i=1; AJvYcCXmSAIph5B6bx44uIkF8lOwxpwBvSmIRql3N32jwZLJhxw4dzg1JfoJ7/EGAhUP7I7LkoijsT78Gb8U5sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUo5MyypRPq+ms0myzVpxS1WWh1jvO7wq29tCgdpkMF3OMzSG
	wGCGFsxKJPFDNXk//cu3HvrzMj91OMNPXR0eGvqgZ8oJPKDMtt1n
X-Gm-Gg: ASbGnctHKRmy5YSYZTbnveWch02yvzqlJXRET1GraWDLcJaqABv6CEHiFrRti/rx978
	qsURCWKGtHxZEwG091FyfDsSODdYsimVj3PpebBFs0v9Im40BdQpZzLKkSaB25VgcILfvPXili9
	86VIbflqAKD6kp8gNVP8njjbQFZEnaIlU97w2RbubVit5ULNOQmkNQqcjTzLMLy/fOqlOUNuBe8
	VtwZNWFWqeiVnUrsHLHy0xdrxyefNnFT95oV3TE29rRjxJ90e59DIqMzvFFSoMFvKnq7mxLsyBz
	5UpH+qhwkvxrrfoFAhRl3igZ
X-Google-Smtp-Source: AGHT+IEXQWbeVAMShMrrzZEIZ97y+Aoj4EgRTTgtulGM8VILACGiWcO0VRckkcgDb+WqEeYDbjg47w==
X-Received: by 2002:a05:6000:1568:b0:38f:2095:2fe7 with SMTP id ffacd0b85a97d-38f244e502fmr9519949f8f.12.1739545778732;
        Fri, 14 Feb 2025 07:09:38 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bee9dsm357447266b.173.2025.02.14.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:09:38 -0800 (PST)
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
Subject: [PATCH v2 1/2] x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
Date: Fri, 14 Feb 2025 16:07:46 +0100
Message-ID: <20250214150929.5780-1-ubizjak@gmail.com>
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

ALT_OUTPUT_SP() implements the above dependence by adding
ASM_CALL_CONSTRAINT to its arguments. This constraint should be used
for any inline asm which has a CALL instruction, otherwise the
compiler may schedule the asm before the frame pointer gets set up
by the containing function, causing objtool to print a "call without
frame pointer save/setup" warning.

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
v2: Expand commit message with the explanation of ASM_CALL_CONSTRAINT.
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


