Return-Path: <linux-kernel+bounces-219161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B090CAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB9B1C235FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB615E5BF;
	Tue, 18 Jun 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eJFSyRuJ"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDF15E5A1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711226; cv=none; b=lrJz0B7wh58OpRHtjPZI/kQG6hYVRYEMXCDfJsE1DwiRS+D86oVO9pYxUX9uyBXwO14954uvUQlFKjjGBCuceeq8bf+iiebEC3Hez4xQZifOBwqqGTgLy3PrLeq6m5W2XCTJb4i03DUp68zYGHyWrMhC9lqwN0aCSkf5JhNAiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711226; c=relaxed/simple;
	bh=ZHcxqMe2wl7XXw0sTwxebYt93dT7YO9q83kwx2ZKj6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BPHgFFojZDCZ/RxeEBwRrbzYZ2rZ7MoOT+suEvV7ZWj9VbMg3JRD6sJM7FrvWBh+9JgO/ZZLU16ul1qC5OuS1tnvgicfvfvfb+AvFJzYLVCeV+enMQdMwYs8AuMMD1sBI3bWVcZhGXVf3MmNd/PYsxHrjOBuPyfDYrrPMKcckXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eJFSyRuJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so3783568a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718711224; x=1719316024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N8+RGABEO6lna9EhwFH7VWtP9seFYP+2PecyhqqiBFA=;
        b=eJFSyRuJUovruTCikD4RZh4+0NZwMqyftAgMYKyrE0XKA03kCRWoiOFOu3N9ays6IT
         qee6cidxJyWBhxMHEek7ADNpD//59ckgA06kXtAw97Y6cSSoNDod6QvQMCnWvTY4Wncs
         unLFjv67qA0tikSmgJvWjKTqcxoMquHEG3SRT8hzfB7GGI0E1DyO9L5GiGeR0d6SiJaO
         KunXzVa+xiJAegH/jT4CCoOVI/S3UYvdEgmi0Z8UQnUw6y56Bh2ZCe8oyVG5yipbufCr
         PZYZoVkuSGvAdL8ZXRJimaGG71JcZjUb0Ievr5TZ4sg68V8MyIbyUKGxKhGQoM+xDdXd
         EAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711224; x=1719316024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8+RGABEO6lna9EhwFH7VWtP9seFYP+2PecyhqqiBFA=;
        b=pqDWcVO0URW0MdiLLuEgvl+rjb+swas1MF/WzsOQ20l5+I8km5xkBjYt/MlZ3sbyZJ
         lQ+1iO/CnBw22LPdM07BUFGEC9qFF3PVknWlexNFkpIIv1ra1nd1SWeM/rlHGCCFZKwH
         4/7ioZsobgGItvM2p38eS7VvgIoO71EBMk0CI8MiSRg0o45U7KEi7DjTs8+JbEwwTTMg
         94uJPx4lPIGPWw4rACOTQJBicrnz+tf5DAKQqbxn+ZZzlRODu+oJG3HRc68S5yTQ5wSu
         otsL7s6Fk6bs7PoNAidLjHTsjVLA4BakwnL5YGsNKkYqCkzuUeQeAnjGPcMi4OmuD7Hr
         PnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWInOEwbTCYi4Cbk43MIrCqq7K1A6zoAOo7IDmRa9nEtPBBJ4Jrl290Dm3DgRd1UKwaew9Hx5HPLW+RnC7c70tDsLF1ifwpvXh/s205
X-Gm-Message-State: AOJu0YxbsATHP+qoVRDrEW9qZG0BLGOdShePz8yEA4i1QjGIPm6N9Ddd
	FTwAzDAokjjfDrz+7pr7zdcqWnXy/JQrtvxR2TknTSO8CEBbBIzgv3nqOteeAKw=
X-Google-Smtp-Source: AGHT+IGFDOB6kB9pshWCoiP1FpV8JeCOOgnEc3F8axKP2a4fh9M2ef6HmKlyehClnbcRTMajNGf0mQ==
X-Received: by 2002:a05:6a21:81a9:b0:1b5:69cd:87e with SMTP id adf61e73a8af0-1bae7eb46afmr9188496637.21.1718711224523;
        Tue, 18 Jun 2024 04:47:04 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeff53sm95717365ad.181.2024.06.18.04.46.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 04:47:04 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: corbet@lwn.net,
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
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] RISC-V: Provide the frequency of mtime via hwprobe
Date: Tue, 18 Jun 2024 19:46:53 +0800
Message-Id: <20240618114653.12485-1-cuiyunhui@bytedance.com>
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
machine-mode time.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 2 ++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index fc015b452ebf..0cc3ef5b5541 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -229,3 +229,5 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_MTIME_FREQ`: Frequency (in Hz) of `mtime`.
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
index 7b95fadbea2a..f7d9646ff4ba 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_MTIME_FREQ	7
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 83fcc939df67..3fa519035416 100644
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
@@ -226,6 +227,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			pair->value = riscv_cboz_block_size;
 		break;
 
+	case RISCV_HWPROBE_KEY_MTIME_FREQ:
+		pair->value = riscv_timebase;
+		break;
+
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
 	 * call, but get their element key set to -1 and value set to 0
-- 
2.20.1


