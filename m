Return-Path: <linux-kernel+bounces-194566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCAD8D3E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE6C2867FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645215D5AB;
	Wed, 29 May 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wJMqtpn2"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6F15CD74
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007218; cv=none; b=MnX3q84FWo//2ieC65Ad2OA4OBB6fDL4W3h2lxrFHWF64hwFjRHhUjfN2/aToIqn1iJcyTeddDkZxnA8ZG+OAfeFq150drIEMin1TuEsf+/TqaseOZB6SexQr79w0t9wC2sasGJ/mw+ch+VOc+BjAfZ+ibRiMDrM0q7aWGKF+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007218; c=relaxed/simple;
	bh=6LVVYXNh21KrADprqmRbX7nwjBAz7XxQbzBF1i9gRd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8xiccVj3Rpqycn3yw2Ywe7iGOH6O3Yp3Xhw3M+gdfDCxmo4aRKowootyVF43nEz3fh4Z4YqLkHgKL+spk9jZTdzhp+4oRyk75vFwEQiJOK2aeQQVPefdR1TkgkIcYeuCh23Tc45xH2VKpJnH9BFTQBfkHwTyBA1xRXSx7S3AZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wJMqtpn2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f47728fa4cso367205ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717007215; x=1717612015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wV+9Ayl5aIwRvmUk+4xjSCYb53pq5UWCKjYVecZ6q8o=;
        b=wJMqtpn2EsmcCuwQlsta+SxjUkeINsfzZKhkV+E5dJy5A8j8Af8HI93mcUYQnajnB3
         c3lbmiCrh8hs3yy5p1wOJZiMtPTipkXZErolsdOQyN87RpJPCvwEKmCqGVmfEUuOYPl3
         xdV4S3vcWvokHo5ZCgGNQ4w7Ga2yf50N4o17ZLQQmelfmLAAyanIaGDdCmDVpGISf0sC
         8aj6yG9ywWRjwxuU48NebSRvgU4U08fSPo2i8MiKGhwfv3V2hFVr+AVmUyHN+prua3DU
         uqG7LeJeTmUlah8Ve7mLii6WAwo5ZtmMy0mzztnqrkP4CwpDPqa7cVo4s9SaOz6VKKig
         PUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007215; x=1717612015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wV+9Ayl5aIwRvmUk+4xjSCYb53pq5UWCKjYVecZ6q8o=;
        b=YGk/R1iSimlPGYmdhUUI9RImv8czsZIXN8+wV4CzF0JVS9nsXLAcqT2s2DfzFD7r2z
         VY6MBOIv+MFaiBMqgGeNAxDnuiZj5+DtROQKS12Bbv/t/uf0nvtScRCmBsEcQgdG2sM2
         SqVkKVFLB+6cKnxRNQ0FuX9/m4PE8anpqjn/Um0dYCWeWK3DQBHSYM/GGgbVh0GKsVFj
         qbhiO/ME3FCk2Ctsu6yUTKB9VVw0taa+sTV+ST5d4YSIUGE5GTtt4qn0MSsdfNirPsp9
         b8iLr8acIMNCNahx8EAE0IgF5FInihHtYiSDwcw6vA3CXPuHyH41jzRAjdyX16j2IyGe
         0jvA==
X-Forwarded-Encrypted: i=1; AJvYcCUkEHT7+cBqhnEcUr1IRjtsRbH3hdBlsJaJ6l22pyjQ3VloQRcmU0ae+k5cYIkpO2neG1ZUYbJbKs5GHtRdZL3T1KFezYcBVDerSov4
X-Gm-Message-State: AOJu0Yz+sdbRGRUwQiQ8rvEazwsM62Xe9RwyWqjOtKTaqJ7omanmA2mC
	NHgOttcqC1DqJHiKg5pHgWEvnWQIh+NsRqqF98S0avkWzrjgzmHc8jrMwx3dWS8=
X-Google-Smtp-Source: AGHT+IHRDxLd9IHo/dFmgMfsngSBbOAxErYqY9dIxF6DeOkxqEZJH9H0vaoSPZZqTHcOxtdRx28xqg==
X-Received: by 2002:a17:902:f645:b0:1f4:5278:5c19 with SMTP id d9443c01a7336-1f4527863e0mr151718295ad.49.1717007215144;
        Wed, 29 May 2024 11:26:55 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96f67fsm102981055ad.154.2024.05.29.11.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:26:54 -0700 (PDT)
From: Evan Green <evan@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Yangyu Chen <cyy@cyyself.name>,
	Evan Green <evan@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: hwprobe: Add MISALIGNED_PERF key
Date: Wed, 29 May 2024 11:26:48 -0700
Message-Id: <20240529182649.2635123-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
hwprobe_key_is_bitmask(), when in reality it was an enum value. This
causes problems when used in conjunction with RISCV_HWPROBE_WHICH_CPUS,
since SLOW, FAST, and EMULATED have values whose bits overlap with
each other. If the caller asked for the set of CPUs that was SLOW or
EMULATED, the returned set would also include CPUs that were FAST.

Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
returns the same values in response to a direct query (with no flags),
but is properly handled as an enumerated value. As a result, SLOW,
FAST, and EMULATED are all correctly treated as distinct values under
the new key when queried with the WHICH_CPUS flag.

Leave the old key in place to avoid disturbing applications which may
have already come to rely on the broken behavior.

Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
Signed-off-by: Evan Green <evan@rivosinc.com>

---


Note: Yangyu also has a fix out for this issue at [1]. That fix is much
tidier, but comes with the slight risk that some very broken userspace
application may break now that FAST cpus are not included for the query
of which cpus are SLOW or EMULATED. I wanted to get this fix out so that
we have both as options, and can discuss. These fixes are mutually
exclusive, don't take both.

[1] https://lore.kernel.org/linux-riscv/tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com/

---
 Documentation/arch/riscv/hwprobe.rst  | 8 ++++++--
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 204cd4433af5..616ee372adaf 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -192,8 +192,12 @@ The following keys are defined:
        supported as defined in the RISC-V ISA manual starting from commit
        d8ab5c78c207 ("Zihintpause is ratified").
 
-* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
-  information about the selected set of processors.
+* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated. Returns similar values to
+     :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was mistakenly
+     classified as a bitmask rather than a value.
+
+* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An enum value describing the
+  performance of misaligned scalar accesses on the selected set of processors.
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
     accesses is unknown.
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 630507dff5ea..150a9877b0af 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 6
+#define RISCV_HWPROBE_MAX_KEY 7
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index dda76a05420b..bc34e33fef23 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -68,6 +68,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 969ef3d59dbe..c8b7d57eb55e 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -208,6 +208,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		break;
 
 	case RISCV_HWPROBE_KEY_CPUPERF_0:
+	case RISCV_HWPROBE_KEY_MISALIGNED_PERF:
 		pair->value = hwprobe_misaligned(cpus);
 		break;
 
-- 
2.34.1


