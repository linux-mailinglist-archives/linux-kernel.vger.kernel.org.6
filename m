Return-Path: <linux-kernel+bounces-429450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7EB9E1C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21788284703
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC311E5733;
	Tue,  3 Dec 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAdJ8xP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875A1E4919
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229448; cv=none; b=IRDI4T5VL6nhZVwRfXtpD9YHZ38mTH3/ky2QsnsbsJvMxqEt1aDLzHnoDKdR6v/8MAAiDlZGojMUTp8F389ExRWZZXuxcZdY/4YAEYHx3tc5MgIMyH2e46Bzycm7gKKVXHkT0iFk/HRuceVACM5YjI/xkEoxmRposJj731EU0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229448; c=relaxed/simple;
	bh=69QcTpbm8HYAOEez/L3Ux7Gj2eB8EOWegOb73arSY9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N24FDY+DAm6Xq0meHg76k7qL7SRaRv/SipjbGMLc0tTjjXGPmC83eBdgGJpYRa1W1+TBEYeIavHhpuN9VkIt+19CyU/qrCN48a/hBqfFtmErB7gRsiVQqA5+kKYZOoKHtvwlgcLbmkTlJzMpWPb5Vb6HG1529wvY5o0nyPlI2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAdJ8xP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F88CC4CECF;
	Tue,  3 Dec 2024 12:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229448;
	bh=69QcTpbm8HYAOEez/L3Ux7Gj2eB8EOWegOb73arSY9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=eAdJ8xP11KMa4dw/P2p5f0dF61hJ8OlvUOKtLwvyvXvCFCzsKOrfx47mDJdfFXzFo
	 lzL18hX1CKWxmQod0RQqfKADCsBVZXlhtd5Rqjy3o/kwjFkwOCWhFqgJctaay9SFOd
	 8Ofc/mD5fArxkigj+/8Y1FkI+UepRHpULZgQ1CihbPImMRX2xrjPahmsmceVv5BPzH
	 WNI0mIgeGxNuYzKeGimbX60nFcjZ9LGrEBXlA0txsXATkCPq3uD84IdbI3DZaRFDaL
	 f8UHmxPbA12uUJlawWSKRgdmHWOvfAXzdVuoFDev97NgN++jWar+oTAzZeY6iZFWZF
	 qS5BlTSZMjANw==
From: Leon Romanovsky <leon@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARC: build: Try to guess GCC variant of cross compiler
Date: Tue,  3 Dec 2024 14:37:15 +0200
Message-ID: <00d3173fe207ab9ba85dc974777a6ccb4656b03c.1733229205.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

ARC GCC compiler is packaged starting from Fedora 39i and the GCC
variant of cross compile tools has arc-linux-gnu- prefix and not
arc-linux-. This is causing that CROSS_COMPILE variable is left unset.

This change allows builds without need to supply CROSS_COMPILE argument
if distro package is used.

Before this change:
$ make -j 128 ARCH=arc W=1 drivers/infiniband/hw/mlx4/
  gcc: warning: ‘-mcpu=’ is deprecated; use ‘-mtune=’ or ‘-march=’ instead
  gcc: error: unrecognized command-line option ‘-mmedium-calls’
  gcc: error: unrecognized command-line option ‘-mlock’
  gcc: error: unrecognized command-line option ‘-munaligned-access’

[1] https://packages.fedoraproject.org/pkgs/cross-gcc/gcc-arc-linux-gnu/index.html
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 arch/arc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 2390dd042e36..fb98478ed1ab 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,7 +6,7 @@
 KBUILD_DEFCONFIG := haps_hs_smp_defconfig
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
+CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux- arc-linux-gnu-)
 endif
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
-- 
2.47.0


