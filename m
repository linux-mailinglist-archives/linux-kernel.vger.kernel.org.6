Return-Path: <linux-kernel+bounces-174017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC508C0932
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FC81C20F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7972A2C683;
	Thu,  9 May 2024 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PJuFv5I7"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D228DDF
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218651; cv=none; b=fgLlOUaJPJbCMt76yBwYEsiRlIpBi/RB8xUXx9WqE9kjB0VadEqOIUT4ywkByyCBf9Ky43AL/mpvucbFQSc9QB+/1PAaBMftSix0KWqFJar1ElXNldAkIkK0y0+fo2S2XHOilahYbkNxh6FOap/AM2VlxRjfmzZoNQ9jQNyA2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218651; c=relaxed/simple;
	bh=bcfj/xRt+O38cd3vdFpTeGSWOTlfbp0sILXb+gyTHlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g35kd0xVD0VBl1yTQ8YY3W/Zb5BHBZlStpgO//17E6uIGvufvGtc5dCnGEh5tsTnqGAqGjD/ZNUitXM/rwiCnbgpGHWbT3eTZmAs8ViOf0tWAQlvtYWO+gm+q+KwYvfrJcTj+B+4REvHV714LOlUXOvpll3gK3Kfwza8wkpGVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PJuFv5I7; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e185d61f2aso14996039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715218649; x=1715823449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8nEiAnrrvoqrUnhic8kVR/TQCD7dz1dJX6ammFBF+s=;
        b=PJuFv5I7lcWb+646x7rw6VXtO928worfITtThpurvskUB84cYLZ7SyAm223LULGlgv
         LDt8JIShO3GRYy4qLpEJZgWuR/4Uaj5yHKwHQI9OJrdYIXSFkP/dYydu7iKd3+amiPJD
         Vw6TkWB7dKUO216UekDRxhxjcFUh/nspreMx1pCtD+Dyd5pN0vHESEB9VvXuL/ciM/i/
         BRlOp8KXXiOouvGAHrztOpNBfJsJccCjvobFYaBAZGzlDsHu5W8fWSzibVl8KvlEMlEi
         xBd9T8T0ZCRbWz5lLplJewF5pCom8ZqXYzzSBUlxnze1s264PQvb78NnMX/UiPWLleKy
         pLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715218649; x=1715823449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8nEiAnrrvoqrUnhic8kVR/TQCD7dz1dJX6ammFBF+s=;
        b=DzWkfIa9DkbnSGA/syOxIeX8iqqQpP7wrTyb1VY8AiPH4wZbs+NmpHRvXPeHTpBKhp
         dNIEtviA+cRtQGKwp9ay+osRRQ7s7nFfty4Y2kRTxCA+IdQJ0JTFdp+xeuLlrWtkAqxS
         fLU8gljKtf7sWbvFbWvc224tbhQJu2jrmGWUrraDxJimeK+/qmO9pE+fqHFAMJHN6Ql+
         etvgfR2/MIk2p+LG9EM1rIYRNCXz9r49HMZv1dMwmagc9VifI2obyaRLwpubU8GGSSi2
         Q2gcPEmfp7Vk8FKE+6ofUOK3LT2PdU+ofJ3DaMOC4qrXaP4PmlFYI8/5NcMzyROkOY1W
         TB4A==
X-Gm-Message-State: AOJu0YxuO2wn/u9cdb3LoYbVm1yKUxaYCkM0KyEXzVcNkvXRcaVJPq/3
	DRXQSSD3C0JENVVLAQRDGTUwvLz+gn6SjjFsGpErd69xfSXyaHdgp1QBRNizad8=
X-Google-Smtp-Source: AGHT+IHpSD4lyUmHxlYUauGGuGqZjazTVD9fSRC10uwBI/bVjd4EXQ/hPAJ0qb89iSq4E50z09RmTg==
X-Received: by 2002:a05:6e02:20ea:b0:36c:4688:85aa with SMTP id e9e14a558f8ab-36caece2c35mr49616085ab.10.1715218649330;
        Wed, 08 May 2024 18:37:29 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634117191f1sm178084a12.90.2024.05.08.18.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:37:28 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] ARM: Do not select ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed,  8 May 2024 18:37:10 -0700
Message-ID: <20240509013727.648600-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit ARM, conversions between `double` and `long long` require
runtime library support. Since the kernel does not currently provide
this library support, the amdgpu driver fails to build:

  ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

As Arnd reports, there are likely no 32-bit ARM platforms which can use
the amdgpu driver anyway, due to lack of features like 64-bit
prefetchable BARs. Since amdgpu is currently the only real user of
ARCH_HAS_KERNEL_FPU_SUPPORT, drop support for this option instead of
bothering to implement the library functions.

Fixes: 12624fe2d707 ("ARM: implement ARCH_HAS_KERNEL_FPU_SUPPORT")
Reported-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Closes: https://lore.kernel.org/lkml/87wmp4oo3y.fsf@linaro.org/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404042327.jRpt81kP-lkp@intel.com/
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1751c2cab87..b14aed3a17ab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,7 +15,6 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
-	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
-- 
2.44.0


