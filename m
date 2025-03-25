Return-Path: <linux-kernel+bounces-575884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF9A70886
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4369B1891CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D62641E3;
	Tue, 25 Mar 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP4vmID2"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7E2638B6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925151; cv=none; b=O7790VVzjK2rA/zSn9h+5AAxJgCHrZ0gmKa9E+8G/eBa81oZ0wTN+lpewsBL82f1ZzjGKXXRIPtvAaqpDpzAkvFe9pnLuFYDXPEWQzO4NawbZ773ARJG59OFt4nprSH45Dh1T78bX5RrQltp4E5mcxpRqpRLVIXRKjtWxOaiyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925151; c=relaxed/simple;
	bh=hnt+gROIGEYtDufShCECnYtdK/HGy9wQEpwLYnzkD2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOqr6h8Ts0XceUTweF89Qh2m4tu1iJYdc+AA1DuUZvEJX6zD9+PZ5S9mbw88gGNzat0Zck4sWtMo4GEEYZeqN8dYR+m277Miuly5KfAmvd4KG7kVonR4/k7EblOhH8aipIeZmYGFOurp6wwE/s1t4BTLmZ3tjpNIzH1YNbh2D2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP4vmID2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso133314a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925148; x=1743529948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKA5WA5HVfIrcWNVNbTnmvzq77SZqSw1yWIAelErrYA=;
        b=aP4vmID28kRd8EvQyXIrBike8dSK4vLiwOO1Os8Q7/cdDYcHMsw61ATVNMt/bWXMHB
         YTDvuThygz9qJ5nsaBGjTG3cRzf7bIXepusqLqUmK6R4jyfajNKTQy7UswsactU14cIB
         ndeKSXkikqf6DlEEWSV0QpAKCAtsXcKU4N1MVf5e+fOpc5YOw3DLd972/97w+TM24Ona
         pWTS0exJIdPF+eSeOU2m5qLm+RzRVfLUcBfZqAGe6PGqGpvLUHZLF5DUV/aUSWfryGd2
         WTYtQTpPmiGiz4MFT85VsCAn57k/dUcsCvliu9tydOfrlK9Ubq0fjdbZXkYK006n8lJi
         s1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925148; x=1743529948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKA5WA5HVfIrcWNVNbTnmvzq77SZqSw1yWIAelErrYA=;
        b=iBIbhmsQznCfk4yg4Xozr+2BWdYuvBhS+p703fPZ6hfBWy0An85UmCkmDzpnz9RgLl
         UVVnEDB4RVUkQIvb4yO/z9oIiQK9lVx68C5CWIcs1iXs26Kjp+hzKF/SlVzs7KpWOBsB
         rCcU9uqn62hNI5V+zaJDEQep8skEhEJSPxkWWaRoowc6y3+SJQx2BHAWboysBA6iQ8zY
         qt6B8uu4bhvFTw9Prm01/2MTtVlAO1+dmcatzmvIQUCwgomCU5lj2XG+SCM/f0HcCIqT
         miMdrZYRFvNxCJdvV47QkQ28pQvW6pKj/3SdfSA/F4yNJ62kkKnzSyE5eJSxcLUyVXFw
         IoXw==
X-Forwarded-Encrypted: i=1; AJvYcCUaU864hJWGcZfqyQsh8oiGVKRvSXk3u+l1QGcBWNyTE/rhoNx7zYLuhG0AwXmkeSps3uE18r6Uj8vO+SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoT/LwjA67S35dpU6JvR3bnXAZoLmkUyr4N+LyHEy5WPq9Hc6
	yfYzKjfomYt+eVLHv+CCMQE/6yNA1Q9Yf8h8D3pAAKzZUx/vJUkl
X-Gm-Gg: ASbGnctiTH1HSdCDkltK1ZEv+NSSC6KkHGYfKJ1hm9GSAPrKBNGtNPV5f0QIoWE2Sx0
	8su5tpmPE38eXHH4iF9Kfu98xNmjrNrH9QyGFKkwXDTFCeergPoaY31V7k7xqroV2JdoUTOtDmD
	bTmBXQza0EUTqb2L4Kf2FP6X4ojzq6MYcBguE1q9mttAhIlOxh/csma56tGv496AN2ZGR8pgB5E
	h7La45VoSovGeHS+YqtQR7MHn8CfoUBEq6xPkk8T9/2FgCCwvOvegmBL18HrDDX6/8mlWLnDRTT
	dOw6qYADa6vstf73yX6TnvzP+/4U6WRZR+TaAhAU+6GnqmgJu9SMHg==
X-Google-Smtp-Source: AGHT+IEHgnV8No9iUwCozetBpvcTdwgDWXnhBeYNArNKIWhT8OK/eFn2icOJI25l7X4Iim4Is5idmg==
X-Received: by 2002:a05:6402:26d3:b0:5e5:334e:86d9 with SMTP id 4fb4d7f45d1cf-5ed43ba9268mr566408a12.13.1742925147757;
        Tue, 25 Mar 2025 10:52:27 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0cefdcsm8027789a12.58.2025.03.25.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:52:27 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/bitops: Fix false output register dependency of TZCNT insn
Date: Tue, 25 Mar 2025 18:52:02 +0100
Message-ID: <20250325175215.330659-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250325175215.330659-1-ubizjak@gmail.com>
References: <20250325175215.330659-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Haswell and later Intel processors, the TZCNT instruction appears
to have a false dependency on the destination register. Even though
the instruction only writes to it, the instruction will wait until
destination is ready before executing. This false dependency
was fixed for Skylake (and later) processors.

Fix false dependency by clearing the destination register first.

The x86_64 defconfig object size increases by 4215 bytes:

	    text           data     bss      dec            hex filename
	27342396        4642999  814852 32800247        1f47df7 vmlinux-old.o
	27346611        4643015  814852 32804478        1f48e7e vmlinux-new.o

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/bitops.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index bbaf75ea6703..7e3d1cc97c5a 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -248,8 +248,9 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
 
 static __always_inline unsigned long variable__ffs(unsigned long word)
 {
-	asm("tzcnt %1,%0"
-		: "=r" (word)
+	asm("xor %k0,%k0\n\t" /* avoid false dependency on dest register */
+	    "tzcnt %1,%0"
+		: "=&r" (word)
 		: ASM_INPUT_RM (word));
 	return word;
 }
@@ -267,8 +268,9 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 static __always_inline unsigned long variable_ffz(unsigned long word)
 {
-	asm("tzcnt %1,%0"
-		: "=r" (word)
+	asm("xor %k0,%k0\n\t" /* avoid false dependency on dest register */
+	    "tzcnt %1,%0"
+		: "=&r" (word)
 		: "r" (~word));
 	return word;
 }
-- 
2.42.0


