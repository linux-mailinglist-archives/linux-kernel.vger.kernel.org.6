Return-Path: <linux-kernel+bounces-433501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB839E5951
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142C718862BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB7221453;
	Thu,  5 Dec 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLFIAAc7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFC21D5B7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411010; cv=none; b=MkPD8pHZCioigk0uDAVh6GNsGI2hsevZychC+PaE+t2kHJ72NQrfKwuiifKm8ZnfT9icAHrQ5iwTJ9cJKlmdL0gv62eH2nStlA9wJzMZ6QM5v8Ee4B8BYBKyMDSLPkuqBAl3Lf0pVMV88Vk7uf8r0KiQJ1a0GiVGMkqF0CDXGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411010; c=relaxed/simple;
	bh=kaiW/ZwW37iz5KlWCsiGEeuD0GmC2bDPKh/qrQmS0I0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pFHFGvTcyos+dbWOU9jT30SbQaz66N7yvCiV5AtlG9maqqrdmZBplcrxURVeYtHSADO1rMDE0W9H3mQZNf4QCo4a5vGJPOFNkyMjErADA7T7TiOF4lQw/ve38lAb54WgCinACDYg2DPW97AJPwqwTQDCileb+VWdt6LW7X3ldnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLFIAAc7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4349eeeb841so7240515e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733411008; x=1734015808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxhk2o0tAc4zIrdHxGtBhCpg5dWRaRnoqVjOuRbuph0=;
        b=yLFIAAc78f2tonwoBuWmNSDA5CNOBhS14aKGA5gw+x4Zc+Iu16Pm+2Tf8WlvxVemHU
         qQjB/vliz737mio94XEEL3XIZmYSmc1CcTXGUa7Y2YLvoYXeK1ppCB83RtOyc/q3piJ4
         U5Qdgtvqtp7aioZL/CwdrBSw7TKdTvX9mhYvzNiVXPLUPJq2rq+xfB8PggXnjlHB9Rb9
         RmIHw2g7sfu2DzGwMvmtIxxq+OMKF6UbJGbz+ZdOuvu8TYlvm18yrLkfDiGFQk3gcVOa
         LVqDX5enGEwEk29YlbhfB6Sqx2LOJvXjl5ZOBUOSM4Cb5yVYMI5FQyf7nDkn/uC8PDav
         2tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411008; x=1734015808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxhk2o0tAc4zIrdHxGtBhCpg5dWRaRnoqVjOuRbuph0=;
        b=FHGB5vbdLvuFwaofu94i+Yu77QfgRWHJ5TQ9VPiWStYXHK6V/+qLEBDSKDr9yxcAfJ
         bTEbedrwIjWll8CC3p2l75ce3ZaDfQ79QYMFMb+ZbibVYB2vFBHih54wcRQk3cPuIitm
         BYNirn9/qGQtsyshR9c9IX0TRlZIbY43hN1V6zjbAYQRzrX7+rctZHB3iwD/iduDPLFJ
         UgJo5WJAGquxEEWmkj1hAVslRW0SUkPrKpF2t8CvMVuiAZ85vYwlKjOM/cUc/OFpcC9t
         6Yg/4lFJ9BBQptQN+oDmAgSBfMrd6VIw3i3ALxxdm37F8XyVebGQQRGN/DBVPw+V5Ui3
         cUjQ==
X-Gm-Message-State: AOJu0YyJNEQ6zDMnyqf3H8DgHjJN12EBo5EZlezKLPvAEonxF6WAUw1p
	v/qb1r648gHOdxNmYBUs9qqRLLj/ZqcUsS6yCP2G9rGq4mGc2a2d8qv9LcOXlPPeEcaWhQ==
X-Google-Smtp-Source: AGHT+IGK+uqdrolwBE/YK0GzQSi2JfIN1swfXk1Cl/uS2VCNW+v/H02aP5idPYHHs/NRxJPEYLwBvIPp
X-Received: from wmbd6.prod.google.com ([2002:a05:600c:58c6:b0:434:a471:130f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:184c:b0:385:df73:2f24
 with SMTP id ffacd0b85a97d-385fd418d72mr9456469f8f.39.1733411007685; Thu, 05
 Dec 2024 07:03:27 -0800 (PST)
Date: Thu,  5 Dec 2024 16:02:35 +0100
In-Reply-To: <20241205150229.3510177-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205150229.3510177-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2690; i=ardb@kernel.org;
 h=from:subject; bh=nNzKrIEGl5/jzZq+G376hZKl+MZq0c7mORI7knhQaps=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3wQG9+RtOixbsYNq4JUL8kkbBoa67TClvXWOHDh+ub4
 lvqRao7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQSJjAyrKpamhqhsPpueoj2
 vnM+bCJGR+JXxx74/71z55d9FTvqnzMyrHjDzDGpYem2TsVDjDN9DVSf+la5LIyb+q/csYojo8i THQA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205150229.3510177-13-ardb+git@google.com>
Subject: [PATCH v2 5/6] arm64: Kconfig: force ARM64_PAN=y when enabling TTBR0
 sw PAN
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

There are a couple of instances of Kconfig constraints where PAN must be
enabled too if TTBR0 sw PAN is enabled, primarily to avoid dealing with
the modified TTBR0_EL1 sysreg format that is used when 52-bit physical
addressing and/or CnP are enabled (support for either implies support
for hardware PAN as well, which will supersede PAN emulation if both are
available)

Let's simplify this, and always enable ARM64_PAN when enabling TTBR0 sw
PAN. This decouples the PAN configuration from the VA size selection,
permitting us to simplify the latter in subsequent patches. (Note that
PAN and TTBR0 sw PAN can still be disabled after this patch, but not
independently)

To avoid a convoluted circular Kconfig dependency involving KCSAN, make
ARM64_MTE select ARM64_PAN too, instead of depending on it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a048c5..c1ca21adddc1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1379,7 +1379,6 @@ config ARM64_VA_BITS_48
 
 config ARM64_VA_BITS_52
 	bool "52-bit"
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable 52-bit virtual addressing for userspace when explicitly
 	  requested via a hint to mmap(). The kernel will also use 52-bit
@@ -1431,7 +1430,6 @@ config ARM64_PA_BITS_48
 config ARM64_PA_BITS_52
 	bool "52-bit"
 	depends on ARM64_64K_PAGES || ARM64_VA_BITS_52
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable support for a 52-bit physical address space, introduced as
 	  part of the ARMv8.2-LPA extension.
@@ -1681,6 +1679,7 @@ config RODATA_FULL_DEFAULT_ENABLED
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	depends on !KCSAN
+	select ARM64_PAN
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved
@@ -1937,7 +1936,6 @@ config ARM64_RAS_EXTN
 config ARM64_CNP
 	bool "Enable support for Common Not Private (CNP) translations"
 	default y
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Common Not Private (CNP) allows translation table entries to
 	  be shared between different PEs in the same inner shareable
@@ -2132,7 +2130,7 @@ config ARM64_MTE
 	depends on AS_HAS_ARMV8_5
 	depends on AS_HAS_LSE_ATOMICS
 	# Required for tag checking in the uaccess routines
-	depends on ARM64_PAN
+	select ARM64_PAN
 	select ARCH_HAS_SUBPAGE_FAULTS
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_USES_PG_ARCH_2
-- 
2.47.0.338.g60cca15819-goog


