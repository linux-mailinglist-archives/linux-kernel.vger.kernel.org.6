Return-Path: <linux-kernel+bounces-367298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB769A0095
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4350E284DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD2418BC1E;
	Wed, 16 Oct 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHdr3Mer"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66918BB9A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056476; cv=none; b=QXNfsbQcY8QXVjUuXiy1E+KCfkmfGxLluplN40Qdk9lKEBByJhO1IycNRTqWKN/WD7XxEbvv2OlT5pD08sSOaXuYe4mruTGmdVrRd6SktAFnSGImyKf6qjKpiO8UVdAxH0Qerw0nurTX0s0NvVi+8JvnJxYSjeravIloJ00n0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056476; c=relaxed/simple;
	bh=wr9djLuiLRmtMV+CDqPeySU/5of2llOuI/71PgvqERY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ly97jLx0HPnX0mg4gt3JhU6kG3lZZnDIuoe/03X77kM3HMl7fYH3XbPDxgzERK6FHS3CFr+sRNymTcMbzmZeLbq8yPdKjizgWTqRkD1Nb8Ep+fJND92bM/PXQfzz4rAUnypZaElCFJeYlPrf5kWJMl6bm2gTEtzO2BdEyRM+OWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHdr3Mer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB302C4CED0;
	Wed, 16 Oct 2024 05:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729056476;
	bh=wr9djLuiLRmtMV+CDqPeySU/5of2llOuI/71PgvqERY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHdr3MerMlcwzZt8JbxVEmf1NYGkI5fPbGmI5gET1LwwZqpe30GPz7DGMVSyhcTQT
	 0VGNb42hAmq2chOSY6VcCExtSg+clAaTnE6aq0qLfgR9N2W1RfU/eA1ATOkZTJVj2V
	 tFLXj1s4lghCpI8Guw27d8tzGRYCF9D9MaBtKcox7MOBStqprr4TsJnISpcl/BKf0H
	 WdaBqLrtfKk7eJRLFqSnnDJZpiJwgi4OpmufebcyolmVqNHshQWNKzVOuf4L/M6n1l
	 C2lbCwwrFMsa7heQf1OHr2kN8+9P6Cnc4NNkQMNEhoedRsdIRTbpvUnB3N0U4v0sKT
	 VJjFITYr2dw3Q==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] ARC: build: disallow invalid PAE40 + 4K page config
Date: Tue, 15 Oct 2024 22:27:48 -0700
Message-ID: <20241016052749.1640081-3-vgupta@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016052749.1640081-1-vgupta@kernel.org>
References: <20241016052749.1640081-1-vgupta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config option being built was
| CONFIG_ARC_MMU_V4=y
| CONFIG_ARC_PAGE_SIZE_4K=y
| CONFIG_HIGHMEM=y
| CONFIG_ARC_HAS_PAE40=y

This was hitting a BUILD_BUG_ON() since a 4K page can't hoist 1k, 8-byte
PTE entries (8 byte due to PAE40). BUILD_BUG_ON() is a good last ditch
resort, but such a config needs to be disallowed explicitly in Kconfig.

Side-note: the actual fix is single liner dependency, but while at it
cleaned out a few things:
 - 4K dependency on MMU v3 or v4 is always true, since 288ff7de62af09
   ("ARC: retire MMUv1 and MMUv2 support")
 - PAE40 dependency in on MMU ver not really ISA, although that follows
   eventually.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409160223.xydgucbY-lkp@intel.com/
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5b2488142041..69c6e71fa1e6 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -297,7 +297,6 @@ config ARC_PAGE_SIZE_16K
 config ARC_PAGE_SIZE_4K
 	bool "4KB"
 	select HAVE_PAGE_SIZE_4KB
-	depends on ARC_MMU_V3 || ARC_MMU_V4
 
 endchoice
 
@@ -474,7 +473,8 @@ config HIGHMEM
 
 config ARC_HAS_PAE40
 	bool "Support for the 40-bit Physical Address Extension"
-	depends on ISA_ARCV2
+	depends on MMU_V4
+	depends on !ARC_PAGE_SIZE_4K
 	select HIGHMEM
 	select PHYS_ADDR_T_64BIT
 	help
-- 
2.43.0


