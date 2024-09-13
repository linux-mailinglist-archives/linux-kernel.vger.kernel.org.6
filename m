Return-Path: <linux-kernel+bounces-327598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFFB977836
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F87B25387
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374D14F10F;
	Fri, 13 Sep 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP/5FFGB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD94A07
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204445; cv=none; b=svakEklZWAFn2NZwUsL9hYiW7YZUQUSN8gBBYrnkEMAv1XnDaK0SM+KX0nfahgGzQq5Tq55MXjThpoaW7rQvTUcOSeGcLM0UDM02wCjxYQrZuRkph3Yuv2lE0aTsy+KFLu9FwxJhzZpjeTPaT3ywcqsbywdzGGZi5kcnjYmuuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204445; c=relaxed/simple;
	bh=V1fvTvhnNs0D/v+HSumYZRrqkSvuiMQGM1bEUvgAAp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W4iwD8TRVbPAy/GxgnQMxtQtIwCqVXYbvQZEFjz4oYrqa+xW25tvghSjqedBbN2jWCPCJ0UdGZ6xHhyCEgnQ3k3mJTmmtKDFOk9SaY7FxDuW+JRxvR/ihh3bpy3SWYjv8q+beY+L9NQB7YJ9utHnHwr1SAf3/o6O+hrnAX4g7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP/5FFGB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so14697815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726204441; x=1726809241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=97sC7FgCTGAzcHzCh0fwAJYsBr0u+Us2Q3UWUqb1Z7A=;
        b=KP/5FFGBKwAH+xbH+e/rVbltyFn6xWGZDUVgM9ZRIaRiU/ul5ZvA05D4TFmK1v78m3
         A04KyrsRhOcEzaCf+vtHYG1rlZWUHKJ6jfwZMuUg1a1B61nYE3ee82/JjpnODMKTXcvB
         i1cTJj8IWS+CDY5Gc3fBLhNKktma1hG9anVho+o6fldEmZVgkiq+6nq4WpZGJFYpPTcx
         pbZi0v/VOh4a1py82wsrhtaAxNz4NH5q4hAhdEFTk5OrxjlcOWe8h4pYb7CidOHE4udr
         uLIE9HnYgOLhO2jf7eHCyymzcEAdwKNmEfWOOx2/xC3ndeTBudQVSDbcgX+DcjpuRPiA
         Tc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726204441; x=1726809241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97sC7FgCTGAzcHzCh0fwAJYsBr0u+Us2Q3UWUqb1Z7A=;
        b=M3u7MyxjrlwCfY6Q+zfTRZAKOU3HnZgv1C1UX1eVEaAD+XsCT0EhuFDJycM5HxrBb5
         LjunJVVhjmwYhBf3OXVTdCqXE/6OhiFH17w/V7NDk95YtXIe2A/FVjbOi4C4xFtuVpaz
         rL9iAtn9mo8qIM+q+FRyON3Gi1GKWC73kOIa9OHC1XL321iQxQTlrO5ZvFJnSdhTteA/
         DEJcBBSRnLWIbEj+kdXjIgITnAO0USwMsdM39u9vO18YliUK4DFxoBmO8gJ4x1CsC9TC
         U4sGbuccIcNt0U8fljq7xfYoyBoWf/rhRAbkPlM0wwD4uW+vjmnU+UR/gw+XJgYyluTJ
         OMTg==
X-Forwarded-Encrypted: i=1; AJvYcCUze4JXmBbw1NgvL7h2ySw7Ye8Yfkh3K5a/1iztcGrYLKubT6h6paP+B1NMtP5prCwiz5b+n7G3MS2djig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMKrg4JjWZAMLWPM9VZCjTaEfFsbxDboo/zCKuTVSkQjBoyvC
	oLVIp5AawcXIC/KudUR2a8oPvjp6JuNZJVYooGcMn3narfa0upX/
X-Google-Smtp-Source: AGHT+IGPTeZzgwWJYrCDC9+6ULWhqzz+N66BwcmM+1R3Eh86zl3oXyQ3q54ErbKwTAYcAwPG5dUmYQ==
X-Received: by 2002:a05:600c:46c5:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-42cdb531b96mr40618205e9.2.1726204440453;
        Thu, 12 Sep 2024 22:14:00 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b15c2f4sm11063685e9.24.2024.09.12.22.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 22:13:59 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND PATCH v2] riscv: hwprobe: export Zicntr and Zihpm extensions
Date: Fri, 13 Sep 2024 07:13:24 +0200
Message-ID: <20240913051324.8176-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
Acked-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
This is a resend because I sent v2 as a reply to the original thread and
it most probably was lost by most people. Fortunately Conor picked it up
and gave it a review.

I am resending this so it can be properly applied. Thank you for your time and
sorry for the inconvenience.

Changes since v1 [1]: the EXT_KEY instructions have been written in order.

[1] https://lore.kernel.org/linux-riscv/20240817075629.262318-1-mikisabate@gmail.com/

 Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3db60a0911df..cfd2929d0562 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -183,6 +183,9 @@ The following keys are defined:
        defined in the Atomic Compare-and-Swap (CAS) instructions manual starting
        from commit 5059e0ca641c ("update to ratified").

+  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version 2.0
+       is supported as defined in the RISC-V ISA manual.
+
   * :c:macro:`RISCV_HWPROBE_EXT_ZICOND`: The Zicond extension is supported as
        defined in the RISC-V Integer Conditional (Zicond) operations extension
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
@@ -192,6 +195,9 @@ The following keys are defined:
        supported as defined in the RISC-V ISA manual starting from commit
        d8ab5c78c207 ("Zihintpause is ratified").

+  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
+       is supported as defined in the RISC-V ISA manual.
+
   * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x is
     supported, as defined by version 1.0 of the RISC-V Vector extension manual.

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index b706c8e47b02..098a815b3fd4 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZICNTR	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZIHPM		(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8d1b5c35d2a7..910b41b6a7ab 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,9 +107,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);
+		EXT_KEY(ZIHPM);
 		EXT_KEY(ZIMOP);
 		EXT_KEY(ZKND);
 		EXT_KEY(ZKNE);
--
2.46.0


