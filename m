Return-Path: <linux-kernel+bounces-532533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75728A44EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923893AA10C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4120E31F;
	Tue, 25 Feb 2025 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4QWIyo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21954199396
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519343; cv=none; b=Wg7/qd1bc0A+eMNPiCmjXsTLRZZfrd9bnDLB5V9YNF8jt3dveLe+EP7TpcuEjXO67xzKKF4PW2nqPpFZI/mIoWMD4ZxgweDLFfEMghwXUcfchSExJ7wrZ6tuWZccykWWK1edN6QBzdScu/hYKPgIN1vbj2vunddhwkPsuFGM4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519343; c=relaxed/simple;
	bh=XJj6XvkQZvZnU7KV6XAood8YWkTdHu5c0H1A7ovBxzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jsceNa1LKWJ9KiSlk3L//sIDCbtLnZVlQhZDx1TaOARsTU36Rz51OUpXhh/eye1EwXZmfsLAd55zsAJcssl7fCctaHTHPSVMl5K7ZsWiNPPyAGef/B9G7aUpKH3O4UGC/4xdWXdF3jZVL0CWPcHaOQWxhOEluRmgV5UFzjLXd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4QWIyo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33E7C4CEDD;
	Tue, 25 Feb 2025 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740519342;
	bh=XJj6XvkQZvZnU7KV6XAood8YWkTdHu5c0H1A7ovBxzA=;
	h=From:To:Cc:Subject:Date:From;
	b=W4QWIyo+ORQaPhjAKpxtAyBeafgO/6U/xTq6EytlUr0Uz8heSzfshCaIyL7vU+tJR
	 WQtV1sSGREk12FhQJOIxuU4gW2pzest2Qzjgd74VM7dUbAbHL/oCN7GrzVq8RN3MXW
	 pPfKHUdTym7mzGyeRVIoChmJ3uu+xmW7o24EaPzgIDie2n9GHzouLYoQAAkBIPHJuL
	 rS9FL4fB6jgthJtfTSPJDs7Hx/fJcHfj1YSFtOBxoPy9cri7yCNJk1aBhBK2whcPqq
	 kN6q2tVKUXUDtvAbBEiwnG1hEp6wL8wrjo+OZZe9F+9mJ7onV46DrisiMzc0rKOvVE
	 DjsTZXG/0KZ8g==
From: Arnd Bergmann <arnd@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: fixmap: make __end_of_early_ioremap_region an enum value
Date: Tue, 25 Feb 2025 22:35:34 +0100
Message-Id: <20250225213539.3236070-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows warnings for the __end_of_fixed_addresses
definition:

    In file included from mm/early_ioremap.c:18:
    arch/arm/include/asm/fixmap.h:39:35: error: '__end_of_fixed_addresses' defined but not used [-Werror=unused-const-variable=]

Move the calculation slightly up in the file into the enum that
contains __end_of_fixmap_region and __end_of_early_ioremap_region.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/fixmap.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 707068f852c2..90e0bd79b180 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -33,12 +33,11 @@ enum fixed_addresses {
 
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
-	__end_of_early_ioremap_region
-};
+	__end_of_early_ioremap_region,
 
-static const enum fixed_addresses __end_of_fixed_addresses =
-	__end_of_fixmap_region > __end_of_early_ioremap_region ?
-	__end_of_fixmap_region : __end_of_early_ioremap_region;
+	__end_of_fixed_addresses = __end_of_fixmap_region > __end_of_early_ioremap_region ?
+				   __end_of_fixmap_region : __end_of_early_ioremap_region,
+};
 
 #define FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
 
-- 
2.39.5


