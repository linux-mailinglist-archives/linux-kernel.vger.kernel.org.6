Return-Path: <linux-kernel+bounces-224538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C8D9123BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3761F25807
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8917333D;
	Fri, 21 Jun 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lG64Dcvx"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897E173321
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969522; cv=none; b=tFWtXkZOZBfsv1dOKxRvFiIBCMDDwiAvPEU78qpLn9icEjmzkaOQD0AEF81pHp8nZKE7IEq+G1+XV0C9TXzmpxaG9jKE7zt7yfTd+14DK8P0h+tunTZH+eCHJUEFKvuIhOBGHg0Pjay63G5Gp926NeF03NWEhVoJkUOCalZ3Jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969522; c=relaxed/simple;
	bh=LqsZquroI0tQO7+Y9gF1GgujJ/mRYKaaJvY6lz2+yY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAk/QMludFitmNGbLo5kw6m2VmyalpgXwGL1f+eRIM6MNyCNlRpQx+FTxww3OgMiJc6dqgFvD1aJ2JTBSQTQpTdaWSTAPWwUxkOhj3GAx6yg4i0c8QrAM5wJmtcvU3kKUqU17MeKhIVb1Gp+RCRNFLU7UwhGhUcYXtl7QSrhO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lG64Dcvx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70627716174so1644340b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718969519; x=1719574319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEfFryDpLG4dH8zCVdjU9zRDBUZiLvxvddXIXcpMvC0=;
        b=lG64DcvxKe0mQiwI/CwPXmEBT2n0hqxH/afA+AIsF9cmzTr3yJ1t0vXKBXazLMOWRR
         UVXCHx7rXoK5sctYYMmFQCTkw49Yfcl6eJq+TQ2GnPOMC1yuf/TF8sTDzDkWJa7nuXqS
         QTK3e4SgBE0dMUyfoySuxVVw9b9BRtGDi4HsVbvpMexuGfsJf4++wqcF0o6FvcC0ajyO
         Fgy9VFmVcU4qrYivEpqb2aFlTkBCdhNSJe/KgfJSo8mq+7oxX0+l8b7HOlMvkYHZCyp2
         +c2z4YToVhVY3yclW9IZ1U4C1X+7CO0Gfh+PJe6kyhhkCsfZ05VyQw6Npa3X2H6xLlbZ
         7Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969519; x=1719574319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEfFryDpLG4dH8zCVdjU9zRDBUZiLvxvddXIXcpMvC0=;
        b=HBbdjDXx+odRZcR5Z8DAIb1oTEzHhClw0z+iNa/Bm6mgv/PLQvF9f5N6lcJK3koyGi
         MiKU2O+nsUpqblvDGVbCrlXmAkz3PTxQkIr+gbfQiXP27Fmq305z6Q6XMPszVoSUscuP
         QW4nMdhe++gt9rq5Hpq55Oh54p+CqV4IZiLgU0UoFSNVTStQsq4ZKCIAqBUmwK3GmmS4
         oZ8OYRWYqB5yhNWVi5s6DGlUuUGS/CkaaAzJpyIkePDRwunGezWlwjR/rtGSd0Uohwk4
         X9Cv89Zac+2RzGNcriTfw/lWz81fKXQth/3d9FYq21y4NoUysIBkOSi8xjwRqdpqjdzj
         Prgg==
X-Forwarded-Encrypted: i=1; AJvYcCX4dKFZQHRkWx/3BdMnDSwzHxRcS5XTprsDlqK2zoPh0dJezulHomaZ0m+uWJ2Cp7914Zs9WrFO4vAGqcnibQRYFFSn7mx0IImlV537
X-Gm-Message-State: AOJu0YwUP727g4Xfsu1PeQ6ZZB2qv/AJf4sVFeT2CKCXCDMlvyCZC4M2
	7cBJKx+VOyvZ2o/vj9XnFZZDFPBX0c1aa//7fhjZOcCj3/Orv9YkQopp8LxTofU=
X-Google-Smtp-Source: AGHT+IFT/y1zF1Jddf2NzmkYrziVwMZjrrqkWjtGt/0nH8eLs1/XWHtwzQpNBQcoLZX3seWwnm/v6Q==
X-Received: by 2002:a05:6a20:a98a:b0:1b1:ed9d:f92e with SMTP id adf61e73a8af0-1bcbb641494mr7867935637.38.1718969518719;
        Fri, 21 Jun 2024 04:31:58 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065124e354sm1181707b3a.119.2024.06.21.04.31.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jun 2024 04:31:58 -0700 (PDT)
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
Subject: [PATCH v2] RISC-V: Provide the frequency of time CSR via hwprobe
Date: Fri, 21 Jun 2024 19:31:43 +0800
Message-Id: <20240621113143.35827-1-cuiyunhui@bytedance.com>
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
---
 Documentation/arch/riscv/hwprobe.rst  | 2 ++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index fc015b452ebf..c07f159d8906 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -229,3 +229,5 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `mtime`.
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
index 7b95fadbea2a..18754341ff14 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ	7
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 83fcc939df67..fc3b40fb9def 100644
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
 
+	case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
+		pair->value = riscv_timebase;
+		break;
+
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
 	 * call, but get their element key set to -1 and value set to 0
-- 
2.20.1


