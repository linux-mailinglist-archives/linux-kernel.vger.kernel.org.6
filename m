Return-Path: <linux-kernel+bounces-263685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E993D944
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60431C20619
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B88481B7;
	Fri, 26 Jul 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9N6lIiG"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648346BF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023467; cv=none; b=WCMFgNSD5Dp9pbcUDRegXQDPT9+3SZuNkxirmagOIfz97igz5BQfhBK5YC7MEgpP3JivmWPgmhT81BBfRkT3p5/VxDSVXD0/A0jKnF4IUPJgzpt7cINUJ6uANvDS3lXaemWS67ngLeSOwwHmZ12ksc3dSPcVgY/F0ab/PUSlty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023467; c=relaxed/simple;
	bh=YeskAltTQzlC47jZ1MS0lqeZvulpciFxb1Gzx+atm08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gcwk0h+gSiaF5xD41HyL2wr0zArfvTtZjT5cAZiK3hG/xJ6v5zrGaEcbMMUWXRI/GVDM3CKROhpnFPxR71sZVsaRcdd+wx42YMbKY+ACowqAFbGKMohAMfkPGalS/0iMmOVB8JqbGBG0QsKvbjRno0D3SseJYjltwYEI3d7BZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9N6lIiG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a94478a4eso356897866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023465; x=1722628265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9GHm1lV+GkpwthmS6vXwJOCiqGKh1/0V5IGa1ljfYnE=;
        b=d9N6lIiG4Sh7wRXM9OYgppzjGmksjsv34FhU4iW/gjUsYVOUHjJt8b4vMaUk76NYZq
         u8JEUTjXBHY0A9a/lsOMLdO8LRWV7LJiYIGE9Cwum/aLqrEOkUxhHcDKpVf+ZcA/4LHC
         ZMrjNKfrC1Mu4ExqLrVbpKaGSm9Obkwo7EuzKZEa95q85v/q6RVmLEN2WKn10drohOv7
         pUVPW+lJcuFEkYZdwzqEIvKHp+b3wjq8lD5JwrUwojudYn/8GOI52UUrjTlBRnxFKIqo
         5K7lcyfvIB50Fwiyoqm1SBAg2RK/pXOPZaW8EAI3LebBVzBVyxPgUYLQs+DNP2kM0Khq
         C7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023465; x=1722628265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GHm1lV+GkpwthmS6vXwJOCiqGKh1/0V5IGa1ljfYnE=;
        b=cMkPwMAYnz+eL7iY6fywb9CmsVb51SHmgepZXuV8WrA7AjpzbbUvafdMQgNwhgwrbQ
         kDqloBCZrOYDf4LNvzVqq8CNYuufHU0oSv3JGzcf3ozPvs4UVLsYP8kHf9DdieQNhFmV
         3sMHJPILQf9l0I07qXH1PkHG1Dbq5lhHFwBHAqEzNTsxqZIHw9+utslEtSGUMTq1d0Mz
         KZaBAocol34WucBCFNGC2CRsylSOIiPAFXogSTk+qiO+0cu6QaZ07cglUZWsKtTGpfyC
         RA5sVOzlWPxdsDSpSVpjeAZOL6OZcVlt2MqcghoQS3P60iiFs4QQSfcVraoGUrLVYWi9
         DzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhjq6xv2GTUk1QK2i77RtFlLLzNqv7ibmGzwulhmqMGm/6etJMYfGfuwUMorHrcugEAeKbZU5pjwYQjLJdim5gxVbh4Zsm+3dZ7jZJ
X-Gm-Message-State: AOJu0YxNSVKh+JDT7ly2X9d4UG6G58zVeA1lzm92/Zd3gh75xWufKtAP
	onlWcAuXopxRVCtT7CtRCt135EPlLcNwDP7y96kJ3l0WSyfcfO3o
X-Google-Smtp-Source: AGHT+IHfv90s5TByMTxEDx8GLuZ0FJYSDW8mRpHAjKudIVdzZlmiiq5svPHxQM8PpMEn+uUY0sZsxg==
X-Received: by 2002:a17:906:bc24:b0:a7a:1c7b:dc17 with SMTP id a640c23a62f3a-a7d3fa0ab43mr53172666b.22.1722023464297;
        Fri, 26 Jul 2024 12:51:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:a04:10eb:2f96:d20c:b4d3:e989])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2316dsm210647466b.2.2024.07.26.12.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:51:03 -0700 (PDT)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [v2] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for compressed kernel image
Date: Fri, 26 Jul 2024 21:49:36 +0200
Message-ID: <20240726195044.18004-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The COMPRESSED_INSTALL does not sound very meaningful.

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


