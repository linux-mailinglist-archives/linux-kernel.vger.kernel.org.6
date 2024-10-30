Return-Path: <linux-kernel+bounces-388450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB239B5FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C70C2826D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBAB1E4106;
	Wed, 30 Oct 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oh/Wf/FS"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D91E3DC2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283512; cv=none; b=uOgw2jUGzl8Ur+hpwTHDBlyma982Su0N0faMw+lE2Ot8Ax20H64AC2f+atuhMS6OIBt3FO7yaWAkfYu4ydrtVhqqXCOP3PWqDZnfFhzwTd2zILSx63ICN9a+o6nK6sMKMTV3Ex8CebpcCqP+NXggyuoKvSF/wdYaO9inOk0SZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283512; c=relaxed/simple;
	bh=cugy6GlBGa3v9wa29HmC1qC4fs6FrTvVdz4A0bnA0Gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhdkYAQtIF12OdEVN79JBOIWmz+BcrelJmfsQ04hCfFdM9aB4q3ImDN+0Wmq2MliMfo17AEAt6+U3RztVEPVLUee5KhslLEZq34qJCr+ujaVK3SMlvCpFc847T4prJzMWNzZJgDr9o2WJLGbtbKez0AOhNmAT0Wx1u+BdRF7LhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oh/Wf/FS; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d45de8bbfso4454272f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283508; x=1730888308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCB5nfE7CGuNRBvDe++G1u/AhX4jCAZ21H5NNpZdneM=;
        b=Oh/Wf/FSzgfqvACkWQiUKtuxHYGe/342fXJHhNfTqqMNxla6MQtII3WXgf++fxImbG
         IQ5HihItwv+NRNOJGXBZ/ySnxBlNEAQdHADUXuB8dYLDrCSlTjuVDMDadBMU2S5BD869
         MrYwPpujt3W+pWR0BGNLeAVBv1lxcWTXGWQ/6HqrRjuz9XI8LEU53/CcwJvCr1wvRywf
         VI+VCtzmz0DEIXoCpfRz8YNTLY4oKorYuH8vMRAiFUtT6LSNQ6bnPS3i5hac2QU+Xc6U
         alvvV8lbEDfPnHDBCAKcDx3svd02NSi4dCR9Ny0GBgcDWuTycqlbmqb+pGQmKu7fCyju
         MvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283508; x=1730888308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCB5nfE7CGuNRBvDe++G1u/AhX4jCAZ21H5NNpZdneM=;
        b=fCdZcEzoRAM/InMoKerQHV5COZIwfnfCkSRH/llrWIXGmQ9HBABKZcZwJUtsqSwaUP
         9hABXrVdWYWBpHYQYOK8/vWzaF+EZwW1p3z2uUFuObH1jWCGOaYPQKZxKJVpdn6dxLso
         dverKWXX7ZpMaTSk+2CrFXIGo3Y5wi7VLm8whpDXtyk7UC8US35G1P15rmNgJO2Xaur5
         HnHuwEE6C8tdrjDapEz2HvxB+FC0m3rRcv1etoGdSN+sXFQ4KEJZrbgOsacEf8Fb/s2t
         Oq4fhsf5ev9ICAgjA8E84qdVeGwbA9yXRmjq+WWWN8GxCMg1r2KKeagajrdnLzUYyuPJ
         2rMA==
X-Gm-Message-State: AOJu0YxU+N4wexVX3On2FzhRR5bzJuqQavMD5VjSfbNcqrmFOfxgpDzW
	60z6EKgsFJ6ky+bnZtBt3ud8VW9ltVQ9goxdJ4hcD4Ck0OM+hydb+E5RhWYnshzl6R1d4Q==
X-Google-Smtp-Source: AGHT+IH4tMMcP9ENuBVAD8pIlbbZTGfAbTgfXdsdcBy01t2vMHHwycPrtUm3l2DZ83XxryT9zDG5yMKk
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:adf:f551:0:b0:37c:d162:8289 with SMTP id
 ffacd0b85a97d-380612281c3mr9870f8f.10.1730283508476; Wed, 30 Oct 2024
 03:18:28 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:05 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=ardb@kernel.org;
 h=from:subject; bh=VuHW66kh3SrzeofrGytIHYJsJQA3k3osacidUqjC91c=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/W7XOsuH/Kd2h5y8J60kczJ8TXYDx74Jz/etkPzYa
 Mjj5WvRUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYS94fhr+iqt7mP91+MuW97
 Omn+Hc536Vmsa2W7Jv1IfWp0kMN6cgQjw67VgjcvcT2quZ2S0enprazpknZsq/5FwzgVId25cSk l/AA=
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-11-ardb+git@google.com>
Subject: [RFC PATCH 1/8] arm64: Kconfig: force ARM64_PAN=y when enabling TTBR0
 sw PAN
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

We have a couple of instances of Kconfig constraints where PAN must be
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
index 232dcade2783..ec218ef22f2b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1368,7 +1368,6 @@ config ARM64_VA_BITS_48
 
 config ARM64_VA_BITS_52
 	bool "52-bit"
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable 52-bit virtual addressing for userspace when explicitly
 	  requested via a hint to mmap(). The kernel will also use 52-bit
@@ -1420,7 +1419,6 @@ config ARM64_PA_BITS_48
 config ARM64_PA_BITS_52
 	bool "52-bit"
 	depends on ARM64_64K_PAGES || ARM64_VA_BITS_52
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable support for a 52-bit physical address space, introduced as
 	  part of the ARMv8.2-LPA extension.
@@ -1667,6 +1665,7 @@ config RODATA_FULL_DEFAULT_ENABLED
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	depends on !KCSAN
+	select ARM64_PAN
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved
@@ -1923,7 +1922,6 @@ config ARM64_RAS_EXTN
 config ARM64_CNP
 	bool "Enable support for Common Not Private (CNP) translations"
 	default y
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Common Not Private (CNP) allows translation table entries to
 	  be shared between different PEs in the same inner shareable
@@ -2118,7 +2116,7 @@ config ARM64_MTE
 	depends on AS_HAS_ARMV8_5
 	depends on AS_HAS_LSE_ATOMICS
 	# Required for tag checking in the uaccess routines
-	depends on ARM64_PAN
+	select ARM64_PAN
 	select ARCH_HAS_SUBPAGE_FAULTS
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_USES_PG_ARCH_2
-- 
2.47.0.163.g1226f6d8fa-goog


