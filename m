Return-Path: <linux-kernel+bounces-263688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6893D95B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3363EB2274A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDC6F2F8;
	Fri, 26 Jul 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/26VhSd"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C221364
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023781; cv=none; b=oGNVtOnh2UqP7Zd69ieJhhWWO1VDZdSulZDqtgImeKBiKgyGKsJwnU2kPfQ9S3L8Ov1AxXwtNIKO8zWkiO7o7PcA/K233NuwOqqi59aAxLCtvtaPqtOg8GEuPETRXFOC8uN7oq0ANb88Abp7/2VhXNIADdBMEfpsI4pL0NenhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023781; c=relaxed/simple;
	bh=sRcCRao7d+tv6NBNsGuiA54eu+hbc9ys/QpZ5xW/oD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnDZNNK+nUU2hkTYn3ev7A/n+hAy0niDHQoYcaDljb4Jalp5f3quUOCK2rqILXPU/PfJveWYU6GOy7O3guQNdVXafzpVL9OfNWN/qfjBjMU/MWWhnbLIzBQa4eSumtvHDudIXWIViv4bHNcj6lpufBxiAYTfBmKrbUnkbhtfow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/26VhSd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so1597083a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023778; x=1722628578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNC1iFflpOKZrYRO3UiRkF7BbSH5iWuXNrct4OPAMaA=;
        b=S/26VhSddKy51pgYKsCFHjdGwbhkG0toQej4Mxrcepy+5iixmZFx+VsmLENffE5UvG
         ylUqU8yppQr6UqaIGD/jJXO8lXPBPeLyZVEWuHkqi6zNK8HlbSxqbKg3PwjB1WhfDLsV
         ZGfM7aSn7z4/yvajUryJnqHz/RMEKvv90CJxOskpDk5ZSkxHFAGu6kDaG3EInB2yj3rN
         6XnigeWfvrtKdsqMdf0HV+3gNSHE2xB+iRd76bHHv8WVE8ppnLi2nqXZnNxNzhZ8QeWc
         g/Mne1z0s4i8qSdfxl1YSRgxDbnS+uBJFI0DbJTD/Ls45xaAkoOAkv79SeBFmZ0BqmB8
         aNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023778; x=1722628578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNC1iFflpOKZrYRO3UiRkF7BbSH5iWuXNrct4OPAMaA=;
        b=CLdihNyHir+zojt8AZO/UeF6oSuUHYV7d3FACTYU3FKA+OME4gkLYeriNa9VYoZmYv
         uTxnT6OX9ptE2noO9OabndN7Xm3Tt8qNKGZhcPwDbUjB418JT0xaVcSNxtrWXUJ+0YQX
         ZJMq+MSvU5k6WgtXeUKk9edz/hzO2zX2LRr5INZS5IsHgJWk14fhKhNg0ySVQf3/Gtlz
         8kAFjbyoikA9WcCmrLy0M205FwR4SWLMeS33m0GHiDJyd+AHrWfbpInppWtpkRsN4a8H
         SKVmqtFrV3iplFIgKYbE+sDPr126KPEUI1aVO9dPiUqMXModVXCJmYDGFGlZeFFK/C3G
         PWNw==
X-Forwarded-Encrypted: i=1; AJvYcCWebeIKY4sA1ssJfzZnqI0i/qfu8P8+on8DWgKMTM6uYyLXY89hx3gscbIjHMwhP4CE2Q8rfPx4llMq+dt2Vyy2BU8Fe2GOwjG6XzyW
X-Gm-Message-State: AOJu0YxKD9qerfv/3tzX/QI9Ui3NkFFCVwO7Nv0Q4pBfVXY8+n2TGjUA
	OSE/3sugBH8yJlVrxT/jRcFuCwj9TbYfBIThH3u0Zs5lUye4SpmVfoxycQVk
X-Google-Smtp-Source: AGHT+IFyVhFxohOhYUEXGWlsbl85l4mFVEnRcGJFNKLXRhr7VnJDmRhU06aNwgbJmYCEQguP7a+6RQ==
X-Received: by 2002:a05:6402:3585:b0:57c:c171:2fb6 with SMTP id 4fb4d7f45d1cf-5b016cda868mr680216a12.1.1722023777948;
        Fri, 26 Jul 2024 12:56:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:a04:10eb:2f96:d20c:b4d3:e989])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377d724sm2296859a12.40.2024.07.26.12.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:56:17 -0700 (PDT)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [v3] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for compressed kernel image
Date: Fri, 26 Jul 2024 21:55:28 +0200
Message-ID: <20240726195614.18122-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The COMPRESSED_INSTALL kconfig does not sound very meaningful.

Rename from COMPRESSED_INSTALL kconfig to KERNEL_IMAGE_COMPRESSED_INSTALL.

Fixes: commit 4c7be57f2 ("arm64: allow installing compressed image by default")
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/arm64/Kconfig  | 4 ++--
 arch/arm64/Makefile | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ae527d1d409f..d9f771c788d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2337,8 +2337,8 @@ config EFI
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
-config COMPRESSED_INSTALL
-	bool "Install compressed image by default"
+config KERNEL_IMAGE_COMPRESSED_INSTALL
+	bool "Install compressed kernel image by default"
 	help
 	  This makes the regular "make install" install the compressed
 	  image we built, not the legacy uncompressed one.
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f6bc3da1ef11..1d9b4978eb98 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -182,7 +182,7 @@ $(BOOT_TARGETS): vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-ifeq ($(CONFIG_COMPRESSED_INSTALL),y)
+ifeq ($(CONFIG_KERNEL_IMAGE_COMPRESSED_INSTALL),y)
  DEFAULT_KBUILD_IMAGE = $(KBUILD_IMAGE)
 else
  DEFAULT_KBUILD_IMAGE = $(boot)/Image
@@ -235,8 +235,8 @@ define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
   echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)'
-  echo  '  install       - Install kernel (compressed if COMPRESSED_INSTALL set)'
-  echo  '  zinstall      - Install compressed kernel'
+  echo  '  install       - Install kernel image (compressed if KERNEL_IMAGE_COMPRESSED_INSTALL is set)'
+  echo  '  zinstall      - Install compressed kernel image'
   echo  '                  Install using (your) ~/bin/installkernel or'
   echo  '                  (distribution) /sbin/installkernel or'
   echo  '                  install to $$(INSTALL_PATH) and run lilo'
-- 
2.45.2


