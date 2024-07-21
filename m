Return-Path: <linux-kernel+bounces-258181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FB69384C9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F81C2074E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F10166318;
	Sun, 21 Jul 2024 13:37:19 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FD1662E4
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569039; cv=none; b=HqiOQUZqsHuoUEx3+5DgU9T0oK5RK39POfuHa2iOJ/kyl0ctRfmE9SKH0bWoa+k68uzToEbaZEkFJTaUgjHcy0kK1TKuJ5hDePVePpZcHYeMk0KNcNlRsYdqH4vDWHSWAZnYGanH63AbETcCm867xR6GqGaDpJo6HXVAHGZlp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569039; c=relaxed/simple;
	bh=/l0bQd8jV2ZM904bI4KOKE9loyjRf92lqUsm27QAhfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJATQ/1aCr9GVzSAcmuaYpvH94Qmxwp/0jq1hGkWgDZ50Vp2Sb76s2/K4GR3Tob1KySlE5jU0P4UiiGMHdYYPvGIerI7ExN41DPkgrXvCdzQEGiWgZmJJlUHGidELkKrHkUwHMfc/PYVZ7iIr1uTL4852GD1ntCbm+BwFpmGdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id A732342E63;
	Sun, 21 Jul 2024 16:37:15 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkS-00000001SmU-15KU;
	Sun, 21 Jul 2024 16:37:15 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	Simon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jules Maselbas <jmaselbas@zdiv.net>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 15/16] arm64: boot: add Image.xz support
Date: Sun, 21 Jul 2024 16:36:30 +0300
Message-ID: <20240721133633.47721-16-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Image.* targets existed for other compressors already. Bootloader
support is needed for decompression.

This is for CONFIG_EFI_ZBOOT=n. With CONFIG_EFI_ZBOOT=y, XZ was already
available.

Cc: Simon Glass <sjg@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jules Maselbas <jmaselbas@zdiv.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 arch/arm64/boot/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 607a67a649c4..b5a08333bc57 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -17,7 +17,7 @@
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
 targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
-	Image.zst image.fit
+	Image.zst Image.xz image.fit
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -40,6 +40,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
 
+$(obj)/Image.xz: $(obj)/Image FORCE
+	$(call if_changed,xzkern)
+
 $(obj)/image.fit: $(obj)/Image $(obj)/dts/dtbs-list FORCE
 	$(call if_changed,fit)
 
-- 
2.45.2


