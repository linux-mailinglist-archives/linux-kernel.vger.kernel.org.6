Return-Path: <linux-kernel+bounces-237211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AB91ED7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23C01C215F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E62E62B;
	Tue,  2 Jul 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="acX0G53k"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDB2C861
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891483; cv=none; b=qqScCwxC19vNv1zbWmtM35UY4EplMsBUkkEUIBUj5BC6cdTjpdDL8+7APi+5ZkLVz+HpZUfMb2ubDrk5+7wQ7TjhOpjrBmZ/PitYax0kfTABAwipl+xniwYTCeUWpQ/z8S6N9O0p8KO2uRaygGo9klNUXYHujpkA40NzuNMTvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891483; c=relaxed/simple;
	bh=mNYnbEap9bA7z0qkRag1hEtUcHyADai5hLopnGzBtmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKAGKzvJWTsMVXREgrg36fzEsMeGCvJgWP3bBSsa+cyHXyHF0FhplkORGdWC2l1ZsBCREKdcCLTZW+1syOTb1hBo8+VIAPPEBkA+d2gqz7N3gsgRcH+uJjOSTol5IR7MWj16J4XeLe9lmQInQ8iwz4xugzdhEJ7Ue+pkb9psWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=acX0G53k; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d55db7863bso2454584b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719891481; x=1720496281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf2nftHse7mnih+L4oXIzzh1aSKno0toJKgKYAsFq00=;
        b=acX0G53kgdQKlyTgAcX4ivkT6HPiGVwHIlB4bKBf2idTTxk1lXXE+eyhSPRkkI2Q5x
         WwWHmCXzDRtKtqJXvTmjwWg2x8SyWneEaVmgpn6GlBKR1TfsWlx2mJB1A91oYeQOHqCi
         wPj22PvIElb5RpqBI4sII7cse2ARH+cIE+jwrWK/W26d11eX0YZXQB6yc9TL2aYdwkKW
         MChvJCtV6clPfck0T3GfEcrsCxFMGx7m/wAiAIimtJbkAXjOwP1Oi70TlA+zI8bspDiP
         w70YCYiS/CBMcZ9qaXZ/+sAFYSZWdSrVCDxrQAdnc7N89N4YTFOjvT+7o/njWV1zzso/
         ut2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719891481; x=1720496281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf2nftHse7mnih+L4oXIzzh1aSKno0toJKgKYAsFq00=;
        b=K4a28TBv/AcLaLtWtURQGQqy7zZn4INZnWI6HeVHaM0Ok674Z3kjf/myCoqukD9iTh
         yrN8Hf3Wv3cWgrmtEIgC25FGpUeV62l+Yfe/+UoddgRgTGYROdmDBwzi3Rli4jyRN7Qp
         GuVVhMiLUl4pCsAh4BxQccDww0kwSJaCpfSfCkKmtKRV0zNiZhK9ynYnsDwQMOtllIeY
         H/ZO7ijH1CiYPAskMnaRP0cCXBWomjKmKZUVISWAnr0JtPT+uAjC54R/GWb9zLL9fwoa
         NqFKSbsYxcZSmtBy/ohDs/i9bUedxn9/sGx0uRWXnSxMmxuRVDae412zCp3eN68l7QNU
         VRDg==
X-Forwarded-Encrypted: i=1; AJvYcCWPFBykDHRo5Zd6beuxZodLhI23jyX1nFdgDs6gg9ig6F3f84qNoxLGOe/nlkxbNoomY8VxqP4+NM0lW8jhHGhClIdNsZBSGYVzNbwF
X-Gm-Message-State: AOJu0YzApJKfkag+GbpwwwR6AV44JFIMFQj6lhWGh3kG0MGFiNDzvEL3
	Ce1GYvVbRCvo/bPyakJZm1sr7+j9dpGz1Lh/ILa++F4fO+wSZ0akIvgFo0Znz9w=
X-Google-Smtp-Source: AGHT+IETmkEcCkefLWA5V6ulLJS/8Y5AlXyYZMDR65nnKP80OvJYV1oR8Ah21icBDky6rOj33cY8Sw==
X-Received: by 2002:a05:6808:4494:b0:3d6:326d:c0df with SMTP id 5614622812f47-3d6b32e43d4mr13487852b6e.22.1719891481072;
        Mon, 01 Jul 2024 20:38:01 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045aac85sm7537263b3a.174.2024.07.01.20.37.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Jul 2024 20:38:00 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	sunilvl@ventanamicro.com,
	jesse@rivosinc.com,
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
Subject: [PATCH v4] RISC-V: Provide the frequency of time CSR via hwprobe
Date: Tue,  2 Jul 2024 11:37:31 +0800
Message-Id: <20240702033731.71955-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240702033731.71955-1-cuiyunhui@bytedance.com>
References: <20240702033731.71955-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Palmer Dabbelt <palmer@rivosinc.com>

The RISC-V architecture makes a real time counter CSR (via RDTIME
instruction) available for applications in U-mode but there is no
architected mechanism for an application to discover the frequency
the counter is running at. Some applications (e.g., DPDK) use the
time counter for basic performance analysis as well as fine grained
time-keeping.

Add support to the hwprobe system call to export the time CSR
frequency to code running in U-mode.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Punit Agrawal <punit.agrawal@bytedance.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 2 ++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 25d783be2878..e99008fc4501 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -257,3 +257,5 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time CSR`.
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
index 920fc6a586c9..8094b45fe16f 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -79,6 +79,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ	7
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 3d1aa13a0bb2..45f32a60b9c3 100644
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
@@ -232,6 +233,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
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


