Return-Path: <linux-kernel+bounces-559200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D316A5F0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910E717CE63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C211526560F;
	Thu, 13 Mar 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKAiIRQ6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518F1BC5C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861624; cv=none; b=IxdoUe2AMqpA3vAgAGmv6r47fydi9YPuP9hRyUtN4S4zLrkBaZ6u00JHDGIk9sxyZiHkB0ykEevl3G7eNMLUqYEkK2AuaWWRjp7meTbRJux9foLzlSPELuwxny35Jty0TO5TjNIvNIz3ttlTLmVDk4KupW4qvsy4TSO4ZPWLn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861624; c=relaxed/simple;
	bh=qHNhZTFHHMqTXop10qmPHJ9fDmNtNiT/sGffEdBc4Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anm/t+MTFPZNlKa+XiP2aj2/lv63ihmOZ2B//p8zEARmSPNTxLZ5BNWVCeX24dJyx641JoPv2OGT4RNJ5efsUokykFztJ8iIOsjjMmNrWyXZzms8GNUg/rlr4gwfHMpAKByOpo2pzS9D8QcPaUBp/CWnhW8wH5VSise1utJ/dkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKAiIRQ6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2c663a3daso167288066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741861621; x=1742466421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIyyrpQqZVE8qaN39jZLwxQpb7eHJr5tbIsdVv66ifQ=;
        b=dKAiIRQ6tWiEO8kpLbp2ypg26qP8lFIgvUGcNqIiA+Ux4iRx5N1jkpvJOyZQMv0vme
         8mSS7+4QIdp/a20z4zV5cPLmUWuGjkSH7I7t9akEzQaz51HWU6el2g1tnQ3LsW5FCkqz
         nJQASo73cTSAq2X8DPWaciYOQRxYD9R83S/CRyHjB5sfNpVzzQUlqY/mAqbjmVsQtiim
         c0YZ4PgbvumI8Qa6S4lUN3xbFjMgdeaLzPpxqWdqMT6zrrcu1WZM/XZjSXVmoNUjZb3T
         S4lNgp2Ne8pRN/7nJTZQIZaD7BNTi2Jk2eipIQG5mNF9dBnDwLcr1i/K8I06z0Dj9LHL
         6XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741861621; x=1742466421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIyyrpQqZVE8qaN39jZLwxQpb7eHJr5tbIsdVv66ifQ=;
        b=VHtNVytG+Ie3wUnTh1qdZ6VViw0eWyryzCdRkJgce9lgG/MpxdRgeNp8YnvAZRwguL
         xsadxc5IlgQywnGvVTyG3u9g5ZNtQlrEEduWjyjwfQvmVKC66iHP4qRlbDzxp5BWB5J2
         nMtByT8gtWG6qfcpulRn84LXfHJcnrYh+z85Ze6I1w0MGrHCKhBwRQ1wNnb67ZWySlm8
         4//iOSCVnYH8WjYDkJJckft7PE8ZJvKxyLiWQBHllbedS2IFhZRT8VrNZ433nYRXKRsA
         YWJwxSFZpU+aZN8vuoNSBh0d0kAOAWKDOaqQmcInCY/iYZ4LV+6GLS1xJTftGGd/vcpw
         C8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWX//Jr8lYtl55wYMhwGiertPcdGCdToUYvwLFhUk7MvuYdzGNHO6kHPw5WHwtIfSgdpFMvNuXAIk90IFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Gzj/AB4/HK/hqlRvlR5nARDlkuOeGwvqNsrPQk9BPSjx+bY3
	nI/cVpQ2yeMw/jz1wfTy0GggH8nQCZedIm0MzfLYs6xsQawu1Mb4
X-Gm-Gg: ASbGnctvsGDlpZNdQuRmRih6HfHHjbtQF2KUUrW8uNy+NbXpM6T9Jif+DVP7tkBljP9
	VCGWJ0OZ/RpuKIVfUZBTa1dkuS0PDbJ0jAgdIbodvJKpLyq03q9Ae0dqWAp8fpzoW2rY5TG1TDZ
	3KmBPk0eI9ii2YRdz+rnJKI3xlcIwKxJ04HHlUfRzEXR4ber59cIlGLssrfevHuR7uuyehbqwmo
	j7WRDR6TX7Q6sSRTU/VivIZaCIa1DUTYZP4FfyclS8JNvSQImfLydK92ntUPgbuzCqVgIcp+NTr
	i+xaT9ba9AAKwu4eU2iSE8E1Nq3bsaRIiDaA
X-Google-Smtp-Source: AGHT+IGWAcM56kEFt5K+6/xK1S+DLpnWBRQIHY6Eic+tXIbILSUQw6aAM8fQPpmpBqc/iUAWzmVv5g==
X-Received: by 2002:a17:907:72c1:b0:ac3:da3:a19b with SMTP id a640c23a62f3a-ac30da3b268mr277758766b.8.1741861620416;
        Thu, 13 Mar 2025 03:27:00 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac31485d046sm63279866b.83.2025.03.13.03.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:26:59 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/asm: Use CLFLUSHOPT and CLWB mnemonics in special_insns.h
Date: Thu, 13 Mar 2025 11:26:55 +0100
Message-ID: <20250313102715.333142-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current minimum required version of binutils is 2.25,
which supports CLFLUSHOPT and CLWB instruction mnemonics.

Replace the byte-wise specification of CLFLUSHOPT and
CLWB with these proper mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/special_insns.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 21ce480658b1..9b10bd102d3d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -176,9 +176,8 @@ static __always_inline void clflush(volatile void *__p)
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte 0x3e; clflush %0",
-		       ".byte 0x66; clflush %0",
-		       X86_FEATURE_CLFLUSHOPT,
+	alternative_io("ds clflush %0",
+		       "clflushopt %0", X86_FEATURE_CLFLUSHOPT,
 		       "+m" (*(volatile char __force *)__p));
 }
 
@@ -187,13 +186,10 @@ static inline void clwb(volatile void *__p)
 	volatile struct { char x[64]; } *p = __p;
 
 	asm volatile(ALTERNATIVE_2(
-		".byte 0x3e; clflush (%[pax])",
-		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
-		X86_FEATURE_CLFLUSHOPT,
-		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
-		X86_FEATURE_CLWB)
-		: [p] "+m" (*p)
-		: [pax] "a" (p));
+		"ds clflush %0",
+		"clflushopt %0", X86_FEATURE_CLFLUSHOPT,
+		"clwb %0", X86_FEATURE_CLWB)
+		: "+m" (*p));
 }
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
-- 
2.48.1


