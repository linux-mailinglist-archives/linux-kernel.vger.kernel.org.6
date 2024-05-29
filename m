Return-Path: <linux-kernel+bounces-194444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661968D3C68
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9747E1C20938
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E718410F;
	Wed, 29 May 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kZ9TDDZe"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BFE576
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000137; cv=none; b=jiTn1u8HWEV3eZmt5ZtwEPH7wrorGU/kTC0wvBnl4FERTkJ5LJ6tviHWm9qXsxIavijD3Ofe7zoxFMSvb1xC/KAbuNcbrZNZxgxb5zI5M0E+xVN44y0S0gNnIOkfdzvfl/rVQly864JuEo8YWP7AVml1A2I8Azxva/aFAaQy5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000137; c=relaxed/simple;
	bh=icyHIxfCfGWGVMOv7yKdVBJE57WXOLktHYCwRxc9jSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSenoTYWr9jwS7jY5aKL/F/1xcvXKtEaTyq26M79WXHyiE42w2t2UOSBG1XAMpZ8vGCkl6NOXIA3CqqpiF3WPwc/HCt9YOGqbuildNs9fFZpZAvBvlAlZwcs1WVj6gJJgDTkhAI6STQAawEJsw06ihq8awTuVaW4+ZGVWKcvH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kZ9TDDZe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f32448e8fbso16792755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717000135; x=1717604935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUKf6RPGHkE9ueRDvwJp4yAPIvOh2riYCScZzEfcavE=;
        b=kZ9TDDZeUz4dIPXXKyzvpLP4ucd2EIe2T0MBvCC5oCh+jHUINTXd0pIKtF/A3QUnpg
         k94LsmXZCrUt9sq7bArB810Dm8xwSFAgXFfjhQ6L97ReV9qb5MhIK4X1N6ud3taInKsf
         rlx6zG8+Gwc9aCq2naHwed19lfV3rqVYpN/bPPreuQw5qY0Q3YnR88GAplpGqhMpFS49
         RSCzy6iPkCWM2X4KNoT4LZXpxwL6J+2+ZH0wIFzDFM4ju8wIp7XWiEppKtowsxl+cOCq
         JbxSxq2TX6NaInXRmVifdGaKK+oRC+pnYIQZQHhkFdVaWPoTeUaTvxeqQwFX5odBS/VZ
         LcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717000135; x=1717604935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUKf6RPGHkE9ueRDvwJp4yAPIvOh2riYCScZzEfcavE=;
        b=DUKgADJiOhZ7dkbGCUrVt7tg+eubhwFSSpjVabwgo2ZE+Gdqe9xD0AOD4mcexfqJC4
         n9R1pv37Oa0YwOWZ5n523kwiqBWTYknr1VvRVl2EKFgmdiAIfg8PM9gY+R6TARBFw1V/
         0/D/wNzhUyRcLdejnjITFNw2Yhi0QXZfXjT2vo+fhQCU81oMjCg0ZVIzxEbkjc4+A58e
         +IFEg1j0uCKGKAgV6Q8lMwjw1R4kMLOJAxF3t9v77XLKgsiDvi4Q5YJMtiVtYw9u5COj
         wqNwKKBfFBht/i6fme4z+Lw6J0wYTUUEfvypVtCVpligd1IU/hktLcbAltLG5HAgOUnw
         AElA==
X-Forwarded-Encrypted: i=1; AJvYcCU3vgaAT7K0K2BS3oBOurwZr55NMKrNimSi8mNSPVXy/ABLVGD2rOpkmU6A6l4XHPYJvRsdhcBoD0HRMcTFcPxsEHwT+6B1J6oyQJnN
X-Gm-Message-State: AOJu0Yw7xMBlhhjXh2Iux2yJxe4oGYTeoaJNXoHJMvoBvYtRiitDa0ce
	SVt6KZzY51QoPYEws18clFzWSkvrnrI+e+nhb1PVSdSViClmceHpAsxpIH+7DHY=
X-Google-Smtp-Source: AGHT+IEjVPCvcjtvs+arO36qgagTdadtsaeqU3GiNIZQ/tvSccsvX/2ca/K2QWSCF0VhUZl8F1kyfA==
X-Received: by 2002:a17:902:c943:b0:1f4:64ba:af9f with SMTP id d9443c01a7336-1f464bab2f7mr139578315ad.48.1717000134988;
        Wed, 29 May 2024 09:28:54 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a88e0sm101756305ad.231.2024.05.29.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 09:28:54 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	kernel test robot <lkp@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64
Date: Wed, 29 May 2024 09:28:50 -0700
Message-ID: <20240529162852.1209-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building a 32-bit kernel, some toolchains do not allow mixing soft
float and hard float object files:

    LD      vmlinux.o
  powerpc64le-unknown-linux-musl-ld: lib/test_fpu_impl.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
  powerpc64le-unknown-linux-musl-ld: failed to merge target specific data of file lib/test_fpu_impl.o
  make[2]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 1
  make[1]: *** [Makefile:1152: vmlinux_o] Error 2
  make: *** [Makefile:240: __sub-make] Error 2

This is not an issue when building a 64-bit kernel. To unbreak the
build, limit ARCH_HAS_KERNEL_FPU_SUPPORT to 64-bit kernels. This is okay
because the only real user of this option, amdgpu, was previously
limited to PPC64 anyway; see commit a28e4b672f04 ("drm/amd/display: use
ARCH_HAS_KERNEL_FPU_SUPPORT").

Fixes: 01db473e1aa3 ("powerpc: implement ARCH_HAS_KERNEL_FPU_SUPPORT")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405250851.Z4daYSWG-lkp@intel.com/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net/
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3c968f2f4ac4..c88c6d46a5bc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,7 +137,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_HUGEPD			if HUGETLB_PAGE
 	select ARCH_HAS_KCOV
-	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC_FPU
+	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC64 && PPC_FPU
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEMREMAP_COMPAT_ALIGN	if PPC_64S_HASH_MMU
-- 
2.44.1


