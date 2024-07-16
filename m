Return-Path: <linux-kernel+bounces-253538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7D9322A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9222823CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287E195FE3;
	Tue, 16 Jul 2024 09:22:00 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345D5FEE6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121720; cv=none; b=N/80YPcX1MhOaUlpMwf+TRTdBABZCzBYgJBxjmD2CAtt21QNV5cSUmeVRDRcXO7Kl1qATXvD7GI/vf3urJ7Xczj54EPOYs98GjoOb9G5T1CPU2HYjnI2/ghmG93HPVc98Q6NvHGR6yoHMO6hcTURHnqyD6Y8pKbecmPaXSaAAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121720; c=relaxed/simple;
	bh=qYJbUY+Ga+y8iCtUVkTvpbFj7bBv86EI6/kY5KdWlAc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LtgOwwYWroqn7TlmC7CEGtDA/KrPi0dTsae3TTFO5tmM9Dv/Xnj+p9YMUZ6u9VhKZbFZmYj8ybMY5KUnKtfqPnD4xlQy531FQGioUmcDjEsTzciBu3TOl6+Li4tqUcMjF6ZEliudVZpp6I1vWdnpnavRvyzwMIsP2RfkVJ4v7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.51 with ESMTP; 16 Jul 2024 17:51:54 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.151 with ESMTP; 16 Jul 2024 17:51:54 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gunho Lee <gunho.lee@lge.com>,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH] arm64: set MITIGATE_SPECTRE_BRANCH_HISTORY to n by default
Date: Tue, 16 Jul 2024 17:51:36 +0900
Message-Id: <20240716085136.4160-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

lmbench shows 25% performance regression after MITIGATE_SPECTRE_BRANCH_HISTORY
is enabled. This performance drop may be more significant than mitigating
the spectre-BHB. This patch changes this security option to disable by default
and makes it selectable.

- lat_syscall result with MITIGATE_SPECTRE_BRANCH_HISTORY enabled (cortex-a78)
write call      0.2777  0.2810  0.2824  0.280367
read call       0.3435  0.3452  0.3443  0.344333

- lat_syscall result with MITIGATE_SPECTRE_BRANCH_HISTORY disabled (cortex-a78)
write call      0.2101  0.2117  0.2116  0.2111
read call       0.2732  0.2744  0.2763  0.274633

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..be76f425c060 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1626,7 +1626,7 @@ config UNMAP_KERNEL_AT_EL0
 
 config MITIGATE_SPECTRE_BRANCH_HISTORY
 	bool "Mitigate Spectre style attacks against branch history" if EXPERT
-	default y
+	default n
 	help
 	  Speculation attacks against some high-performance processors can
 	  make use of branch history to influence future speculation.
-- 
2.17.1


