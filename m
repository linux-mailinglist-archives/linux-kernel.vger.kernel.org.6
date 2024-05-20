Return-Path: <linux-kernel+bounces-183478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C233D8C99A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3742B281978
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD81BF3A;
	Mon, 20 May 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbF0wFVB"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F76FC1D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716192598; cv=none; b=VHBUG406E61b8CUASKJbEO6vNPe1Ik+fyYadmzeyxiF+tKkEoE9qY6NVU7OBEFFMGVqq7XNnlLyZXhHJvcNiV5So30xxL9EJijeChGLJkEh6DYfF1RVveLzLPI3M57vYlAE5tzK1YO5cYMsuKOZwT73qzJ94IMLkSZ1sz3OKLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716192598; c=relaxed/simple;
	bh=MV1dCelyr1kkpGe3h3tjGEDk8tpCSclPjWJyxo+egA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNTPj4RSLhUnJ3zPUe6VpBVG5HOUNrRxffQinZp2GnuCruGPW1/FPg6PBynQevKwsILArrY9/gPlU10gZGv2oTiGLKHuHRVgXut2p4JIFJbD1hSphhOHKnSInQyFOyT9b2UKlxMYis4KeNwiAAc+VpwfM0K1YDCRzeX5ETZ+fWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbF0wFVB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52327368e59so4473540e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716192594; x=1716797394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ce5x0LGcFA5FGoL56hEdoip9fNPcS/6GE/4eUd0800=;
        b=bbF0wFVB+0yYzuWOXZGA2OmNWqrXxBnXmDwLcivYpppB+4qxOEnI4nG1o2BqGWn4r/
         HiNR+haaWjMSOkhXl++IKAGkJC85VFBrU7cn2+kJlxZy1fIpMhs+/AGA9QttyCtVSkhz
         kTboWp0egg2H2A0hOk1VC/Iug+A8TM2VhA/YZp7u6KMv74rfEAxj6bu6hZhtVjpoSxBr
         33+wPbea1VfEnptBMAoyJFO9xmNjkyWnFajtv+A4Bl0y4ivT8EQGLgvWoV1hsKXZc4R9
         bgYSxctlYX2Sr6Ue1TM6KKywDqkIxISgWMgmidYJfCxQVuLuq0JsvI0eU3AKW0y7ES2v
         isiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716192594; x=1716797394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ce5x0LGcFA5FGoL56hEdoip9fNPcS/6GE/4eUd0800=;
        b=Eb/Gsltf4f3S5aGPQyAljqaWwuZ0m1Tn0sauQdyx9j53z/OMJmTdFwN/CT6MNPCohx
         jVfjavuehdqkXc9o9+pLjTFvbLT//PW9arrxlZ4jBO37vp7T/xbAHUbvp33NSXpq5RJ/
         +COlJrBQ2XbOQ5+kXuCn8JVIFMX2ieIw1E+qCkGcW8a8y4WUXqUn5Zg/EBf+P3ukTgYQ
         UdQCMyyWp5i7TOrklT+7vUnxtpHI0KCEWkhFl4aEOaz4xbWiZgv0eDIeEyFDoCUPMoHM
         y+s7VmHqrjnq4PU472ju/kCZ8WwxmcioLdbXFSeczzYEBYYDlyi2Smnt8Os+uZb3kBHt
         rm4g==
X-Gm-Message-State: AOJu0Yy/ASmZ3mVL4QEvQaFoWnk/JUavpUuNi2CMEwBU8WNad5i7lZJT
	M3TqWoSAa+pBMkQUVsB/qhQRZd6yzodQjDR6YqV8HJLVAz4mxiGuv0Jhbkvu
X-Google-Smtp-Source: AGHT+IFKiWp0JI0wYaf1EorVF4up/Y6p1loIuSAPqXuQ3HUFfBIQXC0lbICMV37qP/yDEtHJ2g/zxg==
X-Received: by 2002:a19:f50b:0:b0:51c:6c59:627e with SMTP id 2adb3069b0e04-52210074a34mr16906840e87.42.1716192593516;
        Mon, 20 May 2024 01:09:53 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3518d817ee2sm24784776f8f.2.2024.05.20.01.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:09:53 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/percpu: Rename percpu_stable_op() to __raw_cpu_read_stable()
Date: Mon, 20 May 2024 10:09:24 +0200
Message-ID: <20240520080951.121049-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename percpu_stable_op() to __raw_cpu_read_stable() to be
in line with other read/write percpu accessors.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c77393cd0273..39762fcfe328 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -190,10 +190,10 @@ do {									\
 
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
-#define percpu_stable_op(size, op, _var)				\
+#define __raw_cpu_read_stable(size, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
+	asm(__pcpu_op2_##size("mov", __force_percpu_arg(a[var]), "%[val]") \
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
 	(typeof(_var))(unsigned long) pfo_val__;			\
@@ -480,9 +480,9 @@ do {									\
 
 #define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
 
-#define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
-#define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
-#define this_cpu_read_stable_4(pcp)	percpu_stable_op(4, "mov", pcp)
+#define this_cpu_read_stable_1(pcp)	__raw_cpu_read_stable(1, pcp)
+#define this_cpu_read_stable_2(pcp)	__raw_cpu_read_stable(2, pcp)
+#define this_cpu_read_stable_4(pcp)	__raw_cpu_read_stable(4, pcp)
 
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
@@ -535,7 +535,7 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
+#define this_cpu_read_stable_8(pcp)	__raw_cpu_read_stable(8, pcp)
 
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_binary_op(8, , "and", (pcp), val)
-- 
2.45.1


