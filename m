Return-Path: <linux-kernel+bounces-400757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9529C11EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A87E284E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285DA2185B1;
	Thu,  7 Nov 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bqlfb6jf"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FBA21766E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019105; cv=none; b=iiHtb8RJ5gBYopifKriN5bNL/c3e476MHZqGqI5Rqp6hCdv9aE//c719YbHI5eTwiVfXe3U7RUhGRkWsPHzr37hRtxRGNOR/hDxEXOgumN/jkIukZNhI5XQLGiUl9E3Ogu75/0SddX8pKffpcJMS9KluJXtZ8KgVEO+gkyzAsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019105; c=relaxed/simple;
	bh=VKdNQh3bXS+51IiXDHYAOf+7QeZT+DkLAK5ZUVQq5qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XCADGl5n0p/G0eQE2PGMpT2oQ4iNzI9P80o0I797a0S+tLht/kYFX4x/LOCctlpwV5ZftbCxfgaUF3fyrpSSEwXAXSDghGyP5SGy6IVvAg/pNNyklaDDSDtPyLyDabXzQgslJvIoRs65cQ3m8aShLzF8FVM7udPSxXxRjGQ033Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bqlfb6jf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72097a5ca74so1266819b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731019102; x=1731623902; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4UvGiQRb/HT4pWVa0ytwnByFfKeVrmx8fuvu8SCUmU=;
        b=bqlfb6jfdMiOuQu2C9k4wjxNogXkjaTTS8pudbb0sFJb5j3dmocvc4aKyCzeOlQTan
         HKcnp4GnEfIoQqrpULvPkfoBWsWuc2g/wL+n8Dl7McBQ7aTvVI4GGSDFpgqjcS/GpeNr
         Fyt/eGPL9mzhlyOuO9nVPFPTD9hO1cz7QUWOR4PG/7nwadov8frpucd7g8JKso0/tiKp
         lzo5tomva1B+0lvsXFYysnBdwe5D2jnySo4r0nXi92YqXOZSi4YolpuTdFFRBY7CiS/L
         lPJoou7rO7GYgPFwsSHBACzuOSHymMkUoGHo1p1kjYcODJHk2TaSm4hhU9QX36YnU9vl
         eaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731019102; x=1731623902;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4UvGiQRb/HT4pWVa0ytwnByFfKeVrmx8fuvu8SCUmU=;
        b=kGZUSA37imKrmDv+ftI3qCzb3BojeMs1L2RZbJJfQS/X19iJNivWd5+X4r0tXdubBS
         sFTvPgVNMoy2/oq2SjYrVHy14+SjiUh88TdfWMT2ZBwmQn00MKvFKMurr3gxU4k2sW9v
         5tikC+uOKHn8YkCgJk1Y2g2i7lOGruB9aSC6fuQaHn6hbepLYkB+/lTWMyOlHGk5d5UX
         ZXCzcvFv5gvXImEsrKR5XMiY4AaTwcoCVYLic4Iegb+ZOPvWlvSBtA1r+0fgYv3Yhzyz
         dvSrBgpOo9Tm2qcW3L7hZ3WSH+BkRyCrp8nyqal98vcXhe/FUMbrmFKFZlCqNysj0Ag9
         2xaA==
X-Forwarded-Encrypted: i=1; AJvYcCUYChVAYQrJlzB2Y4ykTjN8z0Ros8l4vni7UF7JZyZtaWGei747w7ssDr5Rawczi0zJmQgGysO0FS3wR5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywps6eicjSMMFxvH0f/C+v+i64pQygDr5GLlFoFXhlxAVXFN8Cg
	38297xwM7bWOzQfOsOv7FLyMmE8dAMUZhtjd+IGhqw9Sp7nf1kCNTNT0JOwWiKzkFl1RrqZM3hL
	5
X-Google-Smtp-Source: AGHT+IFAGtuApDVBC1UkjKkykQeZF5MXvTyzKLNYeIltKFs6LOqDwTb8M1Xi2bDrIl1p0NkIIZMN6Q==
X-Received: by 2002:a05:6a00:2d1d:b0:71d:f7ea:89f6 with SMTP id d2e1a72fcca58-7241337ff2cmr967888b3a.18.1731019102464;
        Thu, 07 Nov 2024 14:38:22 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bae1sm2227897b3a.94.2024.11.07.14.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:38:21 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 07 Nov 2024 14:38:03 -0800
Subject: [PATCH for-next] riscv: Fix default misaligned access trap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-fix_handle_misaligned_load-v1-1-07d7852c9991@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAEpBLWcC/x2MUQqDMBAFryL73UAiYoNXKSVE87QLMSmJiCDe3
 cXPYYY5qaIwKg3NSQU7V85JwLwamn4+LVAchKnVbWeMfquZDyciRLiVq4+8JAQXsw/KjrD9NGq
 re5AM/gVSP/MPzbmohGOj73Xdb2hvE3YAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jesse Taube <Mr.Bossman075@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=VKdNQh3bXS+51IiXDHYAOf+7QeZT+DkLAK5ZUVQq5qg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7quY3DQugNfPO5piW6yZa5ew5bzfNoD8wCj4588whYz/
 stWcljVUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwERMzRn+SsYtWs3wxcjIbrtm
 HStfXDZL/MX/2YH7JRg7t910+MlVwMgw+3bI/Yvh37/NmPj1uqu+18zTPV4Cf2Rqp2UesE9z83v
 ECgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Commit d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses
supported") removed the default handlers for handle_misaligned_load()
and handle_misaligned_store(). When the kernel is compiled without
RISCV_SCALAR_MISALIGNED, these handlers are never defined, causing
compilation errors.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses supported")
---
 arch/riscv/include/asm/entry-common.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 7b32d2b08bb6..c2808561df81 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -25,7 +25,19 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
+#else
+static inline int handle_misaligned_load(struct pt_regs *regs)
+{
+	return -1;
+}
+
+static inline int handle_misaligned_store(struct pt_regs *regs)
+{
+	return -1;
+}
+#endif
 
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */

---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241107-fix_handle_misaligned_load-8be86cb0806e
-- 
- Charlie


