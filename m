Return-Path: <linux-kernel+bounces-263711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3F93D991
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11859B224B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CDD502B1;
	Fri, 26 Jul 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSEAiKgA"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F601F5E6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024621; cv=none; b=i1IYXY+E5GnHduULiHg3TDF5FfKX+QLYO8G5NhjXmSaCbJxJY5BqlG6EYncTV4yzr7iSVIHiEFqpty0BAHUFZUfnEiLYIVTcvLmtwfz+8Q0fORfZE3N8gg0RIoUBXJ3BRa5YwX+zhApYXnhEOv3N9971u0Z+mGLPLl+QMlF6RoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024621; c=relaxed/simple;
	bh=VZ3QfugxCdWt6rfoBzNydYx+yd0WaZlzb1yBDH+BFyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYgj7ikNKIufOQjRT07wNInNicYJSDtrUzsPX8DQnmfMvYCM5B3WxoQTq4oJd5DChNyZtIxsiP85yyV8RiHrrx09vK40S8ggrQF8zMxoTB0gi+bPJOdV8ix8kNgreegX5EHxP3+dETHlIYccMCmFaxQjlld0DFprB+vC4JLAF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSEAiKgA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so19933611fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722024618; x=1722629418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYTOPWJHkgJxxfizvD3caevO/P3vRLKec9Crctj8j8M=;
        b=XSEAiKgAnMAiCJ2YvFGbeIoZt60UyqbCDPT6hKpC0DAi96+VuAW0f/ysd67Dro1+Rf
         UxIUsAvgFOaxmDdpx0dX9P1sqRPxrzVpAeU7/BpDner2c9hSlxeN1vBGJJHdufRlvsTp
         AN950DCUkfjEWrffTE6bSzsR+v3AmNTtkiMmKH4hFOhs4YDsJZu1Bwd44lkB8d/WOf4c
         TuYbBkYn46Hypq1BwSgFx1Kg2yLEjLYXVFcv9PCrLON2fceqE7bypTKFInXn5vF8aLfx
         TA7VBt7+RY7v7vqxrtIT78Eu4qKsve+LqBmCYjvCVglq9afvdj12NDcIyAHy1hvYsH3T
         tRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024618; x=1722629418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYTOPWJHkgJxxfizvD3caevO/P3vRLKec9Crctj8j8M=;
        b=JTg06gDL3Ojbm19YRmcwBgssr8t6o63CbhOHWbeLeDsD2qvm8HWMkad1n7azPbaoRH
         wzjAOJN35iXOmYfBVkDKN/eO56fHoBv1mOwhEe4oNXf5akLSp8+Kf5CzdDDJKgwJNKHk
         m59m4XMSkLdPPy5rb7+jnrhnCnC47y8miYZtI//rV+hAes31NL9IEOFLgXc+vkD8V62+
         3O4yREsZhoVEr1m4C4njzlkwsZPUgkmuDfKVf2s1wFow7wJeNasO0q50y59F3h947A/i
         8rb8iq7lvLAVO7KxTxJ3wy9bj3d1GG1WW/1Mc9nNhJUGRFUV2MFk11IS0lthNbatoMLk
         JkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAtGS98szL3XLAhh50T1nrYCEKUs1DQB3XAhv0kkLJcBeijODe1C7+tHl7CCakrctUSCnCEemho+lAXr2ywXeLq0mD4i6gZWzZpcH/
X-Gm-Message-State: AOJu0YzNyKUsMb21eZf4AmczXV4+OrqDL2LdgeTTHd11XhmcX8sD6Tse
	BHZ8T6y6Atiy8Mw8EeZMCJ4s9ZjVGnkKNc/ylCBXIKWBlFC+lgnwjl81EA1f
X-Google-Smtp-Source: AGHT+IFzF3aDLwsx+BWp5qqaeg19MV9AztxQhZQ3jFB7uE4QSZnckgqmDYIievoSx7HlTapIjVgWuA==
X-Received: by 2002:a2e:9259:0:b0:2ec:5933:a62c with SMTP id 38308e7fff4ca-2f12edd688bmr4762641fa.22.1722024618048;
        Fri, 26 Jul 2024 13:10:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:a04:10eb:2f96:d20c:b4d3:e989])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3ab8sm2312191a12.71.2024.07.26.13.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:10:17 -0700 (PDT)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [v4] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for compressed kernel image
Date: Fri, 26 Jul 2024 22:09:30 +0200
Message-ID: <20240726201014.18484-1-sedat.dilek@gmail.com>
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
 arch/arm64/Kconfig  | 6 +++---
 arch/arm64/Makefile | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ae527d1d409f..044527499022 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2337,11 +2337,11 @@ config EFI
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
-config COMPRESSED_INSTALL
-	bool "Install compressed image by default"
+config KERNEL_IMAGE_COMPRESSED_INSTALL
+	bool "Install compressed kernel image by default"
 	help
 	  This makes the regular "make install" install the compressed
-	  image we built, not the legacy uncompressed one.
+	  kernel image we built, not the legacy uncompressed one.
 
 	  You can check that a compressed image works for you by doing
 	  "make zinstall" first, and verifying that everything is fine
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


