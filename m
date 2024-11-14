Return-Path: <linux-kernel+bounces-409299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6329C8B37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51912B27AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B91FAC5B;
	Thu, 14 Nov 2024 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dUK53AGH"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA39D193061
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588685; cv=none; b=VdCnkhlltaD09n1qT/JzknHSzJw5B/jlvuJxvqiuTsS33JPWg7wf7kBbNfGcAdoIxrsvIOmGCZ4GL9JMvibH7h+iOJy9YtTHuONAH8XeDH0DMk/karg+lidbLUSC6G3BhfWy3uzXyfB+BWOv9zgHi9NNvamD8jFXmJ3sPsnmCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588685; c=relaxed/simple;
	bh=8xBKLw/QyafHQcYYXMI7yOHzbv6VxbSR9wAhaY/KgTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm5OVJBC+4OJkhbaZyrulGrXtwHeiyX8Blruac+KNVLb2rWCjE+a21Jk2+6o6mpe5vngOeayVdfa1Qwsb2cS6HemxJHot2MHe/cdfPtcDAnTneDlk+0mLPH13kblhaWHyc02nu77skuclc95sD3qdNYJ0o/TX9IvDm7CJvNukBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=dUK53AGH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588678;
	bh=gveH/N0CtNog4hbJfsCvGaseWeD5OKc400GxRS3aWWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUK53AGH5uwIYS3zKAbZ6GFD2+1MikhI7blqulRSZdSKnSyotAcgaWkQSuRoJkCFB
	 gBI+Uv9P5e1dv/lsXyJfDaKLf5kPkmPigxDG2cF/fzmS26k2BSyKNuG7zPyx+0ZPC4
	 EsO2+7AZKjOKDt65exOR4jI1BCa8HAi5/NROaipSejv5aMLjKC1NlzMz2DZBzJ8ajc
	 4+XixCKiJnmqE8qw9vSG9y2Mgmoog2jXZRthPOuxponbfxtX2X/nA9ZhFxCotj6Fyo
	 Dxw8D9TY3lOO+H7Pphn60I5EkEFGZxxX76El8tZezXPYXbbDzceI4h4ODzyKtJOi/0
	 smxjZyZv7UkSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QG4qWNz4x8C;
	Thu, 14 Nov 2024 23:51:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 04/20] powerpc: Remove IBM_CELL_BLADE & SPIDER_NET references
Date: Thu, 14 Nov 2024 23:50:53 +1100
Message-ID: <20241114125111.599093-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symbols are no longer selectable so remove references to them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile           | 2 --
 arch/powerpc/configs/cell_defconfig  | 2 --
 arch/powerpc/configs/ppc64_defconfig | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1ff6ad4f6cd2..184d0680e661 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -173,7 +173,6 @@ src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
 src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
 src-plat-$(CONFIG_PPC_PSERIES) += pseries-head.S
 src-plat-$(CONFIG_PPC_POWERNV) += pseries-head.S
-src-plat-$(CONFIG_PPC_IBM_CELL_BLADE) += pseries-head.S
 src-plat-$(CONFIG_MVME7100) += motload-head.S mvme7100.c
 
 src-plat-$(CONFIG_PPC_MICROWATT) += fixed-head.S microwatt.c
@@ -276,7 +275,6 @@ quiet_cmd_wrap	= WRAP    $@
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_POWERNV)		+= zImage.pseries
-image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_PS3)			+= dtbImage.ps3
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 53f43a34e1a9..0a01908ec63a 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -25,7 +25,6 @@ CONFIG_PS3_DISK=y
 CONFIG_PS3_ROM=m
 CONFIG_PS3_FLASH=m
 CONFIG_PS3_LPM=m
-CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_RTAS_FLASH=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
@@ -133,7 +132,6 @@ CONFIG_SKGE=m
 CONFIG_SKY2=m
 CONFIG_GELIC_NET=m
 CONFIG_GELIC_WIRELESS=y
-CONFIG_SPIDER_NET=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_I8042 is not set
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index f39c0d000c43..f71f569c536a 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -51,7 +51,6 @@ CONFIG_PS3_DISK=m
 CONFIG_PS3_ROM=m
 CONFIG_PS3_FLASH=m
 CONFIG_PS3_LPM=m
-CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_RTAS_FLASH=m
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
@@ -228,7 +227,6 @@ CONFIG_NETXEN_NIC=m
 CONFIG_SUNGEM=y
 CONFIG_GELIC_NET=m
 CONFIG_GELIC_WIRELESS=y
-CONFIG_SPIDER_NET=m
 CONFIG_BROADCOM_PHY=m
 CONFIG_MARVELL_PHY=y
 CONFIG_PPP=m
-- 
2.47.0


