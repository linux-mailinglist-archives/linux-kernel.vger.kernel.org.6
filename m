Return-Path: <linux-kernel+bounces-172601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD68BF427
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF7D1F223F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC843F4EE;
	Wed,  8 May 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hC9xZOH8"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6772D524
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132209; cv=none; b=DevhTLaq2G9PVfGudu5db/tdhwN4IFsMw9BbP+nW3MeYzZKKMPBEsgIh23z6BD8yZEROaD3Wkl/vcIY+1Zxxf4BUR05fX6js20VVllI9yng4iid3cg1HjHjnuQMnQQi6tHzXUmqNIltPMG0WwH0yV63s2s57pbl9YlQW+cIvr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132209; c=relaxed/simple;
	bh=hN6gBReRWF4tyaALzLlv0FO1iXf71FwbEQWuRR1cn6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWnQ6xivFbCWe5z5dZtoPlGGqP8hRBUKDY612zkkouUkxyqI/15q1QNkRlGp02yc7ELkoGWAxlv1fzcaSo5pY23evEfvcGa723lsuBSrhkJ8Jlhp+EsfCyt+oay9HzinAdSdCIpTiCCAQkCJrtanQNA5grfMBJuIejKcGnGkWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hC9xZOH8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f4a817f1e5so97058b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132207; x=1715737007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFSJQnmxYmfjoFDImtU4VL6iWxbfob1tPsjHMgxh4E4=;
        b=hC9xZOH8ijF3CnS3r0NotAGEhR/x1LruMi9LSeeLhdesfs7YUDJVVc1CdtqHhMXziL
         mFaeYYi+BJrx7YewtPx6bMMtPEcXGvcvWuk8+V4LO9sLp0ERek6dZSUaX2llZiBHn9tG
         JnAGkW0rvYE/fCvb90Qz/cOshGUEy8a7PrOhrLOYzOfl4HdMXwPh4/8bi2nAPAZHJ8J4
         d0osYqAkU5a4gAL47LOu2VHE2lAop69ieASqAVfLx0xZ/c4lg2os6Qh+VsJPYjHbLfsf
         P80C3IuixnXXUS0bhY9aN7Umm7m/qur3RDxOtJG87Icm+5W+qAZhkbl3d7ubWzfkvzv0
         uReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132207; x=1715737007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFSJQnmxYmfjoFDImtU4VL6iWxbfob1tPsjHMgxh4E4=;
        b=PDMGW9mr+wC2Kjs31xA1uF/WzxRTdvifLXaAQe9A7h5kzE9FB7sdGccouc2R5vN9yd
         Iz7sSOmHn7ZchJEiMsyGIvQjquJmgUOgdZ4jfMU/hvT7zBtbL7hEfCBjjNJ0Vub1wcwb
         a+a4zcMLQQPf2/lPpha4YLjA0EDNzc2T6yuqpO5+JkM9KVvO1Wwk8FIaDJ+4/S0IvtNw
         oXyF4d+ZWdQrgzuBdmBg0s+csXEA1LJ6xfmLQzbZQWFz5xQeAp2ysAN1F+G4RG9+OSvG
         NUlNos/uF1M+dsFwFm1ru1tNzg3Pc8KQECE+sMRCq/X9rO9lvxfMILxskNkUIqW11b91
         1bJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKnusdEhYCERFUwVJ568HhdihV+mwzFO8ddtKYdzYtLrmAN6/9H5xkRVuT1Mqqvj35tfEkgr1cRLdxbm3rZhzVQqI+pPk61HTbKPQQ
X-Gm-Message-State: AOJu0YwFgHWSexJn0efoHGgStxJu7aalGw7wCpPlK77Fl+/zibKPH5Up
	UohGIL05EnK8Mq7EAe4VjhJUAhkOtxc1nz+KXuP0ETMnLwLttz93zX1MfG9yPkg=
X-Google-Smtp-Source: AGHT+IGyPdvmy6aV3B3L4umYWWDDY8xIoU7bUJV2TUBvLWRK8ohQMMF3SW0DKxfoVvgynUcDHsYrOA==
X-Received: by 2002:a05:6a21:2715:b0:1a9:5b1e:4f06 with SMTP id adf61e73a8af0-1afc8e045e8mr1232295637.52.1715132207095;
        Tue, 07 May 2024 18:36:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:46 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 May 2024 18:36:30 -0700
Subject: [PATCH v2 4/8] riscv: Move RISCV_ISA_SVPBMT to Kconfig.isa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-compile_kernel_with_extensions-v2-4-722c21c328c6@rivosinc.com>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
In-Reply-To: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=2196;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hN6gBReRWF4tyaALzLlv0FO1iXf71FwbEQWuRR1cn6U=;
 b=rwmUivRGvDcoS+kvi09gdGx7PVj/grlp+Tad0aawkK1yi6IcKtZer2CtyNjel3SZbguaXYzst
 2GPHvUxb7LyAOvNrFFBjRTs73lBl91FO/UMmx/qaiWyoJ8A6E4MRt+T
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
so just move the definition of RISCV_ISA_SVPBMT to Kconfig.isa.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig     | 17 -----------------
 arch/riscv/Kconfig.isa | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3c1960e8cd7c..47a1d28bbb64 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -484,23 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
 	help
 	  Allows early patching of the kernel for special errata
 
-config RISCV_ISA_SVPBMT
-	bool "Svpbmt extension support for supervisor mode page-based memory types"
-	depends on 64BIT && MMU
-	depends on RISCV_ALTERNATIVE
-	default y
-	help
-	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
-	   page-based memory types) in the kernel when it is detected at boot.
-
-	   The memory type for a page contains a combination of attributes
-	   that indicate the cacheability, idempotency, and ordering
-	   properties for access to that page.
-
-	   The Svpbmt extension is only available on 64-bit cpus.
-
-	   If you don't know what to do here, say Y.
-
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
index 37585bcd763e..50e217dc5719 100644
--- a/arch/riscv/Kconfig.isa
+++ b/arch/riscv/Kconfig.isa
@@ -168,3 +168,20 @@ config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
 	  not support Svnapot.
 
 endchoice
+
+config RISCV_ISA_SVPBMT
+	bool "Svpbmt extension support for supervisor mode page-based memory types"
+	depends on 64BIT && MMU
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
+	   page-based memory types) in the kernel when it is detected at boot.
+
+	   The memory type for a page contains a combination of attributes
+	   that indicate the cacheability, idempotency, and ordering
+	   properties for access to that page.
+
+	   The Svpbmt extension is only available on 64-bit cpus.
+
+	   If you don't know what to do here, say Y.

-- 
2.44.0


