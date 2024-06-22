Return-Path: <linux-kernel+bounces-225520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA19131B5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 04:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5755F285FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586AEBE7F;
	Sat, 22 Jun 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WkNKcA8Y"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54EB664
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719024938; cv=none; b=VFO5bUo+4gUf+oSeboRPFQ1Dzg873yO5KT1bN2P8S90TYXPDX+bdfztxQhBbp0YOg6PC4+TxpN7Knev9NJz1SzKUVTuazrtXYXmo2Ma3bkuIv/zE2ZN/F8zMBqyLQ9700ZmXWva55cYwK4x8mJRvzugUOUw0RCnIOSJMc0hpD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719024938; c=relaxed/simple;
	bh=ZOWtweHS7udvJH6Mn7C/9cPFELBUkzp7ZxNE1v9xUiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/OEOO5dzNcPYNUsh8k5aXAFPC1dhHVRm5QxY4U77SE0laVv4pJ0kp/NmDgmO+DbON6w9Ho4t5O+H7ukxGImCADkm4vX6YIKGPLjzxzyIpJxFkr9u7BPcK4uyc2pCvkA/3jmgT7q/iIG7K6th3Xci7Cm6AOlOQeq6ZWmZGjwWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WkNKcA8Y; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-376012bcc33so9761305ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719024935; x=1719629735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5if2KmJRWjBL76ROZgI/17GyYKcY5wCvGdrrlEk4u0Q=;
        b=WkNKcA8Yd8T5SnOwVE0P8moQY95xxnxAL6stF+Hii1BF7qX2zka30u+6K5D6S+fJ4U
         ULJokvgayforpdT6Z5o1HZNZcTsvXU2zSTRTeGC6ZmMQ+gLx2J2WIbasGHsC47RXNfx3
         ZSLxMwDB3ReE70Qrwi9IVAL9Kh5qD3I0QIxPjfVlIGYeD5RJeT35CrayOkd8jV23YBbH
         WmWa21cR6KvSuIrcej75EyvDjPTeZvCA9j5gbGQWjmGIIYPJMVfsOeDcQL2RhvqjONWQ
         dCwPl2nz6EaS1SY1vbJwd9pIio4FibmK2zMQeYPsgpoeoVNtzgxxJTykBFccuZUd/po0
         m54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719024935; x=1719629735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5if2KmJRWjBL76ROZgI/17GyYKcY5wCvGdrrlEk4u0Q=;
        b=nzataVmlYv1p78Mo+oISiSsuRRvSeWTUf9ny0DBMxGzft7rJ8EcA+M0Yy03ngZDmwv
         wteJCEVY9ZSXJXc1jwB0FBrkz8v2gWXfkblCZJnt4zGV/KoyCrcpCD5DgASBfbKxNRXR
         ai03LfPmggQB8f4IKexP2vrO0AORWuECYm3HJP9W6o6pKTm0S7JM5bCcmsmbORU5sGuD
         7rxzKGFNomAo6t9qfN9BIk1jT7tVkp2J01tpl6WVcSC4l8U4VsTR6ln6hU24md0Vq5lY
         mdqh/UZ9fkyKeKmd9kT4LqqanFjj/ZZxeVL6U4IINKCJRaRGGoMSiI92NyEOJ9rst2+b
         Jrlg==
X-Forwarded-Encrypted: i=1; AJvYcCUAkph5A7x73/6nVklITHg2gaX5gPgHIuci/VqFEkQGMyUmGn+0VcDidKVUYd++XzI5Ebes9fVIj6OhqE7ADj/7fdWYJIfwbLzV3idc
X-Gm-Message-State: AOJu0YzbQmFz2amJHhdljrG32Qmm/46ts3JlgBtYCChaNUlnPCI9LJth
	menU5u1iMeGQ85Ct+HlI7lQgJfqMCExf9KAGoScgTGQCfh+U+hNZzurhsIuZEIc=
X-Google-Smtp-Source: AGHT+IEDqRRjk5TKBUDCMz6j3upGcBor/M5o4HP05d0yYUEeFU9td2Hhs5KyDe0neUdvKGxG88q+Sg==
X-Received: by 2002:a05:6e02:1808:b0:375:8a71:4cbf with SMTP id e9e14a558f8ab-3761d708893mr106035865ab.23.1719024935423;
        Fri, 21 Jun 2024 19:55:35 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba7a0699sm1776286a12.67.2024.06.21.19.55.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jun 2024 19:55:35 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: jesse@rivosinc.com,
	jrtc27@jrtc27.com,
	corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com,
	evan@rivosinc.com,
	conor.dooley@microchip.com,
	cuiyunhui@bytedance.com,
	costa.shul@redhat.com,
	andy.chiu@sifive.com,
	samitolvanen@google.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v3] RISC-V: Provide the frequency of time CSR via hwprobe
Date: Sat, 22 Jun 2024 10:55:14 +0800
Message-Id: <20240622025514.66537-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Palmer Dabbelt <palmer@rivosinc.com>

A handful of user-visible behavior is based on the frequency of the
time CSR.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 Documentation/arch/riscv/hwprobe.rst  | 2 ++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index df5045103e73..ec3c99474ed7 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -233,3 +233,5 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time CSR`.
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 150a9877b0af..ef01c182af2b 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 7
+#define RISCV_HWPROBE_MAX_KEY 8
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 2fb8a8185e7a..5053a9b18710 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -74,6 +74,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
 #define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
+#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ	8
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index e4ec9166339f..3d47edc04a3f 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -8,6 +8,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
+#include <asm/delay.h>
 #include <asm/sbi.h>
 #include <asm/switch_to.h>
 #include <asm/uaccess.h>
@@ -227,6 +228,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			pair->value = riscv_cboz_block_size;
 		break;
 
+	case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
+		pair->value = riscv_timebase;
+		break;
+
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
 	 * call, but get their element key set to -1 and value set to 0
-- 
2.20.1


