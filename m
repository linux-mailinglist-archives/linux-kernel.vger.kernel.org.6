Return-Path: <linux-kernel+bounces-170562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548158BD925
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7AE283E16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86AFC122;
	Tue,  7 May 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ROFT6mJ+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE485139F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046168; cv=none; b=ClXyY6b4UnyOoqM8lX/dhW/dH4JIQKRZV4QXOsHGpXTnCaoZK/8dZfj6rWcfECyuxXBYhATAOGB65zWSy4rb+D5pS4H56e7gZeq9/5E0Mm2BTEOTuIXcqeUIyHb066TFdWGa4q+s8qpCAlf9rSrPAloF5uZEaM+oJ0B3GdwKlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046168; c=relaxed/simple;
	bh=a5uHrD6/CgdRcxiHblwyx5kXSDkE21WZp1cyzlXEWj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC1FJ+OLSemF0Q2YTgGoaOkq7KVClcRaiiCc1T/WbFDTYTimSgab57j0jtP6PRxHyqkXKZwwDXoorTbuGB8XFZ8uU5OA3q3P0GmdNfkg7KaBtgTLcVmceWv4RDypdnvxCEC3fvGktucJmyP2PvGB784ADOst0+u49mqRXjvFMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ROFT6mJ+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee12baa01cso11784345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046166; x=1715650966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1rtoP2W5LhxJ+J8dI0kYwFURphSK1JVHizOP2fywoc=;
        b=ROFT6mJ+FPOp+gt60c3VamzE6ROd+1iVR7IwQEG8qLZZ0wKVsLIhet9f3Bt5C+OAOx
         M7XA9cxgBlJtYBAvG6fSs5Lh4gwpL3sQlLsoJ5CIvC2KqDiaT1cllvmjnIBKqD3YeLHt
         0mt7oYxVKwFIW7r8hwrP2EdK7IFem9w/3VzbRLDRgiBGgm8wRkhhes+i6gY40LbRVGx7
         Bg7Y9kinmJKrr2LsQkD+E5gJaIztW26KRSFKNV9VOajXHwpc9bxDdyo81ZLrQeclqJ5L
         lfmNR0tWWRmY7DL7kSk09BCZOqb3w5nKoEAeaDyQqMigY+fCQ2p/Qad8OqyCjvIuzu7f
         2GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046166; x=1715650966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1rtoP2W5LhxJ+J8dI0kYwFURphSK1JVHizOP2fywoc=;
        b=hhkNRCUVp59AOFflPMDacVJng6PwWCj3W83u2lTQS3RO+JbCDIPRdu51XDdhwNE227
         FH6XcoUr7tgnS0u7heUEbUSeXR9wquFqNVG4/YqfCuS5ZBseRYFsOOMdNjMVo5AppmGL
         FO55ua+hGlAMd9z19ffsElh2RtfpkC1VONeS8Zl+DmMnEFJNd7HUHTUwUFFc6ll2FBGd
         Pm6SLFJBJyflCGLwiQFaTrNsqZqiMTKjXadRYqOZawY+5aQP9F1WeIk4cbNQRTFhaWO3
         D65II15GqPFzY/+8vSRURZQJxfNmeZ52kvkBDihEK4wykouyjqFxSnMJ6H+pslzAX9EW
         60lw==
X-Forwarded-Encrypted: i=1; AJvYcCUKubqXP+MFX0bercX+zAJrR8pbSR4IpXJ4XsFWRDWPqUdXUjGQztcZuJlcSZm0jZC9ztdDMH0/gqv9XvDvt/cHSs1lQAoozUEncjcS
X-Gm-Message-State: AOJu0YzHzfj5H7WWAY28Fav75LqIMdk3DkXl5/+j1u7XoGap8yFJomHt
	AlSFSXVmHsFwK6DGc1TAaNy1HbEnQdUxisVilsTrckQvXHEhu+NBFUoo/369Iac=
X-Google-Smtp-Source: AGHT+IEvpciP1sfAIndVjOWdRz7vLHFzpcSQrwQgsqgVau2eSxQs0m4E49rHQF2sOcXRyHJSXo6dDQ==
X-Received: by 2002:a17:90a:6fc7:b0:2aa:b57c:b178 with SMTP id e65-20020a17090a6fc700b002aab57cb178mr12019684pjk.34.1715046165806;
        Mon, 06 May 2024 18:42:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:45 -0700
Subject: [PATCH 4/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
 Kconfig option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-4-5c25c134c097@rivosinc.com>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
In-Reply-To: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=2246;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=a5uHrD6/CgdRcxiHblwyx5kXSDkE21WZp1cyzlXEWj4=;
 b=bnTpAsp3Zw5Pq5X+mO5DVW5pxHHKVy8FUw83Bk2bzxERC5XixN3igHc8XRzJzdAfFDd6F0ZpQ
 qURkHGNHFlyCgGYDPobEFSDYFLG17QZXDtd4VvfBloYF51Nv4e0BVtE
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
so just rename RISCV_ISA_SVPBMT to PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
and move the definition to Kconfig.isa.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig     | 17 -----------------
 arch/riscv/Kconfig.isa | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9c3a4347953b..22303a3ab59e 100644
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


