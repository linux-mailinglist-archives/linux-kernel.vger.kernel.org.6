Return-Path: <linux-kernel+bounces-356415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED79960D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91F51F25E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2CA17C9B9;
	Wed,  9 Oct 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v9IcLZCq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1FE166307
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458878; cv=none; b=eLDZk6ds4p1APzXo59BTT1j5lrgZXfHtPol0NqLn1y+KdOSTrdRcPiM6rFtgCwctsOVzJV633BKLfThsdatbWri0/i3mIwk7+Ch16IFXpmjGj1mz0vTnw9fnhCRW6BEcnmz4XYmKUdXF0FF8zqKue/OD4UPweXy3pxg1vd7VdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458878; c=relaxed/simple;
	bh=a5E+8a//JAd08ORK3xVyG7pqkxZjq6wxvjFwDTOXSwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iEKA0Q5lP/3k3u2LBPSfNrV+jSRwAcBbXul1bfcmi6WUFBV8bUwEUTUNvGeBUhHuSiGltTKCvpndHK09no0J50LK4lMwv7NBEtkaGDVr5csB1Zel6pXEnosT9DmyEeyGub1faXjrDUMkScNfQvoZ297PH4Mi7KnIxJP/sj2oRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v9IcLZCq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so66406105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728458874; x=1729063674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ptmB7S0LctNy2c3zE9ySdgHDTmsXSWnpMdU0vVeLDg=;
        b=v9IcLZCqjbVDFm2bDoocXm1qmN/gRd4jfqLMFJE3R4QtoLaODtbsvR4oqdtIMlFjs+
         sBfAuafMSyqLTltfxgnOSYYaTW9HPpn+PEB5Dyic5zegI0GUWy4FGYoEqOzZgKONlqMG
         LnGC/Miz4/psdHZ2GBLQDCviCsQxxgv5wzQUi2bPXMgw1H/rjyJLmNRPMcmHfEhjvGdG
         oieDv+yYKZU/v3BVEgWpTQg7XYel8qfrNExIoWNbtFExRbkqu95a/elPlbiHVbmrBQ2u
         xxM0PqqZUE/+EiHOWr6D5MHU0HpiQcqIWS9q8S1u9H8J2hftd5BIcamsBuuYxs3m62W2
         Md+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458874; x=1729063674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ptmB7S0LctNy2c3zE9ySdgHDTmsXSWnpMdU0vVeLDg=;
        b=svTmFuuiIQvGoyQxajiTbyiMaE/sRugy1tFTqJigHkLgDQCAXg7PTWXWPD0M958doi
         fWFszPxEIF1iv5IIYJE2an56TRQ4BK+iIHRBpIpEGgHSdqx3N99lr/sqCrj/FUwj+1ny
         beAKFFPQ7/EPK4N9ry7b3C3ltnqhdX5WhVMFMSVBWSrFpi27qqIZqWnf7F0IBRFo/1o6
         H1ki0LnZOrYpmr26ky+wQJJD4imK4ATNd3rqd2eGwagLJJXfUt9P2VihljVn9l8cRNOC
         YiKI0we38P0R2d+kjxmRx5l0s+gDtr73pk/REog6o53yCvRCfGwBkNkkeine8SYFam+z
         UJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHBwhb/oFezRfNSrw+Tc8zungh9MmQcdvKgWP9vWzczdmEmyktl9Po/hAa80n1q6cZTWZ9XUxOATvhcXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6ncM4vrJ11q5nNDanGF4jqU79wtuMCMxvwnFWoFXMzxe/NSK
	teeS8MJoVIc7wiO4eyZHQHWPTzG4BSK1h7J0zNagez9NEqo5cbx6GsIeyzWGvFM=
X-Google-Smtp-Source: AGHT+IH8tMgk+bXicF051ZBDsXltfKaJUiyBqM8XWScG+ZYwForWjazqlcyOrOg5Qj6tPEtQ++uzag==
X-Received: by 2002:a05:600c:34d2:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-430ccf1b03fmr9473025e9.10.1728458873828;
        Wed, 09 Oct 2024 00:27:53 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf31b35sm11178275e9.3.2024.10.09.00.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:27:53 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jason Montleon <jmontleo@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes] riscv: Do not use fortify in early code
Date: Wed,  9 Oct 2024 09:27:49 +0200
Message-Id: <20241009072749.45006-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Early code designates the code executed when the MMU is not yet enabled,
and this comes with some limitations (see
Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").

FORTIFY_SOURCE must be disabled then since it can trigger kernel panics
as reported in [1].

Reported-by: Jason Montleon <jmontleo@redhat.com>
Closes: https://lore.kernel.org/linux-riscv/CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com/ [1]
Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/errata/Makefile    | 6 ++++++
 arch/riscv/kernel/Makefile    | 5 +++++
 arch/riscv/kernel/pi/Makefile | 6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index 8a2739485123..f0da9d7b39c3 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -2,6 +2,12 @@ ifdef CONFIG_RELOCATABLE
 KBUILD_CFLAGS += -fno-pie
 endif
 
+ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
+ifdef CONFIG_FORTIFY_SOURCE
+KBUILD_CFLAGS += -D__NO_FORTIFY
+endif
+endif
+
 obj-$(CONFIG_ERRATA_ANDES) += andes/
 obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
 obj-$(CONFIG_ERRATA_THEAD) += thead/
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 7f88cc4931f5..69dc8aaab3fb 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -36,6 +36,11 @@ KASAN_SANITIZE_alternative.o := n
 KASAN_SANITIZE_cpufeature.o := n
 KASAN_SANITIZE_sbi_ecall.o := n
 endif
+ifdef CONFIG_FORTIFY_SOURCE
+CFLAGS_alternative.o += -D__NO_FORTIFY
+CFLAGS_cpufeature.o += -D__NO_FORTIFY
+CFLAGS_sbi_ecall.o += -D__NO_FORTIFY
+endif
 endif
 
 extra-y += vmlinux.lds
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index d5bf1bc7de62..81d69d45c06c 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -16,8 +16,12 @@ KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 KBUILD_CFLAGS	+= -mcmodel=medany
 
 CFLAGS_cmdline_early.o += -D__NO_FORTIFY
-CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
 CFLAGS_fdt_early.o += -D__NO_FORTIFY
+# lib/string.c already defines __NO_FORTIFY
+CFLAGS_ctype.o += -D__NO_FORTIFY
+CFLAGS_lib-fdt.o += -D__NO_FORTIFY
+CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
+CFLAGS_archrandom_early.o += -D__NO_FORTIFY
 
 $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
 			       --remove-section=.note.gnu.property \
-- 
2.39.2


