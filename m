Return-Path: <linux-kernel+bounces-168806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FE08BBDDA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B902823F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729084D3E;
	Sat,  4 May 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="T7kiPB7M"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390F84A39
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714851297; cv=none; b=kIXUA8zV25jox158RaDPFe5/+HEyv5Sgc7lixVVr0u+i++v1P8vgS3clpIPkqFfWE5uk7GaB/cUGdzL1iCeVbMdNIE2KYSBrP8slQarJZHJ9uTpF8bCEJaJMnFS39hgC8v/3K7pn/9Ssq/Fn/mB7BvGAJYTKrjxc/4bKAIiaORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714851297; c=relaxed/simple;
	bh=XEaqV9XPEDvIoeqoy5YW/LRhIP0/gA4kZoNFKJC8XUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iB3RXBc3jgEuGvXs+LwZmPXVh9Db167NT8dfagd1lZQChpiNoMmA9sdnQ3otnYz3K2xnZHpKvfpwIlNR2SkqVDqrIz1odvDV4PwcEaEKpYw46HWkkx7iBoOQ39xHZSpcfUVvx7NaG2ewTSrWtIJQvh3aY8a9NzeEsCJLfF24/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=T7kiPB7M; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 348E03FE64
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714851293;
	bh=oOLIaUL1ksCYikVh+tjyK0yztXrep94eIS+0vADjCFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=T7kiPB7MBIDBSTS+WShQ6lVKQurjj5c24WM5s+BsIUmizQDQGwZiB4raNsYwcGFUI
	 KFOleLHiRPIxQIx5hU4hIQ1UAnL+BeWvFYvOIustYtQzqBpdTjSQuHwwBdjcnAytTB
	 iS97DNWQkhNgfP1BWKVunY1/Fb3X/Rw0eNXy0ifUD7AZQkg1j0y9zRUCEUfv/BkYVg
	 ti6ewuu6+wVubZH7HOJ1/ISf8cxdM6Ixh5oj0bSI7V18qSvtkalBzNn2PP/e2crAqA
	 tGEGJcqzXSu+Xfyf+QFPGNaiEVqactq00yR1oNPTT7IkhREfQ/y6RMwNyxmkGfxOJH
	 yUIwuUCDp4fAA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51acf7c214so22154466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 12:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714851291; x=1715456091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOLIaUL1ksCYikVh+tjyK0yztXrep94eIS+0vADjCFU=;
        b=LvlEhEQrmzM1bRV0FSTXMMqZSiCCvZuQhzkoWt12ZvLSzW5o4qE1hFa9IhXPC70bUy
         D8+mvaTfUVxrKSHwPv0fmQRq/Xkwto4ydhQtlcCq1WEA3nRseyqtHGAS39SsMdq15Gkm
         kUkAQmKbgFQAvlxEyfCT3vf4RCbk2cZw7bcAWYuqhEjOjXPWWJGzlzzfnGkenNA4m9r0
         kSTEty57LAyRuk8P6oLZY0Pt08Raitg9QqtP930W73kOesYJC5bMkWPi2CUehW2DJADt
         /hlq1H6mCDg6VdTGqRKUpZg2IPmBqKW43G69yvv5H3g65+Bdr5rBfItx6EzxvhYCZtPu
         8X5A==
X-Forwarded-Encrypted: i=1; AJvYcCW+eGjsr6J47myOagIq6dWbjiDvOpowpNz29+dLAIZgNLA4grJzsWp0myYLv3av60yjfbCJVmS1cHcw/BzxF8hj4eZ2hvD+SjFqytCY
X-Gm-Message-State: AOJu0YzG4TGlqUsx7KAAEpjGHZJHuVV1e5EgA4dttL6d4i1yqv2zzBDU
	iGWdoFqDvLJw4snTR2Nmf4pSKZbnKoDQQ3xdN9xEp9SV/pqQ7c/l2MC9VC3A+tHjm5zdSxx6Hkp
	sBd0bmodhWcBmaRFBZCX1tfHK1BBNyR9tEWKo42aoJ10gC8yI8+UFWSpJXNowJc00kEIIiqjfnT
	MW7Q==
X-Received: by 2002:a50:a693:0:b0:56e:2cb6:480e with SMTP id e19-20020a50a693000000b0056e2cb6480emr5037847edc.38.1714851291521;
        Sat, 04 May 2024 12:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxa0bKw9XZSPRzRQBk5sICnCx31i0zneLUhKIf2Xqa/AxILKx9IuvkMH2j2eNM0zWghhKyQ==
X-Received: by 2002:a50:a693:0:b0:56e:2cb6:480e with SMTP id e19-20020a50a693000000b0056e2cb6480emr5037835edc.38.1714851291333;
        Sat, 04 May 2024 12:34:51 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b00572d255e342sm2227021edb.10.2024.05.04.12.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 12:34:50 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Terrell <terrelln@fb.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v2 2/2] riscv: show help string for riscv-specific targets
Date: Sat,  4 May 2024 21:34:39 +0200
Message-ID: <20240504193446.196886-3-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504193446.196886-1-emil.renner.berthing@canonical.com>
References: <20240504193446.196886-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define the archhelp variable so that 'make ACRH=riscv help' will show
the targets specific to building a RISC-V kernel like other
architectures.

Tested-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/Makefile | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 07ff2f34f0dc..ae51720199a3 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -201,3 +201,20 @@ rv32_defconfig:
 PHONY += rv32_nommu_virt_defconfig
 rv32_nommu_virt_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
+
+define archhelp
+  echo  '  Image		- Uncompressed kernel image (arch/riscv/boot/Image)'
+  echo  '  Image.gz	- Compressed kernel image (arch/riscv/boot/Image.gz)'
+  echo  '  Image.bz2	- Compressed kernel image (arch/riscv/boot/Image.bz2)'
+  echo  '  Image.lz4	- Compressed kernel image (arch/riscv/boot/Image.lz4)'
+  echo  '  Image.lzma	- Compressed kernel image (arch/riscv/boot/Image.lzma)'
+  echo  '  Image.lzo	- Compressed kernel image (arch/riscv/boot/Image.lzo)'
+  echo  '  Image.zst	- Compressed kernel image (arch/riscv/boot/Image.zst)'
+  echo  '  vmlinuz.efi	- Compressed EFI kernel image (arch/riscv/boot/vmlinuz.efi)'
+  echo  '		  Default when CONFIG_EFI_ZBOOT=y'
+  echo  '  xipImage	- Execute-in-place kernel image (arch/riscv/boot/xipImage)'
+  echo  '		  Default when CONFIG_XIP_KERNEL=y'
+  echo  '  install	- Install kernel using (your) ~/bin/$(INSTALLKERNEL) or'
+  echo  '		  (distribution) /sbin/$(INSTALLKERNEL) or install to '
+  echo  '		  $$(INSTALL_PATH)'
+endef
-- 
2.43.0


